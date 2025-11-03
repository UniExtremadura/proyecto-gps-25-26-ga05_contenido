BEGIN;

DROP TABLE IF EXISTS noticia;
DROP TABLE IF EXISTS merchandising;
DROP TABLE IF EXISTS artista_cancion;
DROP TABLE IF EXISTS cancion;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS genero;
DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS pedido_item;


CREATE TABLE genero (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE album (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(200) NOT NULL,
  duracion INTEGER,
  urlImagen TEXT,
  fecha DATE,
  genero INTEGER REFERENCES genero(id),
  artista INTEGER
);

CREATE TABLE cancion (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(200) NOT NULL,
  urlImagen TEXT,
  duracion INTEGER,
  album INTEGER REFERENCES album(id)
);

CREATE TABLE artista_cancion (
  cancion INTEGER REFERENCES cancion(id) ON DELETE CASCADE,
  artista INTEGER ,
  PRIMARY KEY (cancion, artista)
);

CREATE TABLE merchandising (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(200) NOT NULL,
  precio NUMERIC(10,2) NOT NULL,
  urlImagen TEXT,
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

CREATE TABLE pedido (
  id SERIAL PRIMARY KEY,
  cliente INTEGER NOT NULL,
  fecha TIMESTAMP DEFAULT NOW(),
  total NUMERIC (10,2) DEFAULT 0,
  estado VARCHAR(50) DEFAULT 'pendiente'
);

CREATE TABLE pedido_item (
  pedido INTEGER REFERENCES pedido(id) ON DELETE CASCADE,
  merch INTEGER REFERENCES merchandising(id),
  cantidad INTEGER NOT NULL,
  precio_unitario NUMERIC(10,2) NOT NULL,
  PRIMARY KEY (pedido, merch)
);

COMMIT;
