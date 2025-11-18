package openapi

import (
	"bytes"
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"
	"time"
)

type ProductoPedido struct {
	ID       int32  `json:"id"`       // ID del producto
	Tipo     string `json:"tipo"`     // "fisico" o "digital"
	Cantidad int32  `json:"cantidad"` // Cantidad solicitada
}

type Pago struct {
	Tipo       string `json:"tipo"`
	Numero     string `json:"numero"`
	CVV        string `json:"cvv"`
	Expiracion string `json:"expiracion"`
}

type PedidoRequest struct {
	ClienteID int32          `json:"cliente_id"`
	Producto  ProductoPedido `json:"producto"`
	Pago      Pago           `json:"pago"`
}

type PedidoResponse struct {
	Mensaje string  `json:"mensaje"`
	Total   float64 `json:"total"`
}

// Estructura enviada al servicio de Estadísticas
type StatCompraAlbum struct {
	IDUsuario int32     `json:"idUsuario"`
	IDAlbum   int32     `json:"idAlbum"`
	Fecha     time.Time `json:"fecha"`
}

type StatCompraMerch struct {
	IDUsuario int32     `json:"idUsuario"`
	IDMerch   int32     `json:"idMerch"`
	Fecha     time.Time `json:"fecha"`
	Cantidad  int32     `json:"cantidad"`
}

func Pedido(db *sql.DB, req PedidoRequest) (*PedidoResponse, error) {
	tx, err := db.Begin()
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	// Validar pago (simulación simple)
	if len(req.Pago.Numero) != 16 {
		return nil, fmt.Errorf("numero de tarjeta invalido")
	}

	p := req.Producto
	var total float64

	switch p.Tipo {
	case "fisico":
		var stock int32
		var precio float64

		err := tx.QueryRow("SELECT stock, precio FROM merchandising WHERE id=$1", p.ID).Scan(&stock, &precio)
		if err != nil {
			return nil, err
		}
		if stock < p.Cantidad {
			return nil, fmt.Errorf("producto %d no tiene stock suficiente", p.ID)
		}

		// Reducir stock
		_, err = tx.Exec("UPDATE merchandising SET stock = stock - $1 WHERE id=$2", p.Cantidad, p.ID)
		if err != nil {
			return nil, err
		}

		total = float64(precio) * float64(p.Cantidad)

		// Enviar registro al servicio de estadísticas
		err = enviarCompraEstadisticas("merchandising", req.ClienteID, p.ID, p.Cantidad)
		if err != nil {
			return nil, fmt.Errorf("error enviando compra a estadísticas: %v", err)
		}

	case "digital":
		var precio float64
		err := tx.QueryRow("SELECT precio FROM album WHERE id=$1", p.ID).Scan(&precio)
		if err != nil {
			return nil, err
		}

		total = float64(precio) * float64(p.Cantidad)

		// Enviar registro al servicio de estadísticas
		err = enviarCompraEstadisticas("albumes", req.ClienteID, p.ID, p.Cantidad)
		if err != nil {
			return nil, fmt.Errorf("error enviando compra a estadísticas: %v", err)
		}

	default:
		return nil, fmt.Errorf("tipo de producto desconocido: %s", p.Tipo)
	}

	if err := tx.Commit(); err != nil {
		return nil, err
	}

	return &PedidoResponse{
		Mensaje: "Compra confirmada correctamente. Gracias por tu pedido.",
		Total:   total,
	}, nil
}

func enviarCompraEstadisticas(tipo string, idUsuario int32, idProducto int32, cantidad int32) error {
	var url string
	var data []byte
	var err error

	switch tipo {

	case "merchandising":
		url = "http://estadisticas-app:8080/compras/merchandising"

		payload := StatCompraMerch{
			IDUsuario: idUsuario,
			IDMerch:   idProducto,
			Fecha:     time.Now(),
			Cantidad:  cantidad,
		}

		data, err = json.Marshal(payload)
		if err != nil {
			return err
		}

	case "albumes":
		url = "http://estadisticas-app:8080/compras/albumes"

		payload := StatCompraAlbum{
			IDUsuario: idUsuario,
			IDAlbum:   idProducto,
			Fecha:     time.Now(),
		}

		data, err = json.Marshal(payload)
		if err != nil {
			return err
		}

	default:
		return fmt.Errorf("tipo de compra inválido: %s", tipo)
	}

	resp, err := http.Post(url, "application/json", bytes.NewBuffer(data))
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK && resp.StatusCode != http.StatusCreated {
		return fmt.Errorf("el servicio de estadísticas devolvió código %d", resp.StatusCode)
	}

	return nil
}
