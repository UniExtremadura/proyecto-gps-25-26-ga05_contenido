BEGIN;

DROP TABLE IF EXISTS noticia;
DROP TABLE IF EXISTS merchandising;
DROP TABLE IF EXISTS artista_cancion;
DROP TABLE IF EXISTS cancion;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS genero;
DROP TABLE IF EXISTS formato;

CREATE TABLE genero (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE formato (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE album (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(200) NOT NULL,
  duracion INTEGER,
  imagen BYTEA,
  fecha DATE,
  genero INTEGER REFERENCES genero(id),
  artista INTEGER,
  precio NUMERIC(10,2) NOT NULL
);

CREATE TABLE album_formato (
  album INTEGER REFERENCES album(id) ON DELETE CASCADE,
  formato INTEGER REFERENCES formato(id),
  PRIMARY KEY (album, formato)
);

CREATE TABLE cancion (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(200) NOT NULL,
  duracion INTEGER,
  album INTEGER REFERENCES album(id),
  archivo_audio BYTEA
);

CREATE TABLE artista_cancion (
  cancion INTEGER REFERENCES cancion(id) ON DELETE CASCADE,
  artista INTEGER,
  PRIMARY KEY (cancion, artista)
);

CREATE TABLE merchandising (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(200) NOT NULL,
  precio NUMERIC(10,2) NOT NULL,
  imagen BYTEA,
  artista INTEGER,
  stock INTEGER DEFAULT 0
);

CREATE TABLE noticia (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(300) NOT NULL,
  contenidoHTML TEXT NOT NULL,
  fecha TIMESTAMP DEFAULT NOW(),
  autor INTEGER
);

COMMIT;
