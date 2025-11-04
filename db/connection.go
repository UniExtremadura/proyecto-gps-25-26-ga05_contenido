package db

import (
	"database/sql"
	"fmt"
	"log"
	_ "github.com/lib/pq"
)

var DB *sql.DB

func InitDatabase() {
	connStr := "host=contenido-db port=5432 user=user password=12345 dbname=contenido_postgres sslmode=disable"

	var err error
	DB, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal("Error conectando a la base de datos: ", err)
	}

	err = DB.Ping()

	if err != nil {
		log.Fatal("Error haciendo ping a la base de datos: ", err)
	}

	fmt.Println("Conectado a PostgreSQL exitosamente")
}
