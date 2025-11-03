INSERT INTO genero (nombre) VALUES 
('Pop'),
('Rock'),
('Reggaeton'),
('Indie'),
('Electrónica');


INSERT INTO album (nombre, duracion, urlImagen, fecha, genero, artista) VALUES
('Alpha', 2400, 'https://img.com/alpha.jpg', '2023-09-01', 1, 1),
('AM', 2700, 'https://img.com/am.jpg', '2013-09-09', 2, 2),
('Un Verano Sin Ti', 3300, 'https://img.com/verano.jpg', '2022-05-06', 3, 3),
('Cable a Tierra', 2900, 'https://img.com/cable.jpg', '2021-10-29', 4, 4),
('7', 2500, 'https://img.com/7.jpg', '2018-09-14', 5, 5);


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
 '<p>El artista puertorriqueño se lleva cuatro premios en la gala.</p>', 
 '2023-11-20 21:00:00', 3),

('Vetusta Morla presenta “Cable a Tierra” en Madrid',
 '<p>Concierto lleno y críticas positivas en su última gira.</p>', 
 '2023-10-15 19:00:00', 2),

('David Guetta lanza nuevo single con Sia',
 '<p>El DJ francés vuelve a colaborar con Sia en un nuevo éxito dance.</p>', 
 '2023-08-01 08:00:00', 1);


INSERT INTO pedido (cliente,fecha,estado) VALUES
-- Pedidos del usuario 1 (Laura Sanchez)
(1,"2024-10-02 18:00:55",'entregado'), (1,"2025-11-02 21:00:00",'pendiente'), (1,"2025-08-13 11:00:00",'en curso'),
-- Pedidos del usuario 2 (Carlos Ruiz)
(2,"2024-10-03 19:00:00",'entregado')
-- Pedidos del usuario 3 (Ana Lopez)
(3,"2025-10-02 18:00:00",'entregado')
-- Pedidos del usuario 4 (Pablo Torres)
(4,"2025-04-12 20:30:50",'entregado')
-- Pedidos del usuario 5 (Marta Gómez)
(5,"2024-10-02 18:00:00",'entregado')

INSERT INTO pedido_item (pedido,merch,cantidad,precio_unitario) VALUES
-- Items del usuario 1
    --Primer Pedido
    (1,1,2,24.99), (1,2,1,34.99)
    --Segundo Pedido
    (2,4,1,29.99)
    --Tercer Pedido
    (3,5,3,9.99)
-- Items del usuario 2
    (4,1,1,24.99)
-- Items del usuario 3
    (5,5,1,9.99)
-- Items del usuario 4
    (6,4,2,29.99)
-- Items del usuario 5
    (7,5,3,9.99)
