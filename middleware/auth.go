package middleware

import (
	"net/http"
	"os"
	"strings"

	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
)

var JwtKey = []byte(os.Getenv("JWT_SECRET_KEY"))

func Auth() gin.HandlerFunc {
	return func(c *gin.Context) {
		strToken := strings.TrimPrefix(c.GetHeader("Authorization"), "Bearer ")

		token, _ := jwt.Parse(strToken, func(token *jwt.Token) (any, error) {
			return JwtKey, nil
		})

		if token == nil || !token.Valid {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Token inválido"})
			c.Abort()
			return
		}

		c.Next()
	}
}


func GetIdUsuario(c *gin.Context) int {
	strToken := strings.TrimPrefix(c.GetHeader("Authorization"), "Bearer ")
	token, _ := jwt.Parse(strToken, func(token *jwt.Token) (any, error) {
		return JwtKey, nil
	})
	
	if claims, ok := token.Claims.(jwt.MapClaims); ok {
		if idUsuario, ok := claims["user_id"].(float64); ok {
			return int(idUsuario)
		}
	}

	return 0
}
