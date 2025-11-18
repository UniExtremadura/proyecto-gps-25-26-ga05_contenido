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
	"net/http"

	"github.com/gin-gonic/gin"
)

type PedidoAPI struct {
	DB *sql.DB
}

func (api *PedidoAPI) Pago(c *gin.Context) {
	var req PedidoRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"status": "error", "message": "JSON inválido"})
		return
	}

	res, err := Pedido(api.DB, req)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"status": "error", "message": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"status":  "OK",
		"mensaje": res.Mensaje,
		"total":   res.Total,
	})
}
