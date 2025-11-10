package openapi

import (
	"fmt"
	"mime/multipart"
	"os"
	"path/filepath"
	"strings"

	"github.com/gin-gonic/gin"
)

// ValidImageMimeTypes contiene los tipos MIME permitidos para imágenes de portada
var ValidImageMimeTypes = map[string]bool{
	"image/jpeg": true,
	"image/jpg":  true,
	"image/png":  true,
	"image/webp": true,
}

// MaxImageSize define el tamaño máximo permitido para imágenes (5MB)
const MaxImageSize = 5 * 1024 * 1024

// SaveUploadedCover guarda una imagen de portada subida
// Retorna la URL relativa del archivo guardado o un error
func SaveUploadedCover(c *gin.Context, fieldName string, artistID int32, albumID int32) (string, error) {
	// Obtener archivo del form
	file, err := c.FormFile(fieldName)
	if err != nil {
		return "", fmt.Errorf("no se pudo leer el archivo: %w", err)
	}

	// Validar tamaño
	if file.Size > MaxImageSize {
		return "", fmt.Errorf("el archivo excede el tamaño máximo permitido de 5MB (tamaño: %.2fMB)", float64(file.Size)/(1024*1024))
	}

	// Validar tipo MIME
	if !ValidImageMimeTypes[file.Header.Get("Content-Type")] {
		return "", fmt.Errorf("formato de imagen no válido. Solo se permiten: JPEG, PNG, WEBP")
	}

	// Validar extensión del archivo
	ext := strings.ToLower(filepath.Ext(file.Filename))
	if ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".webp" {
		return "", fmt.Errorf("extensión de archivo no válida: %s", ext)
	}

	// Crear estructura de carpetas: uploads/covers/{artistID}/{albumID}/
	uploadDir := filepath.Join("uploads", "covers", fmt.Sprintf("%d", artistID), fmt.Sprintf("%d", albumID))
	if err := os.MkdirAll(uploadDir, 0755); err != nil {
		return "", fmt.Errorf("error creando directorio de uploads: %w", err)
	}

	// Generar nombre único para el archivo
	filename := fmt.Sprintf("cover%s", ext)
	filePath := filepath.Join(uploadDir, filename)

	// Guardar archivo
	if err := c.SaveUploadedFile(file, filePath); err != nil {
		return "", fmt.Errorf("error guardando archivo: %w", err)
	}

	// Retornar URL relativa (para servir estáticamente)
	// Convertir separadores de Windows (\) a URL (/)
	urlPath := strings.ReplaceAll(filePath, "\\", "/")
	return "/" + urlPath, nil
}

// ValidateImageFile valida un archivo de imagen sin guardarlo
func ValidateImageFile(file *multipart.FileHeader) error {
	// Validar tamaño
	if file.Size > MaxImageSize {
		return fmt.Errorf("el archivo excede el tamaño máximo permitido de 5MB")
	}

	// Validar tipo MIME
	contentType := file.Header.Get("Content-Type")
	if !ValidImageMimeTypes[contentType] {
		return fmt.Errorf("formato de imagen no válido: %s. Solo se permiten: JPEG, PNG, WEBP", contentType)
	}

	// Validar extensión
	ext := strings.ToLower(filepath.Ext(file.Filename))
	if ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".webp" {
		return fmt.Errorf("extensión de archivo no válida: %s", ext)
	}

	return nil
}
