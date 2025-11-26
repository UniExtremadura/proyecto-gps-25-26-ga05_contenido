package openapi

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strconv"
)

type UsuarioResponse struct {
	Id    int32  `json:"id"`
	Nombre string `json:"nombre"`
	Correo string `json:"correo,omitempty"`
}

// ObtenerNombreUsuario obtiene el nombre del usuario desde el microservicio de usuarios
func ObtenerNombreUsuario(usuarioID int32) (string, error) {
	url := "http://usuarios-app:8080/usuarios/" + strconv.Itoa(int(usuarioID))
	
	resp, err := http.Get(url)
	if err != nil {
		return "", fmt.Errorf("error al conectar con microservicio de usuarios: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return "", fmt.Errorf("usuario no encontrado (status: %d)", resp.StatusCode)
	}

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return "", fmt.Errorf("error al leer respuesta: %v", err)
	}

	var usuario UsuarioResponse
	if err := json.Unmarshal(body, &usuario); err != nil {
		return "", fmt.Errorf("error al parsear respuesta: %v", err)
	}

	return usuario.Nombre, nil
}
