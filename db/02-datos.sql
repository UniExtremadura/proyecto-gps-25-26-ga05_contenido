INSERT INTO genero (nombre) VALUES 
('Pop'),
('Rock'),
('Reggaeton'),
('Indie'),
('Electrónica');


INSERT INTO album (nombre, duracion, urlImagen, fecha, genero, artista, precio) VALUES
('Alpha', 2400, 'https://img.com/alpha.jpg', '2023-09-01', 1, 1,20.99),
('AM', 2700, 'https://img.com/am.jpg', '2013-09-09', 2, 2,15.99),
('Un Verano Sin Ti', 3300, 'https://img.com/verano.jpg', '2022-05-06', 3, 3,14.99),
('Cable a Tierra', 2900, 'https://img.com/cable.jpg', '2021-10-29', 4, 4,9.99),
('7', 2500, 'https://img.com/7.jpg', '2018-09-14', 5, 5,10);


INSERT INTO cancion (nombre, urlImagen, duracion, album) VALUES
-- AITANA – Alpha
('Los Ángeles', 'https://img.com/losangeles.jpg', 180, 1),
('Las Babys', 'https://img.com/lasbabys.jpg', 175, 1),
('Dararí', 'https://img.com/darari.jpg', 200, 1),
('2 Extraños', 'https://img.com/2extranios.jpg', 220, 1),

-- ARCTIC MONKEYS – AM
('Do I Wanna Know?', 'https://img.com/doiwanna.jpg', 250, 2),
('R U Mine?', 'https://img.com/rumine.jpg', 200, 2),
('Arabella', 'https://img.com/arabella.jpg', 215, 2),
('Snap Out Of It', 'https://img.com/snapoutofit.jpg', 210, 2),
('Knee Socks', 'https://img.com/kneesocks.jpg', 230, 2),

-- BAD BUNNY – Un Verano Sin Ti
('Titi Me Preguntó', 'https://img.com/titi.jpg', 240, 3),
('Efecto', 'https://img.com/efecto.jpg', 210, 3),
('Ojitos Lindos', 'https://img.com/ojitos.jpg', 240, 3),
('Me Porto Bonito', 'https://img.com/meporto.jpg', 200, 3),
('Callaita', 'https://img.com/callaita.jpg', 220, 3),

-- VETUSTA MORLA – Cable a Tierra
('Finisterre', 'https://img.com/finisterre.jpg', 200, 4),
('Palabra Es Epicentro', 'https://img.com/epicentro.jpg', 195, 4),
('La Virgen de la Humanidad', 'https://img.com/virgen.jpg', 230, 4),

-- DAVID GUETTA – 7
('Flames', 'https://img.com/flames.jpg', 210, 5),
('Say My Name', 'https://img.com/saymyname.jpg', 200, 5),
('Don’t Leave Me Alone', 'https://img.com/dontleave.jpg', 190, 5);


INSERT INTO artista_cancion (cancion, artista) VALUES
-- Aitana
(1, 1), (2, 1), (3, 1), (4, 1),

-- Arctic Monkeys
(5, 2), (6, 2), (7, 2), (8, 2), (9, 2),

-- Bad Bunny
(10, 3), (11, 3), (12, 3), (13, 3), (14, 3),

-- Vetusta Morla
(15, 4), (16, 4), (17, 4),

-- David Guetta
(18, 5), (19, 5), (20, 5),

-- Colaboraciones (opcionales)
(12, 1),  -- Aitana ft. Bad Bunny (Ojitos Lindos, versión remix ficticia)
(18, 1);  -- Flames ft. Aitana


INSERT INTO merchandising (nombre, precio, urlImagen, artista, stock) VALUES
('Camiseta Aitana Alpha', 24.99, 'https://img.com/aita-shirt.jpg', 1, 30),
('Vinilo Arctic Monkeys AM', 34.99, 'https://img.com/am-vinilo.jpg', 2, 15),
('Gorra Bad Bunny', 19.99, 'https://img.com/gorra-bunny.jpg', 3, 50),
('Sudadera Vetusta Morla', 29.99, 'https://img.com/vetusta-sudadera.jpg', 4, 20),
('Pulsera David Guetta', 9.99, 'https://img.com/guetta-pulsera.jpg', 5, 60);


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

('Vetusta Morla presenta “Cable a Tierra” en Madrid',
 '<p>Concierto lleno y críticas positivas en su última gira.</p>', 
 '2023-10-15 19:00:00', 2),

('David Guetta lanza nuevo single con Sia',
 '<p>El DJ francés vuelve a colaborar con Sia en un nuevo éxito dance.</p>', 
 '2023-08-01 08:00:00', 1);

