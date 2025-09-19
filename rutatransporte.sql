-- ==================================================
-- PROYECTO 7: OPTIMIZACIÓN DE REDES DE TRANSPORTE URBANO
-- Script completo: creación de tablas, carga inicial y consultas de análisis
-- ==================================================
-- ==============================================
-- CREACIÓN DE TABLAS E INGRESO DE DATOS 
-- ==============================================
create database transporte_urbano_new;
use transporte_urbano_new;

CREATE TABLE Rutas (
    id_ruta INT PRIMARY KEY AUTO_INCREMENT,
    nombre_ruta VARCHAR(100) NOT NULL,
    origen VARCHAR(50),
    destino VARCHAR(50),
    descripcion TEXT,
    flota_asignada INT NOT NULL DEFAULT 0
);
INSERT INTO Rutas (id_ruta, nombre_ruta, origen, destino, descripcion, flota_asignada) VALUES
    -- Rutas Cardinales (Generalmente más unidades)
	(1, 'Ruta Norte', 'Terminal Norte', 'Centro Histórico', 'Conecta el norte con el centro, pasando por zonas comerciales.', 15),
	(2, 'Ruta Sur', 'Terminal Sur', 'Parque Central', 'Une el sur de la ciudad con el Parque Central, área de recreación.', 16),
	(3, 'Ruta Este', 'Estación Este', 'Universidad Central', 'Servicio principal para estudiantes y residentes del este.', 10),
	(4, 'Ruta Oeste', 'Barrio Industrial', 'Plaza Mayor', 'Conecta la zona industrial con el centro histórico y turístico.', 9),
	(5, 'Ruta Noroeste', 'Terminal Noroeste', 'Centro Histórico', 'Conecta el sector noroeste con el centro, atravesando zonas residenciales y comerciales.', 4),
	(6, 'Ruta Sureste', 'Terminal Sureste', 'Parque Metropolitano', 'Une el sureste de la ciudad con un importante punto verde y recreativo.', 7),
	(7, 'Ruta Noreste', 'Estación Noreste', 'Distrito Financiero', 'Servicio vital para residentes del noreste hacia el corazón económico.', 5),
	(8, 'Ruta Suroeste', 'Polígono Industrial Suroeste', 'Plaza Cívica Mayor', 'Conecta la principal zona industrial del suroeste con un punto central cívico y de interés.', 6);


CREATE TABLE Paradas (
    id_parada INT PRIMARY KEY,
    nombre_parada VARCHAR(100) NOT NULL,
    direccion VARCHAR(150)
    );
    
    
INSERT INTO Paradas (id_parada, nombre_parada, direccion) VALUES
(1, 'Parada Terminal Norte', 'Av. Simón Bolívar y Calle A'),
(2, 'Parada La Carolina', 'Av. Amazonas y República'),
(3, 'Parada Centro Histórico', 'Plaza Grande'),
(4, 'Parada Terminal Sur', 'Av. Maldonado y Morán Valverde'),
(5, 'Parada Quitumbe', 'Estación Quitumbe'),
(6, 'Parada Parque Central', 'Av. 10 de Agosto y Colón'),
(7, 'Parada Estación Este', 'Av. de los Shyris y Naciones Unidas'),
(8, 'Parada La Floresta', 'Av. 12 de Octubre y Madrid'),
(9, 'Parada Universidad Central', 'Av. América y Bolivia'),
(10, 'Parada Barrio Industrial', 'Av. Galo Plaza y El Inca'),
(11, 'Parada El Condado', 'Av. Occidental y Diego Vásquez'),
(12, 'Parada Plaza Mayor', 'Plaza Foch'),
(13, 'Parada El Labrador', 'Av. Galo Plaza y El Labrador'),
(14, 'Parada San Blas', 'Av. Gran Colombia y Tarqui'),
(15, 'Parada La Magdalena', 'Av. Maldonado y Rodrigo de Chávez'),
(16, 'Parada Chimbacalle', 'Av. Pedro Vicente Maldonado'),
(17, 'Parada Itchimbía', 'Av. José Antepara'),
(18, 'Parada Bellavista', 'Av. Eloy Alfaro'),
(19, 'Parada Cotocollao', 'Av. 10 de Agosto y Machala'),
(20, 'Parada San Roque', 'Av. Mariscal Sucre y Loja'),
(21, 'Parada La Pradera', 'Av. 6 de Diciembre y Orellana'),
(22, 'Parada La Mariscal', 'Av. Amazonas y Veintimilla'),
(23, 'Parada El Batán', 'Av. Eloy Alfaro y Portugal'),
(24, 'Parada Solanda', 'Av. Ajaví y Cardenal de la Torre'),
(25, 'Parada Chillogallo', 'Av. Mariscal Sucre y Francisco Barba'),
(26, 'Parada Calderón', 'Av. Geovanny Calles y 9 de Agosto'),
(27, 'Parada Carcelén', 'Av. Eloy Alfaro y Vaca de Castro'),
(28, 'Parada Cumbayá Centro', 'Francisco de Orellana y Juan Montalvo'),
(29, 'Parada Tumbaco Principal', 'Av. Interoceánica y Eugenio Espejo'),
(30, 'Parada Conocoto', 'Av. Ilaló y Píntag'),
(31, 'Parada Guamaní', 'Av. Maldonado y S7'),
(32, 'Parada Las Casas', 'Av. 10 de Agosto y Mariana de Jesús'),
(33, 'Parada Iñaquito', 'Av. Amazonas y Atahualpa'),
(34, 'Parada La Mena', 'Av. Teniente Hugo Ortiz y S37'),
(35, 'Parada El Quinche', 'Panamericana Norte y Gonzalo Pizarro');

CREATE TABLE Horarios (
    id_horario INT PRIMARY KEY AUTO_INCREMENT,
    id_ruta INT,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    unidades_en_servicio INT NOT NULL, 
    tiempo_espera_promedio_min DECIMAL(5,2) NOT NULL, 
    FOREIGN KEY (id_ruta) REFERENCES Rutas(id_ruta) ON DELETE CASCADE,
    CONSTRAINT chk_hora_fin_mayor_inicio CHECK (hora_fin > hora_inicio)
);


INSERT INTO Horarios (id_ruta, hora_inicio, hora_fin, unidades_en_servicio, tiempo_espera_promedio_min) VALUES
    -- ==============================================
    -- Rutas Cardinales (IDs 1-4): Generalmente más unidades y menor tiempo de espera
    -- ==============================================

    -- Ruta 1 (Norte - flota_asignada: 12)
    (1, '06:00:00', '09:00:00', 8, 8.00),   -- Pico Mañana
    (1, '09:00:00', '12:00:00', 4, 15.00), -- Valle Mañana
    (1, '12:00:00', '17:00:00', 4, 15.00), -- Valle Tarde
    (1, '17:00:00', '20:00:00', 8, 8.00),   -- Pico Tarde
    (1, '20:00:00', '23:00:00', 2, 25.00), -- Noche Valle

    -- Ruta 2 (Sur - flota_asignada: 10)
    (2, '06:00:00', '09:00:00', 7, 10.00), -- Pico Mañana
    (2, '09:00:00', '12:00:00', 3, 20.00), -- Valle Mañana
    (2, '12:00:00', '17:00:00', 3, 20.00), -- Valle Tarde
    (2, '17:00:00', '20:00:00', 7, 10.00), -- Pico Tarde
    (2, '20:00:00', '23:00:00', 2, 30.00), -- Noche Valle

    -- Ruta 3 (Este - flota_asignada: 11)
    (3, '06:00:00', '09:00:00', 8, 9.00),   -- Pico Mañana
    (3, '09:00:00', '12:00:00', 4, 18.00), -- Valle Mañana
    (3, '12:00:00', '17:00:00', 4, 18.00), -- Valle Tarde
    (3, '17:00:00', '20:00:00', 8, 9.00),   -- Pico Tarde
    (3, '20:00:00', '23:00:00', 3, 25.00), -- Noche Valle

    -- Ruta 4 (Oeste - flota_asignada: 9)
    (4, '06:00:00', '09:00:00', 6, 12.00), -- Pico Mañana
    (4, '09:00:00', '12:00:00', 3, 22.00), -- Valle Mañana
    (4, '12:00:00', '17:00:00', 3, 22.00), -- Valle Tarde
    (4, '17:00:00', '20:00:00', 6, 12.00), -- Pico Tarde
    (4, '20:00:00', '23:00:00', 2, 35.00), -- Noche Valle

    -- ==============================================
    -- Rutas Intercardinales (IDs 5-8): Generalmente menos unidades y mayor tiempo de espera
    -- ==============================================

    -- Ruta 5 (Noroeste - flota_asignada: 8)
    (5, '06:00:00', '09:00:00', 5, 15.00), -- Pico Mañana
    (5, '09:00:00', '17:00:00', 2, 30.00), -- Valle Largo (Mañana/Tarde)
    (5, '17:00:00', '20:00:00', 5, 15.00), -- Pico Tarde
    (5, '20:00:00', '23:00:00', 2, 45.00), -- Noche Valle

    -- Ruta 6 (Sureste - flota_asignada: 7)
    (6, '06:00:00', '09:00:00', 4, 18.00), -- Pico Mañana
    (6, '09:00:00', '17:00:00', 2, 35.00), -- Valle Largo
    (6, '17:00:00', '20:00:00', 4, 18.00), -- Pico Tarde
    (6, '20:00:00', '23:00:00', 2, 50.00), -- Noche Valle

    -- Ruta 7 (Noreste - flota_asignada: 8)
    (7, '06:00:00', '09:00:00', 5, 15.00), -- Pico Mañana
    (7, '09:00:00', '17:00:00', 2, 30.00), -- Valle Largo
    (7, '17:00:00', '20:00:00', 5, 15.00), -- Pico Tarde
    (7, '20:00:00', '23:00:00', 1, 45.00), -- Noche Valle

    -- Ruta 8 (Suroeste - flota_asignada: 6)
    (8, '06:00:00', '09:00:00', 3, 20.00), -- Pico Mañana
    (8, '09:00:00', '17:00:00', 2, 40.00), -- Valle Largo
    (8, '17:00:00', '20:00:00', 3, 20.00), -- Pico Tarde
    (8, '20:00:00', '23:00:00', 2, 60.00); -- Noche Valle
    
CREATE TABLE Ruta_Parada (
    id_ruta INT,
    id_parada INT,
    orden INT NOT NULL, -- Agregado NOT NULL
    PRIMARY KEY (id_ruta, id_parada),
    FOREIGN KEY (id_ruta) REFERENCES Rutas(id_ruta) ON DELETE CASCADE, -- Agregado ON DELETE CASCADE
    FOREIGN KEY (id_parada) REFERENCES Paradas(id_parada) ON DELETE CASCADE, -- Agregado ON DELETE CASCADE
    CONSTRAINT uq_ruta_orden UNIQUE (id_ruta, orden), -- Nueva restricción: el orden debe ser único para cada ruta
    CONSTRAINT chk_orden_positivo CHECK (orden > 0) -- Nueva restricción: el orden debe ser mayor que 0
);
   
INSERT INTO Ruta_Parada (id_ruta, id_parada, orden) VALUES
    -- ==============================================
    -- Rutas Cardinales (IDs 1-4)
    -- Cada ruta ahora tiene entre 6 y 8 paradas.
    -- ==============================================

    -- Ruta 1 (Norte): Terminal Norte -> La Carolina -> La Pradera -> El Labrador -> Las Casas -> San Blas -> Centro Histórico
	(1, 1, 1),   -- Parada Terminal Norte
	(1, 2, 2),   -- Parada La Carolina (Intersección con Ruta 5)
	(1, 21, 3),  -- Parada La Pradera (Intersección con Ruta 5)
	(1, 13, 4),  -- Parada El Labrador
    (1, 32, 5),  -- Parada Las Casas
	(1, 14, 6),  -- Parada San Blas
	(1, 3, 7),   -- Parada Centro Histórico (Intersección con Ruta 5)

    -- Ruta 2 (Sur): Terminal Sur -> Quitumbe -> Solanda -> Guamaní -> La Magdalena -> Chimbacalle -> Parque Central
	(2, 4, 1),   -- Parada Terminal Sur
	(2, 5, 2),   -- Parada Quitumbe
	(2, 24, 3),  -- Parada Solanda (Intersección con Ruta 6)
	(2, 31, 4),  -- Parada Guamaní (Intersección con Ruta 8)
	(2, 15, 5),  -- Parada La Magdalena
	(2, 16, 6),  -- Parada Chimbacalle
	(2, 6, 7),   -- Parada Parque Central (Intersección con Ruta 6)

    -- Ruta 3 (Este): Estación Este -> Tumbaco Principal -> Cumbayá Centro -> La Floresta -> Bellavista -> Itchimbía -> Universidad Central
	(3, 7, 1),   -- Parada Estación Este (Intersección con Ruta 7)
	(3, 29, 2),  -- Parada Tumbaco Principal (Intersección con Ruta 7)
	(3, 28, 3),  -- Parada Cumbayá Centro (Intersección con Ruta 7)
	(3, 8, 4),   -- Parada La Floresta
	(3, 18, 5),  -- Parada Bellavista
	(3, 17, 6),  -- Parada Itchimbía (Intersección con Ruta 6)
	(3, 9, 7),   -- Parada Universidad Central (Intersección con Ruta 7)

    -- Ruta 4 (Oeste): Barrio Industrial -> Cotocollao -> El Condado -> Chillogallo -> San Roque -> La Mena -> Plaza Mayor
	(4, 10, 1),  -- Parada Barrio Industrial (Intersección con Ruta 8)
	(4, 19, 2),  -- Parada Cotocollao (Intersección con Ruta 8)
	(4, 11, 3),  -- Parada El Condado
	(4, 25, 4),  -- Parada Chillogallo (Intersección con Ruta 8)
	(4, 20, 5),  -- Parada San Roque
	(4, 34, 6),  -- Parada La Mena (Intersección con Ruta 8)
	(4, 12, 7),  -- Parada Plaza Mayor (Intersección con Ruta 8)


    -- ==============================================
    -- Rutas Intercardinales (IDs 5-8) - Con más intersecciones y paradas
    -- Cada ruta ahora tiene entre 6 y 8 paradas.
    -- ==============================================

    -- Ruta 5 (Noroeste): Calderón -> Carcelén -> La Carolina (Int. R1) -> Iñaquito -> La Pradera (Int. R1) -> Centro Histórico (Int. R1)
	(5, 26, 1),  -- Parada Calderón
	(5, 27, 2),  -- Parada Carcelén
	(5, 2, 3),   -- Intersección con Ruta 1 (La Carolina)
	(5, 33, 4),  -- Parada Iñaquito
	(5, 21, 5),  -- Intersección con Ruta 1 (La Pradera)
	(5, 3, 6),   -- Intersección con Ruta 1 (Centro Histórico)

    -- Ruta 6 (Sureste): El Quinche -> Conocoto -> Solanda (Int. R2) -> Parque Central (Int. R2) -> La Mariscal -> El Batán -> Itchimbía (Int. R3)
	(6, 35, 1),  -- Parada El Quinche
	(6, 30, 2),  -- Parada Conocoto
	(6, 24, 3),  -- Intersección con Ruta 2 (Solanda)
	(6, 6, 4),   -- Intersección con Ruta 2 (Parque Central)
	(6, 22, 5),  -- Parada La Mariscal
	(6, 23, 6),  -- Parada El Batán
	(6, 17, 7),  -- Intersección con Ruta 3 (Itchimbía)

    -- Ruta 7 (Noreste): La Floresta (Int. R3) -> Estación Este (Int. R3) -> Tumbaco Principal (Int. R3) -> Cumbayá Centro (Int. R3) -> Las Casas (Int. R1) -> Universidad Central (Int. R3)
	(7, 8, 1),   -- Intersección con Ruta 3 (La Floresta)
	(7, 7, 2),   -- Intersección con Ruta 3 (Estación Este)
	(7, 29, 3),  -- Intersección con Ruta 3 (Tumbaco Principal)
	(7, 28, 4),  -- Intersección con Ruta 3 (Cumbayá Centro)
	(7, 32, 5),  -- Intersección con Ruta 1 (Las Casas)
	(7, 9, 6),   -- Intersección con Ruta 3 (Universidad Central)

    -- Ruta 8 (Suroeste): La Mena (Int. R4) -> Barrio Industrial (Int. R4) -> Guamaní (Int. R2) -> Chillogallo (Int. R4) -> Cotocollao (Int. R4) -> Plaza Mayor (Int. R4)
	(8, 34, 1),  -- Intersección con Ruta 4 (La Mena)
	(8, 10, 2),  -- Intersección con Ruta 4 (Barrio Industrial)
	(8, 31, 3),  -- Intersección con Ruta 2 (Guamaní)
	(8, 25, 4),  -- Intersección con Ruta 4 (Chillogallo)
	(8, 19, 5),  -- Intersección con Ruta 4 (Cotocollao)
	(8, 12, 6);  -- Intersección con Ruta 4 (Plaza Mayor)
   
CREATE TABLE Tipo_Usuario (
    id_tipo_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255) 
);

INSERT INTO Tipo_Usuario (id_tipo_usuario, nombre_tipo, descripcion) VALUES
    (1, 'Estudiante', 'Usuarios matriculados en instituciones educativas.'),
    (2, 'Trabajador', 'Usuarios que se desplazan por motivos laborales.'),
    (3, 'Turista', 'Visitantes de la ciudad que usan el transporte público.'),
    (4, 'Otro', 'Categoría para usuarios que no encajan en las anteriores.'),
    (5, 'Jubilado', 'Personas de la tercera edad, a menudo con tarifas especiales.'),
    (6, 'Menor de Edad', 'Usuarios jóvenes, posiblemente con acompañante o tarifas reducidas.');


CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    edad INT NOT NULL,
    genero ENUM('M','F','Otro'),
    email VARCHAR(100) NOT NULL UNIQUE,
    id_tipo_usuario INT NOT NULL, 
    FOREIGN KEY (id_tipo_usuario) REFERENCES Tipo_Usuario(id_tipo_usuario) ON DELETE RESTRICT 
);
   
INSERT INTO Usuarios (id_usuario, nombre, edad, genero, email, id_tipo_usuario) VALUES
	(1, 'Ana Torres', 25, 'F', 'ana.torres@mail.com', 2), -- Trabajador
	(2, 'Carlos Pérez', 32, 'M', 'carlos.perez@mail.com', 2), -- Trabajador
	(3, 'María Gómez', 20, 'F', 'maria.gomez@mail.com', 1), -- Estudiante
	(4, 'Luis Ramírez', 40, 'M', 'luis.ramirez@mail.com', 2), -- Trabajador
	(5, 'Paola Sánchez', 22, 'F', 'paola.sanchez@mail.com', 1), -- Estudiante
	(6, 'Andrés Silva', 30, 'M', 'andres.silva@mail.com', 2), -- Trabajador
	(7, 'Elena Ríos', 21, 'F', 'elena.rios@mail.com', 1), -- Estudiante
	(8, 'Javier Castro', 35, 'M', 'javier.castro@mail.com', 2), -- Trabajador
	(9, 'Lucía Fernández', 19, 'F', 'lucia.fernandez@mail.com', 1), -- Estudiante
	(10, 'Mateo Herrera', 29, 'M', 'mateo.herrera@mail.com', 2), -- Trabajador
	(11, 'Valeria Ortiz', 33, 'F', 'valeria.ortiz@mail.com', 2), -- Trabajador
	(12, 'Fernando López', 41, 'M', 'fernando.lopez@mail.com', 2), -- Trabajador
	(13, 'Isabel Morales', 24, 'F', 'isabel.morales@mail.com', 1), -- Estudiante
	(14, 'Daniel Cruz', 38, 'M', 'daniel.cruz@mail.com', 2), -- Trabajador
	(15, 'Camila Vega', 21, 'F', 'camila.vega@mail.com', 3), -- Turista
	(16, 'Ricardo Peña', 36, 'M', 'ricardo.pena@mail.com', 2), -- Trabajador
	(17, 'Gabriela León', 26, 'F', 'gabriela.leon@mail.com', 1), -- Estudiante
	(18, 'Sebastián Ruiz', 31, 'M', 'sebastian.ruiz@mail.com', 2), -- Trabajador
	(19, 'Laura Delgado', 23, 'F', 'laura.delgado@mail.com', 3), -- Turista
	(20, 'Tomás Bravo', 27, 'M', 'tomas.bravo@mail.com', 1), -- Estudiante
	(21, 'Sofía Ramos', 20, 'F', 'sofia.ramos@mail.com', 1), -- Estudiante
	(22, 'Alejandro Vargas', 34, 'M', 'alejandro.vargas@mail.com', 2), -- Trabajador
	(23, 'Martina Soto', 29, 'F', 'martina.soto@mail.com', 2), -- Trabajador
	(24, 'Diego Navarro', 23, 'M', 'diego.navarro@mail.com', 1), -- Estudiante
	(25, 'Paula Montes', 28, 'F', 'paula.montes@mail.com', 2), -- Trabajador
	(26, 'Gabriel Guzmán', 45, 'M', 'gabriel.guzman@mail.com', 2), -- Trabajador
	(27, 'Silvia Romero', 55, 'F', 'silvia.romero@mail.com', 5), -- Jubilado
	(28, 'Emilio Cifuentes', 18, 'M', 'emilio.cifuentes@mail.com', 1), -- Estudiante
	(29, 'Natalia Luna', 25, 'F', 'natalia.luna@mail.com', 2), -- Trabajador
	(30, 'Jorge Rivas', 39, 'M', 'jorge.rivas@mail.com', 2), -- Trabajador
	(31, 'Daniela Rojas', 22, 'F', 'daniela.rojas@mail.com', 1), -- Estudiante
	(32, 'Felipe Morales', 30, 'M', 'felipe.morales@mail.com', 2), -- Trabajador
	(33, 'Andrea Salas', 27, 'F', 'andrea.salas@mail.com', 2), -- Trabajador
	(34, 'Juan Peña', 58, 'M', 'juan.pena@mail.com', 5), -- Jubilado
	(35, 'Victoria Flores', 20, 'F', 'victoria.flores@mail.com', 1), -- Estudiante
	(36, 'Manuel Cortés', 31, 'M', 'manuel.cortes@mail.com', 2), -- Trabajador
	(37, 'Luciana Paredes', 24, 'F', 'luciana.paredes@mail.com', 1), -- Estudiante
	(38, 'Benjamín Vidal', 42, 'M', 'benjamin.vidal@mail.com', 2), -- Trabajador
	(39, 'Ximena Bustos', 26, 'F', 'ximena.bustos@mail.com', 2), -- Trabajador
	(40, 'Pedro Díaz', 62, 'M', 'pedro.diaz@mail.com', 5), -- Jubilado
	(41, 'Ignacia Soto', 21, 'F', 'ignacia.soto@mail.com', 1), -- Estudiante
	(42, 'Gonzalo Olivares', 37, 'M', 'gonzalo.olivares@mail.com', 2), -- Trabajador
	(43, 'Antonella Soto', 28, 'F', 'antonella.soto@mail.com', 2), -- Trabajador
	(44, 'Cristóbal Leiva', 23, 'M', 'cristobal.leiva@mail.com', 1), -- Estudiante
	(45, 'Francisca Miranda', 29, 'F', 'francisca.miranda@mail.com', 2), -- Trabajador
	(46, 'José Garrido', 48, 'M', 'jose.garrido@mail.com', 2), -- Trabajador
	(47, 'Florencia Núñez', 19, 'F', 'florencia.nunez@mail.com', 1), -- Estudiante
	(48, 'Joaquín Salas', 33, 'M', 'joaquin.salas@mail.com', 2), -- Trabajador
	(49, 'Sofía Cifuentes', 25, 'F', 'sofia.cifuentes@mail.com', 2), -- Trabajador
	(50, 'Esteban Gatica', 65, 'M', 'esteban.gatica@mail.com', 5), -- Jubilado
	(51, 'Martina Cortés', 20, 'F', 'martina.cortes@mail.com', 1), -- Estudiante
	(52, 'Sebastián Ramos', 36, 'M', 'sebastian.ramos@mail.com', 2), -- Trabajador
	(53, 'Valentina Soto', 27, 'F', 'valentina.soto@mail.com', 2), -- Trabajador
	(54, 'Lucas Fuentes', 22, 'M', 'lucas.fuentes@mail.com', 1), -- Estudiante
	(55, 'Renata Rojas', 30, 'F', 'renata.rojas@mail.com', 2), -- Trabajador
	(56, 'Diego Herrera', 41, 'M', 'diego.herrera@mail.com', 2), -- Trabajador
	(57, 'Emilia Vidal', 18, 'F', 'emilia.vidal@mail.com', 1), -- Estudiante
	(58, 'Javier Pérez', 34, 'M', 'javier.perez2@mail.com', 2), -- Trabajador
	(59, 'Catalina Vega', 26, 'F', 'catalina.vega@mail.com', 2), -- Trabajador
	(60, 'Gabriel Castro', 59, 'M', 'gabriel.castro@mail.com', 5), -- Jubilado
	(61, 'Rocío Morales', 21, 'F', 'rocio.morales@mail.com', 1), -- Estudiante
	(62, 'Pablo Navarro', 32, 'M', 'pablo.navarro@mail.com', 2), -- Trabajador
	(63, 'Carla Ibáñez', 29, 'F', 'carla.ibanez@mail.com', 2), -- Trabajador
	(64, 'Arturo Garcés', 24, 'M', 'arturo.garces@mail.com', 1), -- Estudiante
	(65, 'Pilar Espinoza', 28, 'F', 'pilar.espinoza@mail.com', 2), -- Trabajador
	(66, 'Marcelo Núñez', 46, 'M', 'marcelo.nunez@mail.com', 2), -- Trabajador
	(67, 'Viviana Soto', 57, 'F', 'viviana.soto@mail.com', 5), -- Jubilado
	(68, 'Omar Reyes', 19, 'M', 'omar.reyes@mail.com', 1), -- Estudiante
	(69, 'Constanza Vera', 25, 'F', 'constanza.vera@mail.com', 2), -- Trabajador
	(70, 'Ricardo Flores', 38, 'M', 'ricardo.flores@mail.com', 2), -- Trabajador
	(71, 'Fernanda Rojas', 22, 'F', 'fernanda.rojas@mail.com', 1), -- Estudiante
	(72, 'Álvaro Cruz', 30, 'M', 'alvaro.cruz@mail.com', 2), -- Trabajador
	(73, 'Cristina Gómez', 27, 'F', 'cristina.gomez@mail.com', 2), -- Trabajador
	(74, 'Marco Morales', 60, 'M', 'marco.morales@mail.com', 5), -- Jubilado
	(75, 'Daniela Vidal', 20, 'F', 'daniela.vidal@mail.com', 1), -- Estudiante
	(76, 'Patricio Rivas', 31, 'M', 'patricio.rivas@mail.com', 2), -- Trabajador
	(77, 'Paulina Silva', 24, 'F', 'paulina.silva@mail.com', 1), -- Estudiante
	(78, 'Jorge Herrera', 43, 'M', 'jorge.herrera@mail.com', 2), -- Trabajador
	(79, 'Andrea Tapia', 26, 'F', 'andrea.tapia@mail.com', 2), -- Trabajador
	(80, 'Francisco Soto', 63, 'M', 'francisco.soto@mail.com', 5), -- Jubilado
	(81, 'Alejandra Núñez', 21, 'F', 'alejandra.nunez@mail.com', 1), -- Estudiante
	(82, 'Luis Gatica', 37, 'M', 'luis.gatica@mail.com', 2), -- Trabajador
	(83, 'Carolina Fuentes', 28, 'F', 'carolina.fuentes@mail.com', 2), -- Trabajador
	(84, 'Sergio Leiva', 23, 'M', 'sergio.leiva@mail.com', 1), -- Estudiante
	(85, 'Pamela Bustos', 29, 'F', 'pamela.bustos@mail.com', 2), -- Trabajador
	(86, 'Héctor Díaz', 49, 'M', 'hector.diaz@mail.com', 2), -- Trabajador
	(87, 'Camila Espinoza', 19, 'F', 'camila.espinoza@mail.com', 1), -- Estudiante
	(88, 'Roberto Guzmán', 33, 'M', 'roberto.guzman@mail.com', 2), -- Trabajador
	(89, 'Nicole Ramos', 25, 'F', 'nicole.ramos@mail.com', 2), -- Trabajador
	(90, 'Daniel Salas', 66, 'M', 'daniel.salas@mail.com', 5), -- Jubilado
	(91, 'Vanessa Montes', 20, 'F', 'vanessa.montes@mail.com', 1), -- Estudiante
	(92, 'Mauricio Vega', 35, 'M', 'mauricio.vega@mail.com', 2), -- Trabajador
	(93, 'Claudia Ibáñez', 27, 'F', 'claudia.ibanez@mail.com', 2), -- Trabajador
	(94, 'Andrés Vera', 22, 'M', 'andres.vera@mail.com', 1), -- Estudiante
	(95, 'Laura Morales', 30, 'F', 'laura.morales@mail.com', 2), -- Trabajador
	(96, 'Gonzalo Peña', 40, 'M', 'gonzalo.pena@mail.com', 2), -- Trabajador
	(97, 'Valeria Silva', 50, 'F', 'valeria.silva@mail.com', 5), -- Jubilado
	(98, 'Sebastián Miranda', 18, 'M', 'sebastian.miranda@mail.com', 1), -- Estudiante
	(99, 'Fernanda Castro', 24, 'F', 'fernanda.castro@mail.com', 2), -- Trabajador
	(100, 'Felipe Soto', 39, 'M', 'felipe.soto@mail.com', 2), -- Trabajador
	(101, 'Martina Leiva', 21, 'F', 'martina.leiva@mail.com', 1), -- Estudiante
	(102, 'Álvaro Olivares', 31, 'M', 'alvaro.olivares@mail.com', 2), -- Trabajador
	(103, 'Antonia Guzmán', 28, 'F', 'antonia.guzman@mail.com', 2), -- Trabajador
	(104, 'Nicolás Rivas', 23, 'M', 'nicolas.rivas@mail.com', 1), -- Estudiante
	(105, 'Sofía Vera', 29, 'F', 'sofia.vera2@mail.com', 2), -- Trabajador
	(106, 'Esteban Ibáñez', 47, 'M', 'esteban.ibanez@mail.com', 2), -- Trabajador
	(107, 'Javiera Díaz', 56, 'F', 'javiera.diaz@mail.com', 5), -- Jubilado
	(108, 'Maximiliano Cifuentes', 19, 'M', 'maximiliano.cifuentes@mail.com', 1), -- Estudiante
	(109, 'Paz Fuentes', 25, 'F', 'paz.fuentes@mail.com', 2), -- Trabajador
	(110, 'Cristian Vidal', 38, 'M', 'cristian.vidal@mail.com', 2), -- Trabajador
	(111, 'Romina Morales', 22, 'F', 'romina.morales@mail.com', 1), -- Estudiante
	(112, 'Marcelo Herrera', 30, 'M', 'marcelo.herrera@mail.com', 2), -- Trabajador
	(113, 'Alejandra Pérez', 27, 'F', 'alejandra.perez@mail.com', 2), -- Trabajador
	(114, 'Julio Flores', 61, 'M', 'julio.flores@mail.com', 5), -- Jubilado
	(115, 'Constanza Rojas', 20, 'F', 'constanza.rojas@mail.com', 1), -- Estudiante
	(116, 'Vicente Silva', 31, 'M', 'vicente.silva@mail.com', 2), -- Trabajador
	(117, 'Beatriz Tapia', 24, 'F', 'beatriz.tapia@mail.com', 1), -- Estudiante
	(118, 'Carlos Garcés', 42, 'M', 'carlos.garces@mail.com', 2), -- Trabajador
	(119, 'Natalia Espinosa', 26, 'F', 'natalia.espinosa@mail.com', 2), -- Trabajador
	(120, 'Benjamín Navarro', 64, 'M', 'benjamin.navarro@mail.com', 5), -- Jubilado
	(121, 'Florencia Reyes', 21, 'F', 'florencia.reyes@mail.com', 1), -- Estudiante
	(122, 'Gabriel Vásquez', 36, 'M', 'gabriel.vasquez@mail.com', 2), -- Trabajador
	(123, 'Isidora Núñez', 28, 'F', 'isidora.nunez@mail.com', 2), -- Trabajador
	(124, 'Diego Cornejo', 23, 'M', 'diego.cornejo@mail.com', 1), -- Estudiante
	(125, 'Ignacia Vargas', 29, 'F', 'ignacia.vargas@mail.com', 2), -- Trabajador
	(126, 'Matías Soto', 48, 'M', 'matias.soto@mail.com', 2), -- Trabajador
	(127, 'Sofía Morales', 18, 'F', 'sofia.morales@mail.com', 1), -- Estudiante
	(128, 'Emiliano Pérez', 33, 'M', 'emiliano.perez@mail.com', 2), -- Trabajador
	(129, 'Daniela Bustos', 25, 'F', 'daniela.bustos@mail.com', 2), -- Trabajador
	(130, 'Manuel Rojas', 67, 'M', 'manuel.rojas@mail.com', 5), -- Jubilado
	(131, 'Javiera Fuentes', 20, 'F', 'javiera.fuentes@mail.com', 1), -- Estudiante
	(132, 'Fernando Leiva', 35, 'M', 'fernando.leiva@mail.com', 2), -- Trabajador
	(133, 'Valeria Herrera', 27, 'F', 'valeria.herrera2@mail.com', 2), -- Trabajador
	(134, 'Andrés Díaz', 22, 'M', 'andres.diaz@mail.com', 1), -- Estudiante
	(135, 'Camila Sánchez', 30, 'F', 'camila.sanchez@mail.com', 2), -- Trabajador
	(136, 'Nicolás Silva', 41, 'M', 'nicolas.silva@mail.com', 2), -- Trabajador
	(137, 'Lucía Gómez', 52, 'F', 'lucia.gomez@mail.com', 5), -- Jubilado
	(138, 'Pedro Tapia', 19, 'M', 'pedro.tapia@mail.com', 1), -- Estudiante
	(139, 'María Fernanda Morales', 26, 'F', 'maria.fernanda.morales@mail.com', 2), -- Trabajador
	(140, 'Sebastián Ramos', 40, 'M', 'sebastian.ramos2@mail.com', 2), -- Trabajador
	(141, 'Valentina Soto', 21, 'F', 'valentina.soto2@mail.com', 1), -- Estudiante
	(142, 'Lucas Espinosa', 32, 'M', 'lucas.espinosa@mail.com', 2), -- Trabajador
	(143, 'Renata Vega', 29, 'F', 'renata.vega@mail.com', 2), -- Trabajador
	(144, 'Diego Cifuentes', 24, 'M', 'diego.cifuentes@mail.com', 1), -- Estudiante
	(145, 'Emilia Gatica', 28, 'F', 'emilia.gatica@mail.com', 2), -- Trabajador
	(146, 'Javier Ibáñez', 46, 'M', 'javier.ibanez@mail.com', 2), -- Trabajador
	(147, 'Catalina Navarro', 57, 'F', 'catalina.navarro@mail.com', 5), -- Jubilado
	(148, 'Gabriel Cortés', 18, 'M', 'gabriel.cortes@mail.com', 1), -- Estudiante
	(149, 'Rocío Salas', 25, 'F', 'rocio.salas@mail.com', 2), -- Trabajador
	(150, 'Pablo Miranda', 38, 'M', 'pablo.miranda@mail.com', 2), -- Trabajador
	(151, 'Carla Vásquez', 22, 'F', 'carla.vasquez@mail.com', 1), -- Estudiante
	(152, 'Arturo Reyes', 30, 'M', 'arturo.reyes@mail.com', 2), -- Trabajador
	(153, 'Pilar Flores', 27, 'F', 'pilar.flores@mail.com', 2), -- Trabajador
	(154, 'Marcelo Vera', 60, 'M', 'marcelo.vera@mail.com', 5), -- Jubilado
	(155, 'Viviana Cruz', 20, 'F', 'viviana.cruz@mail.com', 1), -- Estudiante
	(156, 'Omar Garcés', 31, 'M', 'omar.garces@mail.com', 2), -- Trabajador
	(157, 'Constanza Herrera', 24, 'F', 'constanza.herrera@mail.com', 1), -- Estudiante
	(158, 'Ricardo Núñez', 43, 'M', 'ricardo.nunez@mail.com', 2), -- Trabajador
	(159, 'Fernanda Garcés', 26, 'F', 'fernanda.garces@mail.com', 2), -- Trabajador
	(160, 'Álvaro Soto', 63, 'M', 'alvaro.soto@mail.com', 5), -- Jubilado
	(161, 'Cristina Gómez', 21, 'F', 'cristina.gomez2@mail.com', 1), -- Estudiante
	(162, 'Marco Morales', 37, 'M', 'marco.morales2@mail.com', 2), -- Trabajador
	(163, 'Daniela Tapia', 28, 'F', 'daniela.tapia@mail.com', 2), -- Trabajador
	(164, 'Patricio Silva', 23, 'M', 'patricio.silva@mail.com', 1), -- Estudiante
	(165, 'Paulina Pérez', 29, 'F', 'paulina.perez@mail.com', 2), -- Trabajador
	(166, 'Jorge Vidal', 49, 'M', 'jorge.vidal@mail.com', 2), -- Trabajador
	(167, 'Andrea Miranda', 19, 'F', 'andrea.miranda@mail.com', 1), -- Estudiante
	(168, 'Francisco Herrera', 33, 'M', 'francisco.herrera@mail.com', 2), -- Trabajador
	(169, 'Alejandra Montes', 25, 'F', 'alejandra.montes@mail.com', 2), -- Trabajador
	(170, 'Luis Bustos', 66, 'M', 'luis.bustos@mail.com', 5), -- Jubilado
	(171, 'Carolina Leiva', 20, 'F', 'carolina.leiva@mail.com', 1), -- Estudiante
	(172, 'Sergio Rojas', 35, 'M', 'sergio.rojas@mail.com', 2), -- Trabajador
	(173, 'Pamela Fuentes', 27, 'F', 'pamela.fuentes@mail.com', 2), -- Trabajador
	(174, 'Héctor Vega', 22, 'M', 'hector.vega@mail.com', 1), -- Estudiante
	(175, 'Camila Díaz', 30, 'F', 'camila.diaz@mail.com', 2), -- Trabajador
	(176, 'Roberto Cifuentes', 41, 'M', 'roberto.cifuentes@mail.com', 2), -- Trabajador
	(177, 'Nicole Ibáñez', 52, 'F', 'nicole.ibanez@mail.com', 5), -- Jubilado
	(178, 'Daniel Ramos', 19, 'M', 'daniel.ramos@mail.com', 1), -- Estudiante
	(179, 'Vanessa Salas', 26, 'F', 'vanessa.salas@mail.com', 2), -- Trabajador
	(180, 'Mauricio Vera', 40, 'M', 'mauricio.vera@mail.com', 2), -- Trabajador
	(181, 'Claudia López', 21, 'F', 'claudia.lopez@mail.com', 1), -- Estudiante
	(182, 'Andrés Pérez', 32, 'M', 'andres.perez@mail.com', 2), -- Trabajador
	(183, 'Laura Soto', 29, 'F', 'laura.soto@mail.com', 2), -- Trabajador
	(184, 'Gonzalo Morales', 24, 'M', 'gonzalo.morales@mail.com', 1), -- Estudiante
	(185, 'Valeria Espinoza', 28, 'F', 'valeria.espinosa@mail.com', 2), -- Trabajador
	(186, 'Sebastián Guzmán', 46, 'M', 'sebastian.guzman@mail.com', 2), -- Trabajador
	(187, 'Fernanda Tapia', 57, 'F', 'fernanda.tapia@mail.com', 5), -- Jubilado
	(188, 'Felipe Cornejo', 18, 'M', 'felipe.cornejo@mail.com', 1), -- Estudiante
	(189, 'Antonia Vega', 25, 'F', 'antonia.vega@mail.com', 2), -- Trabajador
	(190, 'Nicolás Herrera', 39, 'M', 'nicolas.herrera@mail.com', 2), -- Trabajador
	(191, 'Sofía Díaz', 20, 'F', 'sofia.diaz@mail.com', 1), -- Estudiante
	(192, 'Esteban Reyes', 31, 'M', 'esteban.reyes@mail.com', 2), -- Trabajador
	(193, 'Javiera Morales', 27, 'F', 'javiera.morales@mail.com', 2), -- Trabajador
	(194, 'Maximiliano Gatica', 23, 'M', 'maximiliano.gatica@mail.com', 1), -- Estudiante
	(195, 'Paz Marín', 29, 'F', 'paz.marin@mail.com', 2), -- Trabajador
	(196, 'Cristian Soto', 48, 'M', 'cristian.soto@mail.com', 2), -- Trabajador
	(197, 'Romina Silva', 19, 'F', 'romina.silva@mail.com', 1), -- Estudiante
	(198, 'Marcelo Pérez', 34, 'M', 'marcelo.perez@mail.com', 2), -- Trabajador
	(199, 'Alejandra Fuentes', 26, 'F', 'alejandra.fuentes@mail.com', 2), -- Trabajador
	(200, 'Julio Bravo', 68, 'M', 'julio.bravo@mail.com', 5); -- Jubilado
    
    
    
    
CREATE TABLE Uso_Transporte_NEW (
    id_uso INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_ruta INT NOT NULL,
    id_horario INT NOT NULL,
    fecha DATE NOT NULL,
    hora_abordaje TIME NOT NULL,
    hora_descenso TIME NOT NULL,
    id_parada_abordaje INT NOT NULL,
    id_parada_descenso INT NOT NULL,
    ocupacion INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_ruta) REFERENCES Rutas(id_ruta) ON DELETE CASCADE,
    FOREIGN KEY (id_horario) REFERENCES Horarios(id_horario) ON DELETE CASCADE,
    FOREIGN KEY (id_parada_abordaje) REFERENCES Paradas(id_parada) ON DELETE CASCADE,
    FOREIGN KEY (id_parada_descenso) REFERENCES Paradas(id_parada) ON DELETE CASCADE,
    CONSTRAINT chk_ocupacion_positiva CHECK (ocupacion > 0)
);
            	
    INSERT INTO Uso_Transporte_NEW (id_uso, id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
(1, 1, 1, 1, '2025-09-11', '06:17:15', '06:40:15', 1, 21, 31),
(2, 2, 2, 6, '2025-09-11', '07:22:20', '07:44:20', 4, 24, 47),
(3, 2, 2, 9, '2025-09-11', '18:13:02', '18:33:02', 24, 4, 30), 
(4, 3, 3, 11, '2025-09-11', '07:49:15', '08:18:15', 7, 28, 48),
(5, 4, 4, 16, '2025-09-11', '06:19:10', '06:49:10', 10, 19, 41),
(6, 4, 4, 19, '2025-09-11', '17:35:45', '18:04:45', 19, 10, 42), 
(7, 5, 5, 21, '2025-09-11', '07:11:47', '07:37:47', 26, 2, 33),
(8, 6, 6, 25, '2025-09-11', '06:49:28', '07:09:28', 35, 24, 39),
(9, 7, 7, 29, '2025-09-11', '07:05:46', '07:31:46', 8, 28, 23),
(10, 8, 8, 33, '2025-09-11', '07:28:16', '07:54:16', 34, 31, 12),
(11, 8, 8, 35, '2025-09-11', '17:34:25', '17:56:25', 31, 34, 47), 
(12, 9, 1, 1, '2025-09-11', '08:00:23', '08:29:23', 2, 3, 37),
(13, 10, 2, 6, '2025-09-11', '08:03:52', '08:26:52', 5, 6, 24),
(14, 11, 3, 11, '2025-09-11', '06:50:31', '07:20:31', 29, 9, 36),
(15, 12, 4, 16, '2025-09-11', '07:29:08', '07:52:08', 19, 12, 49),
(16, 12, 4, 19, '2025-09-11', '18:14:04', '18:34:04', 12, 19, 31), 
(17, 13, 5, 21, '2025-09-11', '08:14:55', '08:44:55', 27, 3, 17),
(18, 14, 6, 25, '2025-09-11', '06:59:09', '07:20:09', 30, 23, 29),
(19, 15, 7, 29, '2025-09-11', '08:18:24', '08:42:24', 7, 9, 44),
(20, 16, 8, 33, '2025-09-11', '07:12:12', '07:37:12', 10, 12, 38),
(21, 16, 8, 35, '2025-09-11', '19:16:30', '19:37:30', 12, 10, 25), 
(22, 17, 1, 1, '2025-09-11', '06:26:40', '06:52:40', 21, 14, 21),
(23, 18, 2, 6, '2025-09-11', '07:11:03', '07:40:03', 24, 16, 43),
(24, 19, 3, 11, '2025-09-11', '07:38:09', '08:06:09', 28, 17, 16),
(25, 20, 4, 16, '2025-09-11', '08:00:23', '08:21:23', 11, 34, 34),
(26, 21, 5, 21, '2025-09-11', '07:51:24', '08:16:24', 27, 33, 46),
(27, 22, 6, 25, '2025-09-11', '07:44:50', '08:11:50', 30, 22, 28),
(28, 23, 7, 29, '2025-09-11', '06:19:47', '06:40:47', 29, 32, 20),
(29, 24, 8, 33, '2025-09-11', '08:24:26', '08:44:26', 31, 19, 14),
(30, 24, 8, 35, '2025-09-11', '17:39:18', '18:03:18', 19, 31, 39), 
(31, 25, 1, 1, '2025-09-11', '07:30:17', '07:54:17', 2, 13, 11),
(32, 26, 2, 6, '2025-09-11', '08:03:00', '08:23:00', 5, 31, 40),
(33, 27, 3, 11, '2025-09-11', '06:06:55', '06:33:55', 29, 8, 13),
(34, 28, 4, 16, '2025-09-11', '06:45:03', '07:12:03', 19, 20, 32),
(35, 29, 5, 21, '2025-09-11', '07:10:48', '07:39:48', 27, 21, 15),
(36, 30, 6, 25, '2025-09-11', '08:18:24', '08:40:24', 24, 22, 45),
(37, 31, 7, 29, '2025-09-11', '06:21:49', '06:45:49', 7, 29, 26),
(38, 32, 8, 33, '2025-09-11', '07:33:38', '07:53:38', 10, 25, 19),
(39, 32, 8, 35, '2025-09-11', '18:27:07', '18:49:07', 25, 10, 41), 
(40, 33, 1, 1, '2025-09-11', '08:18:07', '08:42:07', 21, 32, 44),
(41, 34, 2, 6, '2025-09-11', '06:47:49', '07:15:49', 5, 15, 17),
(42, 35, 3, 11, '2025-09-11', '07:07:37', '07:31:37', 28, 18, 30),
(43, 36, 4, 16, '2025-09-11', '08:15:43', '08:44:43', 19, 34, 48),
(44, 37, 5, 21, '2025-09-11', '06:55:04', '07:22:04', 2, 3, 22),
(45, 38, 6, 25, '2025-09-11', '07:29:56', '07:56:56', 30, 6, 35),
(46, 39, 7, 29, '2025-09-11', '06:53:14', '07:18:14', 29, 28, 10),
(47, 40, 8, 33, '2025-09-11', '06:14:48', '06:40:48', 34, 31, 27),
(48, 40, 8, 35, '2025-09-11', '18:31:35', '18:57:35', 31, 34, 18), 
(49, 41, 1, 1, '2025-09-11', '07:58:33', '08:24:33', 13, 3, 38),
(50, 42, 2, 6, '2025-09-11', '06:33:04', '06:53:04', 24, 15, 25),
(51, 43, 3, 11, '2025-09-11', '08:08:47', '08:35:47', 28, 17, 42),
(52, 44, 4, 16, '2025-09-11', '07:02:18', '07:32:18', 19, 20, 16),
(53, 45, 5, 21, '2025-09-11', '07:40:53', '08:08:53', 2, 21, 36),
(54, 46, 6, 25, '2025-09-11', '06:21:49', '06:44:49', 35, 24, 49),
(55, 47, 7, 29, '2025-09-11', '07:05:46', '07:34:46', 7, 29, 20),
(56, 48, 8, 33, '2025-09-11', '07:16:32', '07:44:32', 10, 31, 11),
(57, 48, 8, 35, '2025-09-11', '17:34:25', '17:59:25', 31, 10, 33), 
(58, 49, 1, 1, '2025-09-11', '07:05:46', '07:29:46', 2, 21, 30),
(59, 50, 2, 6, '2025-09-11', '07:29:56', '07:56:56', 5, 31, 45),
(60, 51, 3, 11, '2025-09-11', '07:16:32', '07:38:32', 28, 18, 12),
(61, 52, 4, 16, '2025-09-11', '07:51:24', '08:14:24', 19, 20, 39),
(62, 53, 5, 21, '2025-09-11', '06:40:15', '07:07:15', 26, 2, 26),
(63, 54, 6, 25, '2025-09-11', '08:00:23', '08:29:23', 30, 24, 41),
(64, 55, 7, 29, '2025-09-11', '07:30:17', '07:51:17', 29, 28, 14),
(65, 56, 8, 33, '2025-09-11', '06:36:20', '07:06:20', 31, 25, 23),
(66, 56, 8, 35, '2025-09-11', '18:18:24', '18:41:24', 25, 31, 46), 
(67, 57, 1, 1, '2025-09-11', '06:06:55', '06:26:55', 1, 2, 35),
(68, 58, 2, 6, '2025-09-11', '07:51:24', '08:11:24', 4, 5, 20),
(69, 59, 3, 11, '2025-09-11', '06:45:03', '07:13:03', 7, 29, 47),
(70, 60, 4, 16, '2025-09-11', '06:21:49', '06:47:49', 10, 19, 13),
(71, 61, 5, 21, '2025-09-11', '07:02:18', '07:22:18', 26, 27, 40),
(72, 62, 6, 25, '2025-09-11', '07:38:09', '08:00:09', 35, 30, 27),
(73, 63, 7, 29, '2025-09-11', '06:00:23', '06:28:23', 8, 7, 18),
(74, 64, 8, 33, '2025-09-11', '07:44:50', '08:12:50', 34, 10, 36),
(75, 64, 8, 35, '2025-09-11', '18:50:23', '19:15:23', 10, 34, 49), 
(76, 65, 1, 1, '2025-09-11', '06:33:04', '07:00:04', 1, 2, 49),
(77, 66, 2, 6, '2025-09-11', '08:18:07', '08:42:07', 4, 5, 22),
(78, 67, 3, 11, '2025-09-11', '06:26:40', '06:50:40', 7, 29, 31),
(79, 68, 4, 16, '2025-09-11', '07:11:03', '07:34:03', 10, 19, 10),
(80, 69, 5, 21, '2025-09-11', '07:22:04', '07:44:04', 26, 2, 43),
(81, 70, 6, 25, '2025-09-11', '06:17:15', '06:40:15', 35, 30, 17),
(82, 71, 7, 29, '2025-09-11', '07:49:15', '08:13:15', 8, 7, 34),
(83, 72, 8, 33, '2025-09-11', '06:19:10', '06:41:10', 31, 25, 26),
(84, 72, 8, 35, '2025-09-11', '19:07:59', '19:30:59', 25, 31, 40), 
(85, 73, 1, 1, '2025-09-11', '07:11:47', '07:37:47', 21, 13, 14),
(86, 74, 2, 6, '2025-09-11', '07:05:46', '07:33:46', 24, 31, 36),
(87, 75, 3, 11, '2025-09-11', '08:03:52', '08:32:52', 28, 8, 41),
(88, 76, 4, 16, '2025-09-11', '07:29:08', '07:56:08', 11, 25, 12),
(89, 77, 5, 21, '2025-09-11', '08:14:55', '08:40:55', 27, 21, 37),
(90, 78, 6, 25, '2025-09-11', '06:59:09', '07:24:09', 6, 22, 21),
(91, 79, 7, 29, '2025-09-11', '07:58:33', '08:28:33', 7, 29, 30),
(92, 80, 8, 33, '2025-09-11', '06:55:04', '07:25:04', 34, 10, 47),
(93, 80, 8, 35, '2025-09-11', '19:23:42', '19:48:42', 10, 34, 15), 
(94, 81, 1, 1, '2025-09-11', '06:21:49', '06:47:49', 14, 3, 29),
(95, 82, 2, 6, '2025-09-11', '07:44:50', '08:06:50', 31, 15, 46),
(96, 83, 3, 11, '2025-09-11', '06:19:47', '06:49:47', 29, 28, 18),
(97, 84, 4, 16, '2025-09-11', '08:24:26', '08:44:26', 11, 20, 32),
(98, 85, 5, 21, '2025-09-11', '07:30:17', '07:57:17', 2, 21, 24),
(99, 86, 6, 25, '2025-09-11', '06:36:20', '07:05:20', 24, 6, 40),
(100, 87, 7, 29, '2025-09-11', '07:02:18', '07:22:18', 7, 29, 10),
(101, 88, 8, 33, '2025-09-11', '07:51:24', '08:18:24', 34, 31, 37),
(102, 88, 8, 35, '2025-09-11', '18:03:52', '18:29:52', 31, 34, 13), 
(103, 89, 1, 1, '2025-09-11', '07:10:48', '07:30:48', 21, 13, 20),
(104, 90, 2, 6, '2025-09-11', '06:55:04', '07:17:04', 31, 15, 34),
(105, 91, 3, 11, '2025-09-11', '08:18:24', '08:42:24', 29, 28, 46),
(106, 92, 4, 16, '2025-09-11', '06:06:55', '06:33:55', 10, 19, 19),
(107, 93, 5, 21, '2025-09-11', '07:38:09', '08:08:09', 27, 2, 31),
(108, 94, 6, 25, '2025-09-11', '06:45:03', '07:07:03', 6, 22, 16),
(109, 95, 7, 29, '2025-09-11', '07:22:04', '07:44:04', 28, 32, 49),
(110, 96, 8, 33, '2025-09-11', '06:00:23', '06:29:23', 31, 25, 28),
(111, 96, 8, 35, '2025-09-11', '19:16:30', '19:46:30', 25, 31, 43), 
(112, 97, 1, 1, '2025-09-11', '07:05:46', '07:26:46', 13, 32, 27),
(113, 98, 2, 6, '2025-09-11', '08:00:23', '08:29:23', 24, 15, 36),
(114, 99, 3, 11, '2025-09-11', '06:17:15', '06:47:15', 7, 29, 11),
(115, 100, 4, 16, '2025-09-11', '07:49:15', '08:15:15', 19, 11, 38),
(116, 101, 5, 21, '2025-09-11', '07:29:08', '07:54:08', 2, 33, 25),
(117, 102, 6, 25, '2025-09-11', '08:14:55', '08:44:55', 30, 24, 47),
(118, 103, 7, 29, '2025-09-11', '06:59:09', '07:20:09', 29, 28, 19),
(119, 104, 8, 33, '2025-09-11', '07:11:03', '07:31:03', 10, 31, 32),
(120, 104, 8, 35, '2025-09-11', '18:47:04', '19:10:04', 31, 10, 45),
(121, 105, 1, 1, '2025-09-11', '06:26:40', '06:56:40', 1, 2, 10),
(122, 106, 2, 6, '2025-09-11', '07:38:09', '08:07:09', 4, 5, 30),
(123, 107, 3, 11, '2025-09-11', '08:03:00', '08:31:00', 7, 29, 40),
(124, 108, 4, 16, '2025-09-11', '06:06:55', '06:36:55', 10, 19, 14),
(125, 109, 5, 21, '2025-09-11', '07:10:48', '07:30:48', 26, 27, 39),
(126, 110, 6, 25, '2025-09-11', '08:18:07', '08:42:07', 35, 30, 27),
(127, 111, 7, 29, '2025-09-11', '06:21:49', '06:44:49', 8, 7, 13),
(128, 112, 8, 33, '2025-09-11', '07:33:38', '07:59:38', 34, 31, 35),
(129, 112, 8, 35, '2025-09-11', '19:02:18', '19:25:18', 31, 34, 48), 
(130, 113, 1, 1, '2025-09-11', '07:02:18', '07:22:18', 21, 13, 16),
(131, 114, 2, 6, '2025-09-11', '06:40:15', '07:09:15', 5, 24, 33),
(132, 115, 3, 11, '2025-09-11', '07:51:24', '08:16:24', 28, 8, 41),
(133, 116, 4, 16, '2025-09-11', '06:47:49', '07:11:49', 19, 11, 22),
(134, 117, 5, 21, '2025-09-11', '08:00:23', '08:29:23', 27, 21, 37),
(135, 118, 6, 25, '2025-09-11', '07:11:03', '07:40:03', 24, 6, 20),
(136, 119, 7, 29, '2025-09-11', '07:22:04', '07:48:04', 7, 29, 44),
(137, 120, 8, 33, '2025-09-11', '06:33:04', '07:03:04', 34, 10, 15),
(138, 120, 8, 35, '2025-09-11', '17:39:18', '18:00:18', 10, 34, 38),
(139, 121, 1, 1, '2025-09-11', '07:40:53', '08:07:53', 2, 13, 29),
(140, 122, 2, 6, '2025-09-11', '06:21:49', '06:48:49', 4, 24, 49),
(141, 123, 3, 11, '2025-09-11', '06:53:14', '07:21:14', 29, 28, 10),
(142, 124, 4, 16, '2025-09-11', '07:58:33', '08:26:33', 19, 11, 30),
(143, 125, 5, 21, '2025-09-11', '06:17:15', '06:46:15', 26, 27, 46),
(144, 126, 6, 25, '2025-09-11', '07:44:50', '08:09:50', 30, 24, 28),
(145, 127, 7, 29, '2025-09-11', '08:18:24', '08:44:24', 28, 32, 20),
(146, 128, 8, 33, '2025-09-11', '06:45:03', '07:13:03', 31, 25, 14),
(147, 128, 8, 35, '2025-09-11', '18:13:02', '18:37:02', 25, 31, 39), 
(148, 129, 1, 1, '2025-09-11', '07:30:17', '07:50:17', 1, 2, 11),
(149, 130, 2, 6, '2025-09-11', '06:36:20', '07:05:20', 4, 5, 40),
(150, 131, 3, 11, '2025-09-11', '07:02:18', '07:22:18', 7, 29, 13),
(151, 132, 4, 16, '2025-09-11', '08:03:00', '08:23:00', 10, 19, 32),
(152, 133, 5, 21, '2025-09-11', '07:22:04', '07:47:04', 27, 21, 15),
(153, 134, 6, 25, '2025-09-11', '06:55:04', '07:15:04', 35, 30, 45),
(154, 135, 7, 29, '2025-09-11', '06:00:23', '06:26:23', 29, 28, 26),
(155, 136, 8, 33, '2025-09-11', '07:10:48', '07:30:48', 34, 10, 19),
(156, 136, 8, 35, '2025-09-11', '19:07:59', '19:35:59', 10, 34, 41), 
(157, 137, 1, 1, '2025-09-11', '06:40:15', '07:02:15', 1, 2, 44),
(158, 138, 2, 6, '2025-09-11', '07:51:24', '08:14:24', 4, 5, 17),
(159, 139, 3, 11, '2025-09-11', '06:33:04', '06:53:04', 7, 29, 30),
(160, 140, 4, 16, '2025-09-11', '08:18:07', '08:44:07', 10, 19, 48),
(161, 141, 5, 21, '2025-09-11', '07:29:56', '07:56:56', 26, 2, 22),
(162, 142, 6, 25, '2025-09-11', '06:59:09', '07:20:09', 24, 31, 35),
(163, 143, 7, 29, '2025-09-11', '07:16:32', '07:41:32', 29, 28, 10),
(164, 144, 8, 33, '2025-09-11', '06:21:49', '06:48:49', 34, 31, 27),
(165, 144, 8, 35, '2025-09-11', '19:16:30', '19:41:30', 31, 34, 18), 
(166, 145, 1, 1, '2025-09-11', '07:05:46', '07:33:46', 13, 32, 38),
(167, 146, 2, 6, '2025-09-11', '08:03:52', '08:26:52', 15, 16, 25),
(168, 147, 3, 11, '2025-09-11', '07:49:15', '08:16:15', 8, 18, 42),
(169, 148, 4, 16, '2025-09-11', '06:19:47', '06:45:47', 19, 11, 16),
(170, 149, 5, 21, '2025-09-11', '08:14:55', '08:42:55', 2, 21, 36),
(171, 150, 6, 25, '2025-09-11', '06:33:04', '07:00:04', 30, 24, 49),
(172, 151, 7, 29, '2025-09-11', '07:58:33', '08:21:33', 29, 28, 20),
(173, 152, 8, 33, '2025-09-11', '06:55:04', '07:25:04', 31, 25, 11),
(174, 152, 8, 35, '2025-09-11', '18:18:24', '18:41:24', 25, 31, 33), 
(175, 153, 1, 1, '2025-09-11', '06:21:49', '06:48:49', 21, 14, 29),
(176, 154, 2, 6, '2025-09-11', '07:44:50', '08:11:50', 5, 15, 46),
(177, 155, 3, 11, '2025-09-11', '06:19:47', '06:49:47', 7, 29, 18),
(178, 156, 4, 16, '2025-09-11', '08:24:26', '08:44:26', 11, 20, 32),
(179, 157, 5, 21, '2025-09-11', '07:30:17', '07:57:17', 27, 21, 24),
(180, 158, 6, 25, '2025-09-11', '06:36:20', '07:05:20', 30, 24, 40),
(181, 159, 7, 29, '2025-09-11', '07:02:18', '07:22:18', 29, 28, 10),
(182, 160, 8, 33, '2025-09-11', '07:51:24', '08:18:24', 34, 31, 37),
(183, 160, 8, 35, '2025-09-11', '18:03:52', '18:29:52', 31, 34, 13), 
(184, 161, 1, 1, '2025-09-11', '07:10:48', '07:30:48', 21, 13, 20),
(185, 162, 2, 6, '2025-09-11', '06:55:04', '07:17:04', 31, 15, 34),
(186, 163, 3, 11, '2025-09-11', '08:18:24', '08:42:24', 29, 28, 46),
(187, 164, 4, 16, '2025-09-11', '06:06:55', '06:33:55', 10, 19, 19),
(188, 165, 5, 21, '2025-09-11', '07:38:09', '08:08:09', 27, 2, 31),
(189, 166, 6, 25, '2025-09-11', '06:45:03', '07:07:03', 6, 22, 16),
(190, 167, 7, 29, '2025-09-11', '07:22:04', '07:44:04', 28, 32, 49),
(191, 168, 8, 33, '2025-09-11', '06:00:23', '06:29:23', 31, 25, 28),
(192, 168, 8, 35, '2025-09-11', '19:16:30', '19:46:30', 25, 31, 43), 
(193, 169, 1, 1, '2025-09-11', '07:05:46', '07:26:46', 13, 32, 27),
(194, 170, 2, 6, '2025-09-11', '08:00:23', '08:29:23', 24, 15, 36),
(195, 171, 3, 11, '2025-09-11', '06:17:15', '06:47:15', 7, 29, 11),
(196, 172, 4, 16, '2025-09-11', '07:49:15', '08:15:15', 19, 11, 38),
(197, 173, 5, 21, '2025-09-11', '07:29:08', '07:54:08', 2, 33, 25),
(198, 174, 6, 25, '2025-09-11', '08:14:55', '08:44:55', 30, 24, 47),
(199, 175, 7, 29, '2025-09-11', '06:59:09', '07:20:09', 29, 28, 19),
(200, 176, 8, 33, '2025-09-11', '07:11:03', '07:31:03', 10, 31, 32),
(201, 176, 8, 35, '2025-09-11', '18:47:04', '19:10:04', 31, 10, 45), 
(202, 177, 1, 1, '2025-09-11', '06:26:40', '06:56:40', 1, 2, 10),
(203, 178, 2, 6, '2025-09-11', '07:38:09', '08:07:09', 4, 5, 30),
(204, 179, 3, 11, '2025-09-11', '08:03:00', '08:31:00', 7, 29, 40),
(205, 180, 4, 16, '2025-09-11', '06:06:55', '06:36:55', 10, 19, 14),
(206, 181, 5, 21, '2025-09-11', '07:10:48', '07:30:48', 26, 27, 39),
(207, 182, 6, 25, '2025-09-11', '08:18:07', '08:42:07', 35, 30, 27),
(208, 183, 7, 29, '2025-09-11', '06:21:49', '06:44:49', 8, 7, 13),
(209, 184, 8, 33, '2025-09-11', '07:33:38', '07:59:38', 34, 31, 35),
(210, 184, 8, 35, '2025-09-11', '19:02:18', '19:25:18', 31, 34, 48), 
(211, 185, 1, 1, '2025-09-11', '07:02:18', '07:22:18', 21, 13, 16),
(212, 186, 2, 6, '2025-09-11', '06:40:15', '07:09:15', 5, 24, 33),
(213, 187, 3, 11, '2025-09-11', '07:51:24', '08:16:24', 28, 8, 41),
(214, 188, 4, 16, '2025-09-11', '06:47:49', '07:11:49', 19, 11, 22),
(215, 189, 5, 21, '2025-09-11', '08:00:23', '08:29:23', 27, 21, 37),
(216, 190, 6, 25, '2025-09-11', '07:11:03', '07:40:03', 24, 6, 20),
(217, 191, 7, 29, '2025-09-11', '07:22:04', '07:48:04', 7, 29, 44),
(218, 192, 8, 33, '2025-09-11', '06:33:04', '07:03:04', 34, 10, 15),
(219, 192, 8, 35, '2025-09-11', '17:39:18', '18:00:18', 10, 34, 38), 
(220, 193, 1, 1, '2025-09-11', '07:40:53', '08:07:53', 2, 13, 29),
(221, 194, 2, 6, '2025-09-11', '06:21:49', '06:48:49', 4, 24, 49),
(222, 195, 3, 11, '2025-09-11', '06:53:14', '07:21:14', 29, 28, 10),
(223, 196, 4, 16, '2025-09-11', '07:58:33', '08:26:33', 19, 11, 30),
(224, 197, 5, 21, '2025-09-11', '06:17:15', '06:46:15', 26, 27, 46),
(225, 198, 6, 25, '2025-09-11', '07:44:50', '08:09:50', 30, 24, 28),
(226, 199, 7, 29, '2025-09-11', '08:18:24', '08:44:24', 28, 32, 20),
(227, 200, 8, 33, '2025-09-11', '06:45:03', '07:13:03', 31, 25, 14),
(228, 200, 8, 35, '2025-09-11', '18:13:02', '18:37:02', 25, 31, 39); 


CREATE TABLE Costos_Operacion (
    id_costo INT PRIMARY KEY AUTO_INCREMENT,
    id_ruta INT NOT NULL UNIQUE, -- id_ruta ahora es NOT NULL y UNIQUE
    combustible DECIMAL(10,2) NOT NULL DEFAULT 0, -- NOT NULL, DEFAULT 0 y será >0 por CHECK
    mantenimiento DECIMAL(10,2) NOT NULL DEFAULT 0, -- NOT NULL, DEFAULT 0 y será >0 por CHECK
    otros_costos DECIMAL(10,2) NOT NULL DEFAULT 0, -- NOT NULL, DEFAULT 0 y será >0 por CHECK
    FOREIGN KEY (id_ruta) REFERENCES Rutas(id_ruta) ON DELETE CASCADE, 
    CONSTRAINT chk_costos_positivos CHECK (combustible > 0 AND mantenimiento > 0 AND otros_costos > 0)
);

INSERT INTO Costos_Operacion (id_costo, id_ruta, combustible, mantenimiento, otros_costos) VALUES
	(1, 1, 1500.75, 850.20, 320.50),   -- Ruta Norte
	(2, 2, 1400.00, 780.00, 290.00),   -- Ruta Sur
	(3, 3, 1350.50, 720.50, 275.25),   -- Ruta Este
	(4, 4, 1620.10, 910.80, 350.70),   -- Ruta Oeste
	(5, 5, 1180.25, 650.10, 240.30),   -- Ruta Noroeste
	(6, 6, 1050.80, 590.30, 210.15),   -- Ruta Sureste
	(7, 7, 1230.90, 680.60, 260.40),   -- Ruta Noreste
	(8, 8, 980.50, 520.40, 190.90);    -- Ruta Suroeste
    
