BEGIN;

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
  artista INTEGER REFERENCES artista(id)
);

CREATE TABLE cancion (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(200) NOT NULL,
  urlImagen TEXT,
  duracion INTEGER,
  album INTEGER REFERENCES album(id) ON DELETE CASCADE
);

CREATE TABLE artista_cancion (
  cancion INTEGER REFERENCES cancion(id) ON DELETE CASCADE,
  artista INTEGER REFERENCES artista(id) ON DELETE CASCADE,
  PRIMARY KEY (cancion, artista)
);

CREATE TABLE merchandising (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(200) NOT NULL,
  precio NUMERIC(10,2) NOT NULL,
  urlImagen TEXT,
  artista INTEGER REFERENCES artista(id),
  stock INTEGER DEFAULT 0
);

CREATE TABLE noticia (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(300) NOT NULL,
  contenidoHTML TEXT NOT NULL,
  fecha TIMESTAMP DEFAULT NOW(),
  autor INTEGER REFERENCES autor(id)
);

COMMIT;
