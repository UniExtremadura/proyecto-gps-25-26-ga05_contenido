/*
 * Microservicio de Contenido - UnderSounds
 *
 * Este microservicio gestiona el contenido multimedia y comercial del proyecto \"UnderSounds\", incluyendo albumes, canciones, generos, merchandising y noticias musicales.
 *
 * API version: 1.0.0
 */

package openapi

import (
	"database/sql"
	"fmt"
)

type ProductoPedido struct {
	MerchID  int32 `json:"merch_id"`
	Cantidad int32 `json:"cantidad"`
}

type Pago struct {
	Tipo       string `json:"tipo"`
	Numero     string `json:"numero"`
	CVV        string `json:"cvv"`
	Expiracion string `json:"expiracion"`
}

type PedidoRequest struct {
	ClienteID int32            `json:"cliente_id"`
	Productos []ProductoPedido `json:"productos"`
	Pago      Pago             `json:"pago"`
}

type PedidoResponse struct {
	PedidoID int32  `json:"pedido_id"`
	Mensaje  string `json:"mensaje"`
}

func Pedido(db *sql.DB, req PedidoRequest) (*PedidoResponse, error) {
	tx, err := db.Begin()
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	total := 0.0

	// Verificar stock y actualizarlo
	for _, p := range req.Productos {
		var stock int32
		var precio float32
		err := tx.QueryRow("SELECT stock, precio FROM merchandising WHERE id=$1", p.MerchID).Scan(&stock, &precio)
		if err != nil {
			return nil, err
		}
		if stock < p.Cantidad {
			return nil, fmt.Errorf("producto %d no tiene stock suficiente", p.MerchID)
		}

		_, err = tx.Exec("UPDATE merchandising SET stock = stock - $1 WHERE id = $2", p.Cantidad, p.MerchID)
		if err != nil {
			return nil, err
		}

		total += float64(precio) * float64(p.Cantidad)
	}

	// Validar info de pago (simulación simple)
	if len(req.Pago.Numero) != 16 {
		return nil, fmt.Errorf("numero de tarjeta invalido")
	}

	// Crear pedido
	var pedidoID int32
	err = tx.QueryRow(
		"INSERT INTO pedido (cliente_id, total, estado) VALUES ($1, $2, $3) RETURNING id",
		req.ClienteID, total, "pagado",
	).Scan(&pedidoID)
	if err != nil {
		return nil, err
	}

	// Insertar items del pedido
	for _, p := range req.Productos {
		var precio float32
		err := tx.QueryRow("SELECT precio FROM merchandising WHERE id=$1", p.MerchID).Scan(&precio)
		if err != nil {
			return nil, err
		}

		_, err = tx.Exec(
			"INSERT INTO pedido_item (pedido_id, merch_id, cantidad, precio_unitario) VALUES ($1, $2, $3, $4)",
			pedidoID, p.MerchID, p.Cantidad, precio,
		)
		if err != nil {
			return nil, err
		}
	}

	if err := tx.Commit(); err != nil {
		return nil, err
	}

	return &PedidoResponse{
		PedidoID: pedidoID,
		Mensaje:  "Pago realizado correctamente, pedido registrado",
	}, nil
}
