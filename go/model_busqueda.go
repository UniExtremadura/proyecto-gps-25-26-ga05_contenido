/*
 * Microservicio de Contenido - UnderSounds
 *
 * Este microservicio gestiona el contenido multimedia y comercial del proyecto \"UnderSounds\", incluyendo albumes, canciones, generos, merchandising y noticias musicales.
 *
 * API version: 1.0.0
 */
package openapi

type AlbumResult struct {
    Id            int32   `json:"id"`
    Nombre        string  `json:"nombre"`
    Duracion      int32   `json:"duracion,omitempty"`
    Imagen        string  `json:"imagen,omitempty"`
    Fecha         string  `json:"fecha,omitempty"`
    Genero        int32   `json:"genero,omitempty"`
    Artista       int32   `json:"artista,omitempty"`
    NombreArtista string  `json:"nombre_artista,omitempty"`
    Precio        float64 `json:"precio,omitempty"`
    Formatos      []int32 `json:"formatos,omitempty"`
}

type CancionResult struct {
    Id       int32  `json:"id"`
    Nombre   string `json:"nombre"`
    Duracion int32  `json:"duracion,omitempty"`
    Album    int32  `json:"album,omitempty"`
}

type ArtistResult struct {
    Id          int32  `json:"id"`
    Nombre      string `json:"nombre,omitempty"`
    AlbumsCount int    `json:"albums_count"`
    SongsCount  int    `json:"songs_count"`
    MerchCount  int    `json:"merch_count"`
}

type SearchResponse struct {
    Page       int                    `json:"page"`
    PerPage    int                    `json:"per_page"`
    Totals     map[string]int         `json:"totals"`
    Results    map[string]interface{} `json:"results"`
}
