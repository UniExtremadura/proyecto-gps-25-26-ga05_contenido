package openapi

import (
    "database/sql"
    "fmt"
)

type Merch struct {
    Id      int32   `json:"id,omitempty"`
    Nombre  string  `json:"nombre"`
    Precio  float32 `json:"precio"`
    Imagen  []byte  `json:"imagen,omitempty"`
    Artista int32   `json:"artista"`
    NombreArtista string  `json:"nombre_artista,omitempty"`
    Stock   int32   `json:"stock"`
}

type CreateMerchRequest struct {
    Nombre  string  `json:"nombre" binding:"required"`
    Precio  float32 `json:"precio" binding:"required"`
    Imagen  []byte  `json:"imagen,omitempty"`
    Artista int32   `json:"artista"`
    Stock   int32   `json:"stock"`
}

type UpdateMerchRequest struct {
    Nombre  *string  `json:"nombre"`
    Precio  *float32 `json:"precio"`
    Imagen  *[]byte  `json:"imagen"`
    Artista *int32   `json:"artista"`
    Stock   *int32   `json:"stock"`
}

func GetAllMerch(db *sql.DB) ([]Merch, error) {
    rows, err := db.Query("SELECT id, nombre, precio, imagen, artista, stock FROM merchandising")
    if err != nil {
        return nil, err
    }
    defer rows.Close()

    var merchs []Merch
    for rows.Next() {
        var m Merch
        if err := rows.Scan(&m.Id, &m.Nombre, &m.Precio, &m.Imagen, &m.Artista, &m.Stock); err != nil {
            return nil, err
        }
        merchs = append(merchs, m)
    }
    return merchs, nil
}

func DeleteMerch(db *sql.DB, id int32) error {
    result, err := db.Exec("DELETE FROM merchandising WHERE id = $1", id)
    if err != nil {
        return err
    }

    rowsAffected, err := result.RowsAffected()
    if err != nil {
        return err
    }

    if rowsAffected == 0 {
        return sql.ErrNoRows
    }

    return nil
}

func GetMerch(db *sql.DB, id int32) (*Merch, error) {
    var m Merch
    err := db.QueryRow(
        "SELECT id, nombre, precio, imagen, artista, stock FROM merchandising WHERE id = $1",
        id,
    ).Scan(&m.Id, &m.Nombre, &m.Precio, &m.Imagen, &m.Artista, &m.Stock)

    if err != nil {
        if err == sql.ErrNoRows {
            return nil, sql.ErrNoRows
        }
        return nil, err
    }

    return &m, nil
}

func (m *CreateMerchRequest) CreateMerch(db *sql.DB) (*Merch, error) {
    var nuevo Merch
    query := `
    INSERT INTO merchandising (nombre,precio,imagen,artista,stock)
    VALUES ($1, $2, $3, $4, $5)
    RETURNING id, nombre, precio, imagen, artista, stock
    `

    err := db.QueryRow(query, m.Nombre, m.Precio, m.Imagen, m.Artista, m.Stock).
        Scan(&nuevo.Id, &nuevo.Nombre, &nuevo.Precio, &nuevo.Imagen, &nuevo.Artista, &nuevo.Stock)
    if err != nil {
        return nil, err
    }
    return &nuevo, nil
}

func (u *UpdateMerchRequest) UpdateMerch(db *sql.DB, id int32) (*Merch, error) {
    query := "UPDATE merchandising SET"
    params := []interface{}{}
    i := 1

    if u.Nombre != nil {
        query += fmt.Sprintf(" nombre=$%d,", i)
        params = append(params, *u.Nombre)
        i++
    }
    if u.Precio != nil {
        query += fmt.Sprintf(" precio=$%d,", i)
        params = append(params, *u.Precio)
        i++
    }
    if u.Imagen != nil {
        query += fmt.Sprintf(" imagen=$%d,", i)
        params = append(params, *u.Imagen)
        i++
    }
    if u.Artista != nil {
        query += fmt.Sprintf(" artista=$%d,", i)
        params = append(params, *u.Artista)
        i++
    }
    if u.Stock != nil {
        query += fmt.Sprintf(" stock=$%d,", i)
        params = append(params, *u.Stock)
        i++
    }

    if len(params) == 0 {
        return nil, fmt.Errorf("no se introducen campos para actualizar")
    }

    query = query[:len(query)-1] + fmt.Sprintf(" WHERE id=$%d RETURNING id, nombre, precio, imagen, artista, stock", i)
    params = append(params, id)

    var updated Merch
    err := db.QueryRow(query, params...).Scan(
        &updated.Id, &updated.Nombre, &updated.Precio, &updated.Imagen, &updated.Artista, &updated.Stock,
    )
    if err != nil {
        if err == sql.ErrNoRows {
            return nil, sql.ErrNoRows
        }
        return nil, err
    }

    return &updated, nil
}
