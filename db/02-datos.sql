-- 02-datos.sql
-- Insertar géneros musicales
INSERT INTO genero (nombre) VALUES 
('Pop'),
('Rock'),
('Reggaeton'),
('Indie'),
('Electrónica');

-- Insertar formatos disponibles
INSERT INTO formato (nombre) VALUES 
('Digital'),
('Vinilo'),
('CD'),
('Cassette');

-- Insertar álbumes con imágenes de ejemplo
INSERT INTO album (nombre, duracion, imagen, fecha, genero, artista, precio) VALUES
('Alpha', 2400, 
 pg_read_binary_file('/tmp/assets/album_images/alpha.jpg')::bytea, 
 '2023-09-01', 1, 5, 12.99),
('AM', 2700, 
 pg_read_binary_file('/tmp/assets/album_images/am.jpg')::bytea, 
 '2013-09-09', 2, 6, 14.99),
('Un Verano Sin Ti', 3300, 
 pg_read_binary_file('/tmp/assets/album_images/un_verano_sin_ti.jpg')::bytea, 
 '2022-05-06', 3, 7, 11.99),
('Cable a Tierra', 2900, 
 pg_read_binary_file('/tmp/assets/album_images/cable_a_tierra.jpg')::bytea, 
 '2021-10-29', 4, 8, 13.99),
('7', 2500, 
 pg_read_binary_file('/tmp/assets/album_images/7.jpg')::bytea, 
 '2018-09-14', 5, 9, 10.99);

-- Asignar formatos disponibles para cada álbum
INSERT INTO album_formato (album, formato) VALUES
-- Alpha - disponible en todos los formatos
(1, 1), (1, 2), (1, 3), (1, 4),

-- AM - disponible en Digital, Vinilo y CD
(2, 1), (2, 2), (2, 3),

-- Un Verano Sin Ti - disponible en Digital y Vinilo
(3, 1), (3, 2),

-- Cable a Tierra - disponible en Digital, CD y Cassette
(4, 1), (4, 3), (4, 4),

-- 7 - disponible solo en Digital y Vinilo
(5, 1), (5, 2);

INSERT INTO cancion (nombre, duracion, album, archivo_audio) VALUES
-- AITANA – Alpha
('Los Ángeles', 180, 1,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('Las Babys', 175, 1,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('Dararí', 200, 1,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('2 Extraños', 220, 1,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),

-- ARCTIC MONKEYS – AM
('Do I Wanna Know?', 250, 2,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('R U Mine?', 200, 2,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('Arabella', 215, 2,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('Snap Out Of It', 210, 2,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('Knee Socks', 230, 2,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),

-- BAD BUNNY – Un Verano Sin Ti
('Titi Me Preguntó', 240, 3,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('Efecto', 210, 3,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('Ojitos Lindos', 240, 3,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('Me Porto Bonito', 200, 3,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('Callaita', 220, 3,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),

-- VETUSTA MORLA – Cable a Tierra
('Finisterre', 200, 4,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('Palabra Es Epicentro', 195, 4,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('La Virgen de la Humanidad', 230, 4,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),

-- DAVID GUETTA – 7
('Flames', 210, 5,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('Say My Name', 200, 5,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea),
('Don''t Leave Me Alone', 190, 5,
 pg_read_binary_file('/tmp/assets/songs/sample.mp3')::bytea);

-- Relaciones artista_cancion
INSERT INTO artista_cancion (cancion, artista) VALUES
-- Aitana
(1, 5), (2, 5), (3, 5), (4, 5),

-- Arctic Monkeys
(5, 6), (6, 6), (7, 6), (8, 6), (9, 6),

-- Bad Bunny
(10, 7), (11, 7), (12, 7), (13, 7), (14, 7),

-- Vetusta Morla
(15, 8), (16, 8), (17, 8),

-- David Guetta
(18, 9), (19, 9), (20, 9);

-- Merchandising
INSERT INTO merchandising (nombre, precio, imagen, artista, stock) VALUES
('Camiseta Aitana Alpha', 24.99,
    pg_read_binary_file('/tmp/assets/merch/camiseta_aitana.jpg')::bytea, 5, 30),
('Camiseta Arctic Monkeys AM', 34.99, 
    pg_read_binary_file('/tmp/assets/merch/camiseta_arctic.jpg')::bytea, 6, 15),
('Gorra Bad Bunny', 19.99, 
    pg_read_binary_file('/tmp/assets/merch/gorra_bad.jpg')::bytea, 7, 50),
('Sudadera Vetusta Morla', 29.99, 
    pg_read_binary_file('/tmp/assets/merch/sudadera_vetusta_morla.jpg')::bytea, 8, 20),
('Pulsera David Guetta', 9.99, 
    pg_read_binary_file('/tmp/assets/merch/pulsera_david_guetta.jpg')::bytea, 9, 60);
-- Noticias
INSERT INTO noticia (titulo, contenidoHTML, fecha, autor) VALUES
('Aitana estrena Alpha con gran éxito',
 '<p>El álbum <b>Alpha</b> supera el millón de reproducciones en su primer día.</p>', 
 '2023-09-10 12:00:00', 1),

('Arctic Monkeys anuncian nueva gira europea',
 '<p>La banda recorrerá 15 países en 2024.</p>', 
 '2023-11-01 10:30:00', 2),

('Bad Bunny lidera los Latin Grammy',
 '<h2>El fenómeno puertorriqueño consolida su reinado en la música latina</h2>

<p>La gala de los Latin Grammy 2024 será recordada como la noche de Bad Bunny. 
El artista puertorriqueño, cuyo nombre real es Benito Antonio Martínez Ocasio, 
se alzó con cuatro de los premios más codiciados de la ceremonia, demostrando 
una vez más por qué es considerado el artista más influyente de la música urbana 
contemporánea. La audiencia del MGM Grand Arena en Las Vegas no pudo contener 
los aplausos cuando el boricua subía repetidamente al escenario.</p>

<p>Entre sus triunfos más destacados se encuentran el premio a <strong>Mejor Álbum de Música Urbana</strong> 
por "Nadie Sabe Lo Que Va a Pasar Mañana", <strong>Mejor Canción Urbana</strong> por "Monaco", 
<strong>Mejor Interpretación Reggaetón</strong> y el codiciado <strong>Mejor Álbum del Año</strong>. 
Este último galardón representa un reconocimiento especial, ya que compitió 
contra pesos pesados de la industria como Rosalía y Karol G.</p>

<blockquote>
"Esto no es solo para mí, es para todos los que creen en la evolución de nuestra música. 
Seguiremos rompiendo barreras y demostrando que el reggaetón y la música urbana 
tienen un lugar indiscutible en la historia musical"
<br><br>
<em>- Bad Bunny, durante su discurso de aceptación</em>
</blockquote>

<p>La producción musical de su álbum ganador ha sido elogiada por la crítica especializada, 
que destaca la madurez artística y la evolución sonora que Bad Bunny ha demostrado 
en este trabajo. A diferencia de sus producciones anteriores, "Nadie Sabe Lo Que Va 
a Pasar Mañana" incorpora elementos de jazz, rock alternativo y música electrónica, 
creando un sonido único que redefine los límites del género urbano.</p>

<p>Los asistentes a la gala disfrutaron de una actuación sorpresa del artista, 
quien interpretó una versión acústica de "Monaco" acompañado únicamente por 
un piano. El momento fue catalogado por muchos como uno de los más emotivos 
de la noche, mostrando la versatilidad vocal y el carisma escénico que han 
convertido a Bad Bunny en un fenómeno global.</p>

<p>Con estos cuatro nuevos Latin Grammy, Bad Bunny suma un total de 15 galardones 
en su carrera, consolidándose como uno de los artistas más premiados en la 
historia de estos reconocimientos. Su influencia trasciende la música, 
impactando la moda, la cultura popular y abriendo puertas para las nuevas 
generaciones de artistas urbanos que ven en su trayectoria un camino a seguir.</p>

<h3>Premios obtenidos por Bad Bunny:</h3>
<ul>
<li>Mejor Álbum del Año</li>
<li>Mejor Álbum de Música Urbana</li>
<li>Mejor Canción Urbana</li>
<li>Mejor Interpretación Reggaetón</li>
</ul>', 
 '2023-11-20 21:00:00', 3),

('Vetusta Morla presenta "Cable a Tierra" en Madrid',
 '<p>Concierto lleno y críticas positivas en su última gira.</p>', 
 '2023-10-15 19:00:00', 2),

('David Guetta lanza nuevo single con Sia',
 '<p>El DJ francés vuelve a colaborar con Sia en un nuevo éxito dance.</p>', 
 '2023-08-01 08:00:00', 1);
