# Subida de Portadas para Álbumes

## Descripción

Esta funcionalidad permite a los artistas subir imágenes de portada para sus álbumes mediante los endpoints de creación y edición.

## Características

### ✅ Validaciones Implementadas

- **Formatos permitidos**: JPEG, JPG, PNG, WEBP
- **Tamaño máximo**: 5 MB
- **Validación de tipo MIME** y extensión de archivo

### 📁 Organización de Archivos

Los archivos se guardan en la siguiente estructura:

```
uploads/covers/{artistaID}/{albumID}/cover.{ext}
```

Ejemplo: `uploads/covers/3/15/cover.jpg`

### 🔗 Acceso a Imágenes

Las imágenes se sirven estáticamente en:

```
http://localhost:8080/uploads/covers/{artistaID}/{albumID}/cover.{ext}
```

---

## Uso

### 1️⃣ Crear Álbum con Portada (POST /albums)

#### Opción A: Usando JSON (sin archivo)

```bash
curl -X POST http://localhost:8080/albums \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Mi Álbum",
    "duracion": 2400,
    "fecha": "2025-01-15",
    "genero": 1,
    "artista": 3
  }'
```

#### Opción B: Usando multipart/form-data (con archivo)

```bash
curl -X POST http://localhost:8080/albums \
  -F "nombre=Mi Álbum" \
  -F "duracion=2400" \
  -F "fecha=2025-01-15" \
  -F "genero=1" \
  -F "artista=3" \
  -F "cover=@/ruta/a/portada.jpg"
```

**Bruno / Postman:**

1. Selecciona `POST /albums`
2. En el Body, selecciona `form-data`
3. Agrega campos:
   - `nombre` (text): "Mi Álbum"
   - `duracion` (text): "2400"
   - `fecha` (text): "2025-01-15"
   - `genero` (text): "1"
   - `artista` (text): "3"
   - `cover` (file): Seleccionar archivo de imagen

---

### 2️⃣ Actualizar Portada de Álbum (PATCH /albums/:id)

#### Opción A: Actualizar solo datos (JSON)

```bash
curl -X PATCH http://localhost:8080/albums/5 \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Nuevo Nombre"
  }'
```

#### Opción B: Actualizar portada (multipart/form-data)

```bash
curl -X PATCH http://localhost:8080/albums/5 \
  -F "cover=@/ruta/a/nueva_portada.png"
```

#### Opción C: Actualizar datos y portada simultáneamente

```bash
curl -X PATCH http://localhost:8080/albums/5 \
  -F "nombre=Nuevo Nombre" \
  -F "duracion=3000" \
  -F "cover=@/ruta/a/nueva_portada.png"
```

---

## Respuestas

### ✅ Éxito (201 Created / 200 OK)

```json
{
  "status": "OK",
  "album": {
    "id": 15,
    "nombre": "Mi Álbum",
    "duracion": 2400,
    "urlImagen": "/uploads/covers/3/15/cover.jpg",
    "fecha": "2025-01-15",
    "genero": {
      "id": 1,
      "nombre": "Rock"
    },
    "artista": 3
  }
}
```

### ❌ Errores Comunes

#### Archivo muy grande

```json
{
  "error": "Error subiendo portada: el archivo excede el tamaño máximo permitido de 5MB (tamaño: 7.32MB)"
}
```

#### Formato no válido

```json
{
  "error": "Error subiendo portada: formato de imagen no válido. Solo se permiten: JPEG, PNG, WEBP"
}
```

#### Campos requeridos faltantes

```json
{
  "error": "el campo 'nombre' es requerido"
}
```

---

## Implementación Técnica

### Archivos Modificados/Creados

1. **`go/uploads.go`**: Helper para guardar y validar archivos
2. **`go/api_albumes.go`**: Endpoints POST y PATCH con soporte multipart
3. **`go/model_album.go`**: Modelos y funciones CRUD
4. **`main.go`**: Configuración de servidor de archivos estáticos
5. **`api/openapi.yaml`**: Documentación OpenAPI actualizada
6. **`.gitignore`**: Exclusión de carpeta `uploads/`

### Validaciones en `uploads.go`

```go
// Tipos MIME permitidos
var ValidImageMimeTypes = map[string]bool{
    "image/jpeg": true,
    "image/jpg":  true,
    "image/png":  true,
    "image/webp": true,
}

// Tamaño máximo: 5MB
const MaxImageSize = 5 * 1024 * 1024
```

---

## Testing

### Prueba Manual

1. **Iniciar servidor**: `go run main.go`
2. **Crear álbum con portada** usando Bruno/Postman
3. **Verificar archivo guardado**: Revisar carpeta `uploads/covers/`
4. **Acceder a la imagen**: `http://localhost:8080/uploads/covers/{artistaID}/{albumID}/cover.jpg`

### Prueba con curl

```bash
# 1. Crear álbum con portada
curl -X POST http://localhost:8080/albums \
  -F "nombre=Test Album" \
  -F "fecha=2025-11-10" \
  -F "genero=1" \
  -F "artista=1" \
  -F "cover=@test_image.jpg"

# 2. Verificar respuesta (tomar ID del álbum creado)

# 3. Actualizar portada
curl -X PATCH http://localhost:8080/albums/{ID} \
  -F "cover=@new_image.png"
```

---

## Notas de Seguridad

- ✅ Validación de tipo MIME y extensión
- ✅ Límite de tamaño de archivo (5MB)
- ✅ Nombres de archivo estandarizados (evita inyección de código)
- ⚠️ **Pendiente**: Autenticación/autorización (verificar que el artista sea el propietario del álbum)
- ⚠️ **Pendiente**: Sanitización de imágenes (re-encoding para eliminar metadata maliciosa)

---

## Próximas Mejoras

- [ ] Soporte para canciones (similar a álbumes)
- [ ] Generación de thumbnails automática
- [ ] Integración con almacenamiento en la nube (S3, Azure Blob Storage)
- [ ] Compresión automática de imágenes
- [ ] Versionado de portadas (mantener historial)
