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

select * from horarios;
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
    nombre VARCHAR(500) NOT NULL,
    edad INT NOT NULL,
    genero ENUM('M','F','Otro'),
    email VARCHAR(500) NOT NULL UNIQUE,
    id_tipo_usuario INT NOT NULL, 
    FOREIGN KEY (id_tipo_usuario) REFERENCES Tipo_Usuario(id_tipo_usuario) ON DELETE RESTRICT 
);



INSERT INTO Usuarios (nombre, edad, genero, email, id_tipo_usuario) VALUES
    ('Ana Torres', 25, 'F', 'ana.torres_1@mail.com', 2),
    ('Carlos Pérez', 32, 'M', 'carlos.perez_2@mail.com', 2),
    ('María Gómez', 20, 'F', 'maria.gomez_3@mail.com', 1),
    ('Luis Ramírez', 40, 'M', 'luis.ramirez_4@mail.com', 2),
    ('Paola Sánchez', 22, 'F', 'paola.sanchez_5@mail.com', 1),
    ('Andrés Silva', 30, 'M', 'andres.silva_6@mail.com', 2),
    ('Elena Ríos', 21, 'F', 'elena.rios_7@mail.com', 1),
    ('Javier Castro', 35, 'M', 'javier.castro_8@mail.com', 2),
    ('Lucía Fernández', 19, 'F', 'lucia.fernandez_9@mail.com', 1),
    ('Mateo Herrera', 29, 'M', 'mateo.herrera_10@mail.com', 2),
    ('Valeria Ortiz', 33, 'F', 'valeria.ortiz_11@mail.com', 2),
    ('Fernando López', 41, 'M', 'fernando.lopez_12@mail.com', 2),
    ('Isabel Morales', 24, 'F', 'isabel.morales_13@mail.com', 1),
    ('Daniel Cruz', 38, 'M', 'daniel.cruz_14@mail.com', 2),
    ('Camila Vega', 21, 'F', 'camila.vega_15@mail.com', 3),
    ('Ricardo Peña', 36, 'M', 'ricardo.pena_16@mail.com', 2),
    ('Gabriela León', 26, 'F', 'gabriela.leon_17@mail.com', 1),
    ('Sebastián Ruiz', 31, 'M', 'sebastian.ruiz_18@mail.com', 2),
    ('Laura Delgado', 23, 'F', 'laura.delgado_19@mail.com', 3),
    ('Tomás Bravo', 27, 'M', 'tomas.bravo_20@mail.com', 1),
    ('Sofía Ramos', 20, 'F', 'sofia.ramos_21@mail.com', 1),
    ('Alejandro Vargas', 34, 'M', 'alejandro.vargas_22@mail.com', 2),
    ('Martina Soto', 29, 'F', 'martina.soto_23@mail.com', 2),
    ('Diego Navarro', 23, 'M', 'diego.navarro_24@mail.com', 1),
    ('Paula Montes', 28, 'F', 'paula.montes_25@mail.com', 2),
    ('Gabriel Guzmán', 45, 'M', 'gabriel.guzman_26@mail.com', 2),
    ('Silvia Romero', 55, 'F', 'silvia.romero_27@mail.com', 5),
    ('Emilio Cifuentes', 18, 'M', 'emilio.cifuentes_28@mail.com', 1),
    ('Natalia Luna', 25, 'F', 'natalia.luna_29@mail.com', 2),
    ('Jorge Rivas', 39, 'M', 'jorge.rivas_30@mail.com', 2),
    ('Daniela Rojas', 22, 'F', 'daniela.rojas_31@mail.com', 1),
    ('Felipe Morales', 30, 'M', 'felipe.morales_32@mail.com', 2),
    ('Andrea Salas', 27, 'F', 'andrea.salas_33@mail.com', 2),
    ('Juan Peña', 58, 'M', 'juan.pena_34@mail.com', 5),
    ('Victoria Flores', 20, 'F', 'victoria.flores_35@mail.com', 1),
    ('Manuel Cortés', 31, 'M', 'manuel.cortes_36@mail.com', 2),
    ('Luciana Paredes', 24, 'F', 'luciana.paredes_37@mail.com', 1),
    ('Benjamín Vidal', 42, 'M', 'benjamin.vidal_38@mail.com', 2),
    ('Ximena Bustos', 26, 'F', 'ximena.bustos_39@mail.com', 2),
    ('Pedro Díaz', 62, 'M', 'pedro.diaz_40@mail.com', 5),
    ('Ignacia Soto', 21, 'F', 'ignacia.soto_41@mail.com', 1),
    ('Gonzalo Olivares', 37, 'M', 'gonzalo.olivares_42@mail.com', 2),
    ('Antonella Soto', 28, 'F', 'antonella.soto_43@mail.com', 2),
    ('Cristóbal Leiva', 23, 'M', 'cristobal.leiva_44@mail.com', 1),
    ('Francisca Miranda', 29, 'F', 'francisca.miranda_45@mail.com', 2),
    ('José Garrido', 48, 'M', 'jose.garrido_46@mail.com', 2),
    ('Florencia Núñez', 19, 'F', 'florencia.nunez_47@mail.com', 1),
    ('Joaquín Salas', 33, 'M', 'joaquin.salas_48@mail.com', 2),
    ('Sofía Cifuentes', 25, 'F', 'sofia.cifuentes_49@mail.com', 2),
    ('Esteban Gatica', 65, 'M', 'esteban.gatica_50@mail.com', 5),
    ('Martina Cortés', 20, 'F', 'martina.cortes_51@mail.com', 1),
    ('Sebastián Ramos', 36, 'M', 'sebastian.ramos_52@mail.com', 2),
    ('Valentina Soto', 27, 'F', 'valentina.soto_53@mail.com', 2),
    ('Lucas Fuentes', 22, 'M', 'lucas.fuentes_54@mail.com', 1),
    ('Renata Rojas', 30, 'F', 'renata.rojas_55@mail.com', 2),
    ('Diego Herrera', 41, 'M', 'diego.herrera_56@mail.com', 2),
    ('Emilia Vidal', 18, 'F', 'emilia.vidal_57@mail.com', 1),
    ('Javier Pérez', 34, 'M', 'javier.perez2_58@mail.com', 2),
    ('Catalina Vega', 26, 'F', 'catalina.vega_59@mail.com', 2),
    ('Gabriel Castro', 59, 'M', 'gabriel.castro_60@mail.com', 5),
    ('Rocío Morales', 21, 'F', 'rocio.morales_61@mail.com', 1),
    ('Pablo Navarro', 32, 'M', 'pablo.navarro_62@mail.com', 2),
    ('Carla Ibáñez', 29, 'F', 'carla.ibanez_63@mail.com', 2),
    ('Arturo Garcés', 24, 'M', 'arturo.garces_64@mail.com', 1),
    ('Pilar Espinoza', 28, 'F', 'pilar.espinoza_65@mail.com', 2),
    ('Marcelo Núñez', 46, 'M', 'marcelo.nunez_66@mail.com', 2),
    ('Viviana Soto', 57, 'F', 'viviana.soto_67@mail.com', 5),
    ('Omar Reyes', 19, 'M', 'omar.reyes_68@mail.com', 1),
    ('Constanza Vera', 25, 'F', 'constanza.vera_69@mail.com', 2),
    ('Ricardo Flores', 38, 'M', 'ricardo.flores_70@mail.com', 2),
    ('Fernanda Rojas', 22, 'F', 'fernanda.rojas_71@mail.com', 1),
    ('Álvaro Cruz', 30, 'M', 'alvaro.cruz_72@mail.com', 2),
    ('Cristina Gómez', 27, 'F', 'cristina.gomez_73@mail.com', 2),
    ('Marco Morales', 60, 'M', 'marco.morales_74@mail.com', 5),
    ('Daniela Vidal', 20, 'F', 'daniela.vidal_75@mail.com', 1),
    ('Patricio Rivas', 31, 'M', 'patricio.rivas_76@mail.com', 2),
    ('Paulina Silva', 24, 'F', 'paulina.silva_77@mail.com', 1),
    ('Jorge Herrera', 43, 'M', 'jorge.herrera_78@mail.com', 2),
    ('Andrea Tapia', 26, 'F', 'andrea.tapia_79@mail.com', 2),
    ('Francisco Soto', 63, 'M', 'francisco.soto_80@mail.com', 5),
    ('Alejandra Núñez', 21, 'F', 'alejandra.nunez_81@mail.com', 1),
    ('Luis Gatica', 37, 'M', 'luis.gatica_82@mail.com', 2),
    ('Carolina Fuentes', 28, 'F', 'carolina.fuentes_83@mail.com', 2),
    ('Sergio Leiva', 23, 'M', 'sergio.leiva_84@mail.com', 1),
    ('Pamela Bustos', 29, 'F', 'pamela.bustos_85@mail.com', 2),
    ('Héctor Díaz', 49, 'M', 'hector.diaz_86@mail.com', 2),
    ('Camila Espinoza', 19, 'F', 'camila.espinosa_87@mail.com', 1),
    ('Roberto Guzmán', 33, 'M', 'roberto.guzman_88@mail.com', 2),
    ('Nicole Ramos', 25, 'F', 'nicole.ramos_89@mail.com', 2),
    ('Daniel Salas', 66, 'M', 'daniel.salas_90@mail.com', 5),
    ('Vanessa Montes', 20, 'F', 'vanessa.montes_91@mail.com', 1),
    ('Mauricio Vega', 35, 'M', 'mauricio.vega_92@mail.com', 2),
    ('Claudia Ibáñez', 27, 'F', 'claudia.ibanez_93@mail.com', 2),
    ('Andrés Vera', 22, 'M', 'andres.vera_94@mail.com', 1),
    ('Laura Morales', 30, 'F', 'laura.morales_95@mail.com', 2),
    ('Gonzalo Peña', 40, 'M', 'gonzalo.pena_96@mail.com', 2),
    ('Valeria Silva', 50, 'F', 'valeria.silva_97@mail.com', 5),
    ('Sebastián Miranda', 18, 'M', 'sebastian.miranda_98@mail.com', 1),
    ('Fernanda Castro', 24, 'F', 'fernanda.castro_99@mail.com', 2),
    ('Felipe Soto', 39, 'M', 'felipe.soto_100@mail.com', 2);

INSERT INTO Usuarios (nombre, edad, genero, email, id_tipo_usuario) VALUES
    ('Martina Leiva', 21, 'F', 'martina.leiva_101@mail.com', 1),
    ('Álvaro Olivares', 31, 'M', 'alvaro.olivares_102@mail.com', 2),
    ('Antonia Guzmán', 28, 'F', 'antonia.guzman_103@mail.com', 2),
    ('Nicolás Rivas', 23, 'M', 'nicolas.rivas_104@mail.com', 1),
    ('Sofía Vera', 29, 'F', 'sofia.vera_105@mail.com', 2),
    ('Esteban Ibáñez', 47, 'M', 'esteban.ibanez_106@mail.com', 2),
    ('Javiera Díaz', 56, 'F', 'javiera.diaz_107@mail.com', 5),
    ('Maximiliano Cifuentes', 19, 'M', 'maximiliano.cifuentes_108@mail.com', 1),
    ('Paz Fuentes', 25, 'F', 'paz.fuentes_109@mail.com', 2),
    ('Cristian Vidal', 38, 'M', 'cristian.vidal_110@mail.com', 2),
    ('Romina Morales', 22, 'F', 'romina.morales_111@mail.com', 1),
    ('Marcelo Herrera', 30, 'M', 'marcelo.herrera_112@mail.com', 2),
    ('Alejandra Pérez', 27, 'F', 'alejandra.perez_113@mail.com', 2),
    ('Julio Flores', 61, 'M', 'julio.flores_114@mail.com', 5),
    ('Constanza Rojas', 20, 'F', 'constanza.rojas_115@mail.com', 1),
    ('Vicente Silva', 31, 'M', 'vicente.silva_116@mail.com', 2),
    ('Beatriz Tapia', 24, 'F', 'beatriz.tapia_117@mail.com', 1),
    ('Carlos Garcés', 42, 'M', 'carlos.garces_118@mail.com', 2),
    ('Natalia Espinosa', 26, 'F', 'natalia.espinosa_119@mail.com', 2),
    ('Benjamín Navarro', 64, 'M', 'benjamin.navarro_120@mail.com', 5),
    ('Florencia Reyes', 21, 'F', 'florencia.reyes_121@mail.com', 1),
    ('Gabriel Vásquez', 36, 'M', 'gabriel.vasquez_122@mail.com', 2),
    ('Isidora Núñez', 28, 'F', 'isidora.nunez_123@mail.com', 2),
    ('Diego Cornejo', 23, 'M', 'diego.cornejo_124@mail.com', 1),
    ('Ignacia Vargas', 29, 'F', 'ignacia.vargas_125@mail.com', 2),
    ('Matías Soto', 48, 'M', 'matias.soto_126@mail.com', 2),
    ('Sofía Morales', 18, 'F', 'sofia.morales_127@mail.com', 1),
    ('Emiliano Pérez', 33, 'M', 'emiliano.perez_128@mail.com', 2),
    ('Daniela Bustos', 25, 'F', 'daniela.bustos_129@mail.com', 2),
    ('Manuel Rojas', 67, 'M', 'manuel.rojas_130@mail.com', 5),
    ('Javiera Fuentes', 20, 'F', 'javiera.fuentes_131@mail.com', 1),
    ('Fernando Leiva', 35, 'M', 'fernando.leiva_132@mail.com', 2),
    ('Valeria Herrera', 27, 'F', 'valeria.herrera_133@mail.com', 2),
    ('Andrés Díaz', 22, 'M', 'andres.diaz_134@mail.com', 1),
    ('Camila Sánchez', 30, 'F', 'camila.sanchez_135@mail.com', 2),
    ('Nicolás Silva', 41, 'M', 'nicolas.silva_136@mail.com', 2),
    ('Lucía Gómez', 52, 'F', 'lucia.gomez_137@mail.com', 5),
    ('Pedro Tapia', 19, 'M', 'pedro.tapia_138@mail.com', 1),
    ('María Fernanda Morales', 26, 'F', 'maria.fernanda.morales_139@mail.com', 2),
    ('Sebastián Ramos', 40, 'M', 'sebastian.ramos_140@mail.com', 2),
    ('Valentina Soto', 21, 'F', 'valentina.soto_141@mail.com', 1),
    ('Lucas Espinosa', 32, 'M', 'lucas.espinosa_142@mail.com', 2),
    ('Renata Vega', 29, 'F', 'renata.vega_143@mail.com', 2),
    ('Diego Cifuentes', 24, 'M', 'diego.cifuentes_144@mail.com', 1),
    ('Emilia Gatica', 28, 'F', 'emilia.gatica_145@mail.com', 2),
    ('Javier Ibáñez', 46, 'M', 'javier.ibanez_146@mail.com', 2),
    ('Catalina Navarro', 57, 'F', 'catalina.navarro_147@mail.com', 5),
    ('Gabriel Cortés', 18, 'M', 'gabriel.cortes_148@mail.com', 1),
    ('Rocío Salas', 25, 'F', 'rocio.salas_149@mail.com', 2),
    ('Pablo Miranda', 38, 'M', 'pablo.miranda_150@mail.com', 2);

INSERT INTO Usuarios (nombre, edad, genero, email, id_tipo_usuario) VALUES
    ('Carla Vásquez', 22, 'F', 'carla.vasquez_151@mail.com', 1),
    ('Arturo Reyes', 30, 'M', 'arturo.reyes_152@mail.com', 2),
    ('Pilar Flores', 27, 'F', 'pilar.flores_153@mail.com', 2),
    ('Marcelo Vera', 60, 'M', 'marcelo.vera_154@mail.com', 5),
    ('Viviana Cruz', 20, 'F', 'viviana.cruz_155@mail.com', 1),
    ('Omar Garcés', 31, 'M', 'omar.garces_156@mail.com', 2),
    ('Constanza Herrera', 24, 'F', 'constanza.herrera_157@mail.com', 1),
    ('Ricardo Núñez', 43, 'M', 'ricardo.nunez_158@mail.com', 2),
    ('Fernanda Garcés', 26, 'F', 'fernanda.garces_159@mail.com', 2),
    ('Álvaro Soto', 63, 'M', 'alvaro.soto_160@mail.com', 5),
    ('Cristina Gómez', 21, 'F', 'cristina.gomez_161@mail.com', 1),
    ('Marco Morales', 37, 'M', 'marco.morales_162@mail.com', 2),
    ('Daniela Tapia', 28, 'F', 'daniela.tapia_163@mail.com', 2),
    ('Patricio Silva', 23, 'M', 'patricio.silva_164@mail.com', 1),
    ('Paulina Pérez', 29, 'F', 'paulina.perez_165@mail.com', 2),
    ('Jorge Vidal', 49, 'M', 'jorge.vidal_166@mail.com', 2),
    ('Andrea Miranda', 19, 'F', 'andrea.miranda_167@mail.com', 1),
    ('Francisco Herrera', 33, 'M', 'francisco.herrera_168@mail.com', 2),
    ('Alejandra Montes', 25, 'F', 'alejandra.montes_169@mail.com', 2),
    ('Luis Bustos', 66, 'M', 'luis.bustos_170@mail.com', 5),
    ('Carolina Leiva', 20, 'F', 'carolina.leiva_171@mail.com', 1),
    ('Sergio Rojas', 35, 'M', 'sergio.rojas_172@mail.com', 2),
    ('Pamela Fuentes', 27, 'F', 'pamela.fuentes_173@mail.com', 2),
    ('Héctor Vega', 22, 'M', 'hector.vega_174@mail.com', 1),
    ('Camila Díaz', 30, 'F', 'camila.diaz_175@mail.com', 2),
    ('Roberto Cifuentes', 41, 'M', 'roberto.cifuentes_176@mail.com', 2),
    ('Nicole Ibáñez', 52, 'F', 'nicole.ibanez_177@mail.com', 5),
    ('Daniel Ramos', 19, 'M', 'daniel.ramos_178@mail.com', 1),
    ('Vanessa Salas', 26, 'F', 'vanessa.salas_179@mail.com', 2),
    ('Mauricio Vera', 40, 'M', 'mauricio.vera_180@mail.com', 2),
    ('Claudia López', 21, 'F', 'claudia.lopez_181@mail.com', 1),
    ('Andrés Pérez', 32, 'M', 'andres.perez_182@mail.com', 2),
    ('Laura Soto', 29, 'F', 'laura.soto_183@mail.com', 2),
    ('Gonzalo Morales', 24, 'M', 'gonzalo.morales_184@mail.com', 1),
    ('Valeria Espinoza', 28, 'F', 'valeria.espinosa_185@mail.com', 2),
    ('Sebastián Guzmán', 46, 'M', 'sebastian.guzman_186@mail.com', 2),
    ('Fernanda Tapia', 57, 'F', 'fernanda.tapia_187@mail.com', 5),
    ('Felipe Cornejo', 18, 'M', 'felipe.cornejo_188@mail.com', 1),
    ('Antonia Vega', 25, 'F', 'antonia.vega_189@mail.com', 2),
    ('Nicolás Herrera', 39, 'M', 'nicolas.herrera_190@mail.com', 2),
    ('Sofía Díaz', 20, 'F', 'sofia.diaz_191@mail.com', 1),
    ('Esteban Reyes', 31, 'M', 'esteban.reyes_192@mail.com', 2),
    ('Javiera Morales', 27, 'F', 'javiera.morales_193@mail.com', 2),
    ('Maximiliano Gatica', 23, 'M', 'maximiliano.gatica_194@mail.com', 1),
    ('Paz Marín', 29, 'F', 'paz.marin_195@mail.com', 2),
    ('Cristian Soto', 48, 'M', 'cristian.soto_196@mail.com', 2),
    ('Romina Silva', 19, 'F', 'romina.silva_197@mail.com', 1),
    ('Marcelo Pérez', 34, 'M', 'marcelo.perez_198@mail.com', 2),
    ('Alejandra Fuentes', 26, 'F', 'alejandra.fuentes_199@mail.com', 2),
    ('Julio Bravo', 68, 'M', 'julio.bravo_200@mail.com', 5);

INSERT INTO Usuarios (nombre, edad, genero, email, id_tipo_usuario) VALUES
    ('Arturo Vera', 25, 'M', 'arturo.vera_201@mail.com', 2),
    ('Bárbara Salas', 21, 'F', 'barbara.salas_202@mail.com', 1),
    ('Camilo Cárdenas', 33, 'M', 'camilo.cardenas_203@mail.com', 2),
    ('Diana Torres', 28, 'F', 'diana.torres_204@mail.com', 2),
    ('Emilio Herrera', 19, 'M', 'emilio.herrera_205@mail.com', 1),
    ('Fabiola Ramos', 40, 'F', 'fabiola.ramos_206@mail.com', 2),
    ('Gustavo Soto', 65, 'M', 'gustavo.soto_207@mail.com', 5),
    ('Helena Vidal', 22, 'F', 'helena.vidal_208@mail.com', 1),
    ('Iván López', 30, 'M', 'ivan.lopez_209@mail.com', 2),
    ('Julieta Castillo', 27, 'F', 'julieta.castillo_210@mail.com', 2),
    ('Kevin González', 24, 'M', 'kevin.gonzalez_211@mail.com', 1),
    ('Laura Moreno', 36, 'F', 'laura.moreno_212@mail.com', 2),
    ('Miguel Rojas', 58, 'M', 'miguel.rojas_213@mail.com', 5),
    ('Natalia Morales', 20, 'F', 'natalia.morales_214@mail.com', 1),
    ('Oscar Fuentes', 31, 'M', 'oscar.fuentes_215@mail.com', 2),
    ('Pilar Díaz', 26, 'F', 'pilar.diaz_216@mail.com', 2),
    ('Roberto Méndez', 23, 'M', 'roberto.mendez_217@mail.com', 1),
    ('Sofía Castro', 38, 'F', 'sofia.castro_218@mail.com', 2),
    ('Tomás Ruiz', 17, 'M', 'tomas.ruiz_219@mail.com', 6),
    ('Úrsula Silva', 29, 'F', 'ursula.silva_220@mail.com', 2),
    ('Vicente Vargas', 42, 'M', 'vicente.vargas_221@mail.com', 2),
    ('Wendy Herrera', 25, 'F', 'wendy.herrera_222@mail.com', 1),
    ('Xavier Guzmán', 34, 'M', 'xavier.guzman_223@mail.com', 2),
    ('Yolanda Ramos', 22, 'F', 'yolanda.ramos_224@mail.com', 1),
    ('Zoe Navarro', 37, 'F', 'zoe.navarro_225@mail.com', 2),
    ('Aarón Peña', 59, 'M', 'aaron.pena_226@mail.com', 5),
    ('Brenda Ríos', 21, 'F', 'brenda.rios_227@mail.com', 1),
    ('Christian Sánchez', 32, 'M', 'christian.sanchez_228@mail.com', 2),
    ('Dalia Vega', 28, 'F', 'dalia.vega_229@mail.com', 2),
    ('Efrén Rojas', 24, 'M', 'efren.rojas_230@mail.com', 1),
    ('Fátima Montes', 35, 'F', 'fatima.montes_231@mail.com', 2),
    ('Gerardo Salas', 60, 'M', 'gerardo.salas_232@mail.com', 5),
    ('Hilda Cruz', 20, 'F', 'hilda.cruz_233@mail.com', 1),
    ('Israel Morales', 33, 'M', 'israel.morales_234@mail.com', 2),
    ('Jacqueline Luna', 29, 'F', 'jacqueline.luna_235@mail.com', 2),
    ('Karen Rivas', 25, 'F', 'karen.rivas_236@mail.com', 1),
    ('Lázaro Flores', 41, 'M', 'lazaro.flores_237@mail.com', 2),
    ('Mónica Tapia', 16, 'F', 'monica.tapia_238@mail.com', 6),
    ('Néstor Silva', 30, 'M', 'nestor.silva_239@mail.com', 2),
    ('Olivia Vidal', 27, 'F', 'olivia.vidal_240@mail.com', 2),
    ('Pablo Vargas', 23, 'M', 'pablo.vargas_241@mail.com', 1),
    ('Quinn Herrera', 38, 'F', 'quinn.herrera_242@mail.com', 2),
    ('Raquel Guzmán', 24, 'F', 'raquel.guzman_243@mail.com', 1),
    ('Samuel Ramos', 63, 'M', 'samuel.ramos_244@mail.com', 5),
    ('Teresa Navarro', 20, 'F', 'teresa.navarro_245@mail.com', 1),
    ('Ulises Peña', 31, 'M', 'ulises.pena_246@mail.com', 2),
    ('Violeta Ríos', 28, 'F', 'violeta.rios_247@mail.com', 2),
    ('Walter Sánchez', 18, 'M', 'walter.sanchez_248@mail.com', 1),
    ('Ximena Vega', 39, 'F', 'ximena.vega_249@mail.com', 2),
    ('Yago Rojas', 25, 'M', 'yago.rojas_250@mail.com', 1),
    ('Zoe Montes', 44, 'F', 'zoe.montes_251@mail.com', 2),
    ('Abel Salas', 68, 'M', 'abel.salas_252@mail.com', 5),
    ('Blanca Cruz', 22, 'F', 'blanca.cruz_253@mail.com', 1),
    ('César Morales', 34, 'M', 'cesar.morales_254@mail.com', 2),
    ('Dora Luna', 29, 'F', 'dora.luna_255@mail.com', 2),
    ('Esteban Rivas', 26, 'M', 'esteban.rivas_256@mail.com', 1),
    ('Fanny Flores', 37, 'F', 'fanny.flores_257@mail.com', 2),
    ('Gonzalo Tapia', 17, 'M', 'gonzalo.tapia_258@mail.com', 6),
    ('Hilda Silva', 32, 'F', 'hilda.silva_259@mail.com', 2),
    ('Ignacio Vidal', 28, 'M', 'ignacio.vidal_260@mail.com', 2),
    ('Jimena Vargas', 24, 'F', 'jimena.vargas_261@mail.com', 1),
    ('Kevin Herrera', 39, 'M', 'kevin.herrera_262@mail.com', 2),
    ('Liliana Guzmán', 25, 'F', 'liliana.guzman_263@mail.com', 1),
    ('Mario Ramos', 64, 'M', 'mario.ramos_264@mail.com', 5),
    ('Nora Navarro', 21, 'F', 'nora.navarro_265@mail.com', 1),
    ('Óscar Peña', 33, 'M', 'oscar.pena_266@mail.com', 2),
    ('Paola Ríos', 29, 'F', 'paola.rios_267@mail.com', 2),
    ('Raúl Sánchez', 19, 'M', 'raul.sanchez_268@mail.com', 1),
    ('Sara Vega', 40, 'F', 'sara.vega_269@mail.com', 2),
    ('Teo Rojas', 26, 'M', 'teo.rojas_270@mail.com', 1),
    ('Úrsula Montes', 45, 'F', 'ursula.montes_271@mail.com', 2),
    ('Víctor Salas', 69, 'M', 'victor.salas_272@mail.com', 5),
    ('Wanda Cruz', 23, 'F', 'wanda.cruz_273@mail.com', 1),
    ('Xavier Morales', 35, 'M', 'xavier.morales_274@mail.com', 2),
    ('Yara Luna', 30, 'F', 'yara.luna_275@mail.com', 2),
    ('Zacarías Rivas', 27, 'M', 'zacarias.rivas_276@mail.com', 1),
    ('Alma Flores', 38, 'F', 'alma.flores_277@mail.com', 2),
    ('Bruno Tapia', 16, 'M', 'bruno.tapia_278@mail.com', 6),
    ('Carla Silva', 33, 'F', 'carla.silva_279@mail.com', 2),
    ('Darío Vidal', 29, 'M', 'dario.vidal_280@mail.com', 2),
    ('Eva Vargas', 25, 'F', 'eva.vargas_281@mail.com', 1),
    ('Franco Herrera', 40, 'M', 'franco.herrera_282@mail.com', 2),
    ('Gloria Guzmán', 26, 'F', 'gloria.guzman_283@mail.com', 1),
    ('Hugo Ramos', 65, 'M', 'hugo.ramos_284@mail.com', 5),
    ('Inés Navarro', 22, 'F', 'ines.navarro_285@mail.com', 1),
    ('Julián Peña', 34, 'M', 'julian.pena_286@mail.com', 2),
    ('Karla Ríos', 30, 'F', 'karla.rios_287@mail.com', 2),
    ('Leo Sánchez', 20, 'M', 'leo.sanchez_288@mail.com', 1),
    ('Mara Vega', 41, 'F', 'mara.vega_289@mail.com', 2),
    ('Nico Rojas', 27, 'M', 'nico.rojas_290@mail.com', 1),
    ('Olga Montes', 46, 'F', 'olga.montes_291@mail.com', 2),
    ('Paco Salas', 70, 'M', 'paco.salas_292@mail.com', 5),
    ('Quira Cruz', 24, 'F', 'quira.cruz_293@mail.com', 1),
    ('Rubén Morales', 36, 'M', 'ruben.morales_294@mail.com', 2),
    ('Sonia Luna', 31, 'F', 'sonia.luna_295@mail.com', 2),
    ('Thiago Rivas', 28, 'M', 'thiago.rivas_296@mail.com', 1),
    ('Úrsula Flores', 39, 'F', 'ursula.flores_297@mail.com', 2),
    ('Valerio Tapia', 17, 'M', 'valerio.tapia_298@mail.com', 6),
    ('Ximena Silva', 34, 'F', 'ximena.silva_299@mail.com', 2),
    ('Yael Vidal', 30, 'M', 'yael.vidal_300@mail.com', 2);

INSERT INTO Usuarios (nombre, edad, genero, email, id_tipo_usuario) VALUES
    ('Zaira Vargas', 26, 'F', 'zaira.vargas_301@mail.com', 1),
    ('Aldo Herrera', 41, 'M', 'aldo.herrera_302@mail.com', 2),
    ('Berta Guzmán', 27, 'F', 'berta.guzman_303@mail.com', 1),
    ('Cristian Ramos', 66, 'M', 'cristian.ramos_304@mail.com', 5),
    ('Dalia Navarro', 23, 'F', 'dalia.navarro_305@mail.com', 1),
    ('Eugenio Peña', 35, 'M', 'eugenio.pena_306@mail.com', 2),
    ('Fátima Ríos', 31, 'F', 'fatima.rios_307@mail.com', 2),
    ('Gerardo Sánchez', 21, 'M', 'gerardo.sanchez_308@mail.com', 1),
    ('Hilda Vega', 42, 'F', 'hilda.vega_309@mail.com', 2),
    ('Ignacio Rojas', 28, 'M', 'ignacio.rojas_310@mail.com', 1),
    ('Jimena Montes', 47, 'F', 'jimena.montes_311@mail.com', 2),
    ('Kevin Salas', 71, 'M', 'kevin.salas_312@mail.com', 5),
    ('Laura Cruz', 25, 'F', 'laura.cruz_313@mail.com', 1),
    ('Marcos Morales', 37, 'M', 'marcos.morales_314@mail.com', 2),
    ('Nerea Luna', 32, 'F', 'nerea.luna_315@mail.com', 2),
    ('Octavio Rivas', 29, 'M', 'octavio.rivas_316@mail.com', 1),
    ('Patricia Flores', 40, 'F', 'patricia.flores_317@mail.com', 2),
    ('Quique Tapia', 18, 'M', 'quique.tapia_318@mail.com', 6),
    ('Rocío Silva', 35, 'F', 'rocio.silva_319@mail.com', 2),
    ('Sergio Vidal', 31, 'M', 'sergio.vidal_320@mail.com', 2),
    ('Tania Vargas', 27, 'F', 'tania.vargas_321@mail.com', 1),
    ('Uriel Herrera', 42, 'M', 'uriel.herrera_322@mail.com', 2),
    ('Valeria Guzmán', 28, 'F', 'valeria.guzman_323@mail.com', 1),
    ('Walter Ramos', 67, 'M', 'walter.ramos_324@mail.com', 5),
    ('Ximena Navarro', 24, 'F', 'ximena.navarro_325@mail.com', 1),
    ('Yago Peña', 36, 'M', 'yago.pena_326@mail.com', 2),
    ('Zoe Ríos', 32, 'F', 'zoe.rios_327@mail.com', 2),
    ('Adrián Sánchez', 22, 'M', 'adrian.sanchez_328@mail.com', 1),
    ('Blanca Vega', 43, 'F', 'blanca.vega_329@mail.com', 2),
    ('Carlos Rojas', 29, 'M', 'carlos.rojas_330@mail.com', 1),
    ('Diana Montes', 48, 'F', 'diana.montes_331@mail.com', 2),
    ('Emilio Salas', 72, 'M', 'emilio.salas_332@mail.com', 5),
    ('Florencia Cruz', 26, 'F', 'florencia.cruz_333@mail.com', 1),
    ('Gustavo Morales', 38, 'M', 'gustavo.morales_334@mail.com', 2),
    ('Helena Luna', 33, 'F', 'helena.luna_335@mail.com', 2),
    ('Iván Rivas', 30, 'M', 'ivan.rivas_336@mail.com', 1),
    ('Julia Flores', 41, 'F', 'julia.flores_337@mail.com', 2),
    ('Kevin Tapia', 17, 'M', 'kevin.tapia_338@mail.com', 6),
    ('Laura Silva', 36, 'F', 'laura.silva_339@mail.com', 2),
    ('Marco Vidal', 32, 'M', 'marco.vidal_340@mail.com', 2),
    ('Nathalie Vargas', 28, 'F', 'nathalie.vargas_341@mail.com', 1),
    ('Oscar Herrera', 43, 'M', 'oscar.herrera_342@mail.com', 2),
    ('Patricia Guzmán', 29, 'F', 'patricia.guzman_343@mail.com', 1),
    ('Quique Ramos', 68, 'M', 'quique.ramos_344@mail.com', 5),
    ('Rosa Navarro', 25, 'F', 'rosa.navarro_345@mail.com', 1),
    ('Sebastián Peña', 37, 'M', 'sebastian.pena_346@mail.com', 2),
    ('Tania Ríos', 33, 'F', 'tania.rios_347@mail.com', 2),
    ('Uriel Sánchez', 23, 'M', 'uriel.sanchez_348@mail.com', 1),
    ('Valeria Vega', 44, 'F', 'valeria.vega_349@mail.com', 2),
    ('Walter Rojas', 30, 'M', 'walter.rojas_350@mail.com', 1);

INSERT INTO Usuarios (nombre, edad, genero, email, id_tipo_usuario) VALUES
    ('Ximena Montes', 49, 'F', 'ximena.montes_351@mail.com', 2),
    ('Yago Salas', 73, 'M', 'yago.salas_352@mail.com', 5),
    ('Zoe Cruz', 27, 'F', 'zoe.cruz_353@mail.com', 1),
    ('Ana Morales', 39, 'F', 'ana.morales_354@mail.com', 2),
    ('Beto Luna', 34, 'M', 'beto.luna_355@mail.com', 2),
    ('Carla Rivas', 31, 'F', 'carla.rivas_356@mail.com', 1),
    ('Darío Flores', 42, 'M', 'dario.flores_357@mail.com', 2),
    ('Elena Tapia', 18, 'F', 'elena.tapia_358@mail.com', 6),
    ('Felipe Silva', 37, 'M', 'felipe.silva_359@mail.com', 2),
    ('Gabriela Vidal', 33, 'F', 'gabriela.vidal_360@mail.com', 2),
    ('Hugo Vargas', 29, 'M', 'hugo.vargas_361@mail.com', 1),
    ('Inés Herrera', 44, 'F', 'ines.herrera_362@mail.com', 2),
    ('Julián Guzmán', 30, 'M', 'julian.guzman_363@mail.com', 1),
    ('Karla Ramos', 69, 'F', 'karla.ramos_364@mail.com', 5),
    ('Lucas Navarro', 26, 'M', 'lucas.navarro_365@mail.com', 1),
    ('Mara Peña', 38, 'F', 'mara.pena_366@mail.com', 2),
    ('Nico Ríos', 34, 'M', 'nico.rios_367@mail.com', 2),
    ('Olga Sánchez', 24, 'F', 'olga.sanchez_368@mail.com', 1),
    ('Pedro Vega', 45, 'M', 'pedro.vega_369@mail.com', 2),
    ('Quira Rojas', 31, 'F', 'quira.rojas_370@mail.com', 1),
    ('Rubén Montes', 50, 'M', 'ruben.montes_371@mail.com', 5),
    ('Sonia Salas', 28, 'F', 'sonia.salas_372@mail.com', 1),
    ('Thiago Cruz', 40, 'M', 'thiago.cruz_373@mail.com', 2),
    ('Úrsula Morales', 35, 'F', 'ursula.morales_374@mail.com', 2),
    ('Valerio Luna', 32, 'M', 'valerio.luna_375@mail.com', 1),
    ('Ximena Rivas', 43, 'F', 'ximena.rivas_376@mail.com', 2),
    ('Yael Flores', 19, 'M', 'yael.flores_377@mail.com', 6),
    ('Zaira Tapia', 38, 'F', 'zaira.tapia_378@mail.com', 2),
    ('Aldo Silva', 34, 'M', 'aldo.silva_379@mail.com', 2),
    ('Berta Vidal', 30, 'F', 'berta.vidal_380@mail.com', 1),
    ('Cristian Vargas', 45, 'M', 'cristian.vargas_381@mail.com', 2),
    ('Dalia Herrera', 31, 'F', 'dalia.herrera_382@mail.com', 1),
    ('Eugenio Guzmán', 70, 'M', 'eugenio.guzman_383@mail.com', 5),
    ('Fátima Ramos', 27, 'F', 'fatima.ramos_384@mail.com', 1),
    ('Gerardo Navarro', 39, 'M', 'gerardo.navarro_385@mail.com', 2),
    ('Hilda Peña', 35, 'F', 'hilda.pena_386@mail.com', 2),
    ('Ignacio Ríos', 25, 'M', 'ignacio.rios_387@mail.com', 1),
    ('Jimena Sánchez', 46, 'F', 'jimena.sanchez_388@mail.com', 2),
    ('Kevin Vega', 32, 'M', 'kevin.vega_389@mail.com', 1),
    ('Laura Rojas', 51, 'F', 'laura.rojas_390@mail.com', 5),
    ('Marcos Montes', 29, 'M', 'marcos.montes_391@mail.com', 1),
    ('Nerea Salas', 41, 'F', 'nerea.salas_392@mail.com', 2),
    ('Octavio Cruz', 36, 'M', 'octavio.cruz_393@mail.com', 2),
    ('Patricia Morales', 33, 'F', 'patricia.morales_394@mail.com', 1),
    ('Quique Luna', 48, 'M', 'quique.luna_395@mail.com', 2),
    ('Rocío Rivas', 20, 'F', 'rocio.rivas_396@mail.com', 6),
    ('Sergio Flores', 39, 'M', 'sergio.flores_397@mail.com', 2),
    ('Tania Tapia', 35, 'F', 'tania.tapia_398@mail.com', 2),
    ('Uriel Silva', 31, 'M', 'uriel.silva_399@mail.com', 1),
    ('Valeria Vidal', 46, 'F', 'valeria.vidal_400@mail.com', 2);

INSERT INTO Usuarios (nombre, edad, genero, email, id_tipo_usuario) VALUES
    ('Walter Vargas', 32, 'M', 'walter.vargas_401@mail.com', 1),
    ('Ximena Herrera', 52, 'F', 'ximena.herrera_402@mail.com', 5),
    ('Yago Guzmán', 29, 'M', 'yago.guzman_403@mail.com', 1),
    ('Zoe Ramos', 41, 'F', 'zoe.ramos_404@mail.com', 2),
    ('Adrián Navarro', 37, 'M', 'adrian.navarro_405@mail.com', 2),
    ('Blanca Peña', 34, 'F', 'blanca.pena_406@mail.com', 1),
    ('Carlos Ríos', 48, 'M', 'carlos.rios_407@mail.com', 2),
    ('Diana Sánchez', 30, 'F', 'diana.sanchez_408@mail.com', 1),
    ('Emilio Vega', 73, 'M', 'emilio.vega_409@mail.com', 5),
    ('Florencia Rojas', 27, 'F', 'florencia.rojas_410@mail.com', 1),
    ('Gustavo Montes', 40, 'M', 'gustavo.montes_411@mail.com', 2),
    ('Helena Salas', 36, 'F', 'helena.salas_412@mail.com', 2),
    ('Iván Cruz', 33, 'M', 'ivan.cruz_413@mail.com', 1),
    ('Julia Flores', 41, 'F', 'julia.flores_414@mail.com', 2),
    ('Kevin Luna', 18, 'M', 'kevin.luna_415@mail.com', 6),
    ('Laura Rivas', 39, 'F', 'laura.rivas_416@mail.com', 2),
    ('Marco Flores', 35, 'M', 'marco.flores_417@mail.com', 2),
    ('Nathalie Tapia', 32, 'F', 'nathalie.tapia_418@mail.com', 1),
    ('Oscar Silva', 46, 'M', 'osc.silva_419@mail.com', 2),
    ('Patricia Vidal', 33, 'F', 'pat.vidal_420@mail.com', 1),
    ('Quique Vargas', 71, 'M', 'qui.vargas_421@mail.com', 5),
    ('Rosa Herrera', 28, 'F', 'rosa.herrera_422@mail.com', 1),
    ('Sebastián Guzmán', 42, 'M', 'seb.guzman_423@mail.com', 2),
    ('Tania Ramos', 38, 'F', 'tania.ramos_424@mail.com', 2),
    ('Uriel Navarro', 25, 'M', 'uri.navarro_425@mail.com', 1),
    ('Valeria Peña', 49, 'F', 'val.pena_426@mail.com', 2),
    ('Walter Ríos', 32, 'M', 'wal.rios_427@mail.com', 1),
    ('Ximena Sánchez', 55, 'F', 'xim.sanchez_428@mail.com', 5),
    ('Yago Vega', 31, 'M', 'yago.vega_429@mail.com', 1),
    ('Zoe Rojas', 42, 'F', 'zoe.rojas_430@mail.com', 2),
    ('Abel Montes', 37, 'M', 'abel.montes_431@mail.com', 2),
    ('Blanca Salas', 34, 'F', 'blanca.salas_432@mail.com', 1),
    ('César Cruz', 49, 'M', 'cesar.cruz_433@mail.com', 2),
    ('Dora Morales', 30, 'F', 'dora.morales_434@mail.com', 1),
    ('Esteban Luna', 74, 'M', 'esteban.luna_435@mail.com', 5),
    ('Fanny Rivas', 27, 'F', 'fanny.rivas_436@mail.com', 1),
    ('Gerardo Flores', 40, 'M', 'gerardo.flores_437@mail.com', 2),
    ('Hilda Tapia', 36, 'F', 'hilda.tapia_438@mail.com', 2),
    ('Ignacio Silva', 33, 'M', 'ignacio.silva_439@mail.com', 1),
    ('Jimena Vidal', 47, 'F', 'jimena.vidal_440@mail.com', 2),
    ('Kevin Vargas', 30, 'M', 'kevin.vargas_441@mail.com', 1),
    ('Laura Herrera', 52, 'F', 'laura.herrera_442@mail.com', 5),
    ('Marcos Guzmán', 29, 'M', 'marcos.guzman_443@mail.com', 1),
    ('Nerea Ramos', 41, 'F', 'nerea.ramos_444@mail.com', 2),
    ('Octavio Navarro', 37, 'M', 'octavio.navarro_445@mail.com', 2),
    ('Patricia Peña', 34, 'F', 'patricia.pena_446@mail.com', 1),
    ('Quique Ríos', 48, 'M', 'quique.rios_447@mail.com', 2),
    ('Rocío Sánchez', 30, 'F', 'rocio.sanchez_448@mail.com', 1),
    ('Sergio Vega', 73, 'M', 'sergio.vega_449@mail.com', 5),
    ('Tania Rojas', 27, 'F', 'tania.rojas_450@mail.com', 1);

INSERT INTO Usuarios (nombre, edad, genero, email, id_tipo_usuario) VALUES
    ('Uriel Montes', 40, 'M', 'uriel.montes_451@mail.com', 2),
    ('Valeria Salas', 36, 'F', 'valeria.salas_452@mail.com', 2),
    ('Walter Cruz', 33, 'M', 'walter.cruz_453@mail.com', 1),
    ('Ximena Morales', 45, 'F', 'ximena.morales_454@mail.com', 2),
    ('Yago Luna', 18, 'M', 'yago.luna_455@mail.com', 6),
    ('Zoe Rivas', 39, 'F', 'zoe.rivas_456@mail.com', 2),
    ('Adrián Flores', 35, 'M', 'adrian.flores_457@mail.com', 2),
    ('Blanca Tapia', 32, 'F', 'blanca.tapia_458@mail.com', 1),
    ('Carlos Silva', 46, 'M', 'carlos.silva_459@mail.com', 2),
    ('Diana Vidal', 33, 'F', 'diana.vidal_460@mail.com', 1),
    ('Emilio Vargas', 71, 'M', 'emilio.vargas_461@mail.com', 5),
    ('Florencia Herrera', 28, 'F', 'florencia.herrera_462@mail.com', 1),
    ('Gustavo Guzmán', 42, 'M', 'gustavo.guzman_463@mail.com', 2),
    ('Helena Ramos', 38, 'F', 'helena.ramos_464@mail.com', 2),
    ('Iván Navarro', 25, 'M', 'ivan.navarro_465@mail.com', 1),
    ('Julia Peña', 49, 'F', 'julia.pena_466@mail.com', 2),
    ('Kevin Ríos', 32, 'M', 'kevin.rios_467@mail.com', 1),
    ('Laura Sánchez', 55, 'F', 'laura.sanchez_468@mail.com', 5),
    ('Marcos Vega', 31, 'M', 'marcos.vega_469@mail.com', 1),
    ('Nerea Rojas', 42, 'F', 'nerea.rojas_470@mail.com', 2),
    ('Octavio Montes', 37, 'M', 'octavio.montes_471@mail.com', 2),
    ('Patricia Salas', 34, 'F', 'patricia.salas_472@mail.com', 1),
    ('Quique Cruz', 49, 'M', 'quique.cruz_473@mail.com', 2),
    ('Rocío Morales', 30, 'F', 'rocio.morales_474@mail.com', 1),
    ('Sergio Luna', 74, 'M', 'sergio.luna_475@mail.com', 5),
    ('Tania Rivas', 27, 'F', 'tania.rivas_476@mail.com', 1),
    ('Uriel Flores', 40, 'M', 'uriel.flores_477@mail.com', 2),
    ('Valeria Tapia', 36, 'F', 'valeria.tapia_478@mail.com', 2),
    ('Walter Silva', 33, 'M', 'walter.silva_479@mail.com', 1),
    ('Ximena Vidal', 45, 'F', 'ximena.vidal_480@mail.com', 2),
    ('Yago Vargas', 18, 'M', 'yago.vargas_481@mail.com', 6),
    ('Zoe Herrera', 39, 'F', 'zoe.herrera_482@mail.com', 2),
    ('Adrián Guzmán', 35, 'M', 'adrian.guzman_483@mail.com', 2),
    ('Blanca Ramos', 32, 'F', 'blanca.ramos_484@mail.com', 1),
    ('Carlos Navarro', 46, 'M', 'carlos.navarro_485@mail.com', 2),
    ('Diana Peña', 33, 'F', 'diana.pena_486@mail.com', 1),
    ('Emilio Ríos', 72, 'M', 'emilio.rios_487@mail.com', 5),
    ('Florencia Sánchez', 28, 'F', 'florencia.sanchez_488@mail.com', 1),
    ('Gustavo Vega', 40, 'M', 'gustavo.vega_489@mail.com', 2),
    ('Helena Rojas', 36, 'F', 'helena.rojas_490@mail.com', 2),
    ('Iván Montes', 33, 'M', 'ivan.montes_491@mail.com', 1),
    ('Julia Salas', 45, 'F', 'julia.salas_492@mail.com', 2),
    ('Kevin Cruz', 18, 'M', 'kevin.cruz_493@mail.com', 6),
    ('Laura Morales', 39, 'F', 'laura.morales_494@mail.com', 2),
    ('Marco Luna', 35, 'M', 'marco.luna_495@mail.com', 2),
    ('Nathalie Rivas', 32, 'F', 'nathalie.rivas_496@mail.com', 1),
    ('Oscar Flores', 46, 'M', 'oscar.flores_497@mail.com', 2),
    ('Patricia Tapia', 33, 'F', 'patricia.tapia_498@mail.com', 1),
    ('Quique Silva', 71, 'M', 'quique.silva_499@mail.com', 5),
    ('Rosa Vidal', 28, 'F', 'rosa.vidal_500@mail.com', 1);

INSERT INTO Usuarios (nombre, edad, genero, email, id_tipo_usuario) VALUES
    ('Sebastián Vargas', 42, 'M', 'sebastian.vargas_501@mail.com', 2),
    ('Tania Herrera', 38, 'F', 'tania.herrera_502@mail.com', 2),
    ('Uriel Guzmán', 25, 'M', 'uriel.guzman_503@mail.com', 1),
    ('Valeria Ramos', 49, 'F', 'valeria.ramos_504@mail.com', 2),
    ('Walter Navarro', 32, 'M', 'walter.navarro_505@mail.com', 1),
    ('Ximena Peña', 55, 'F', 'ximena.pena_506@mail.com', 5),
    ('Yago Ríos', 31, 'M', 'yago.rios_507@mail.com', 1),
    ('Zoe Sánchez', 42, 'F', 'zoe.sanchez_508@mail.com', 2),
    ('Adrián Vega', 37, 'M', 'adrian.vega_509@mail.com', 2),
    ('Blanca Rojas', 34, 'F', 'blanca.rojas_510@mail.com', 1),
    ('Carlos Montes', 49, 'M', 'carlos.montes_511@mail.com', 2),
    ('Diana Salas', 30, 'F', 'diana.salas_512@mail.com', 1),
    ('Emilio Cruz', 74, 'M', 'emilio.cruz_513@mail.com', 5),
    ('Florencia Morales', 27, 'F', 'florencia.morales_514@mail.com', 1),
    ('Gustavo Luna', 40, 'M', 'gustavo.luna_515@mail.com', 2),
    ('Helena Rivas', 36, 'F', 'helena.rivas_516@mail.com', 2),
    ('Iván Flores', 33, 'M', 'ivan.flores_517@mail.com', 1),
    ('Julia Tapia', 45, 'F', 'julia.tapia_518@mail.com', 2),
    ('Kevin Silva', 18, 'M', 'kevin.silva_519@mail.com', 6),
    ('Laura Vidal', 39, 'F', 'laura.vidal_520@mail.com', 2),
    ('Marco Vargas', 35, 'M', 'marco.vargas_521@mail.com', 2),
    ('Nathalie Herrera', 32, 'F', 'nathalie.herrera_522@mail.com', 1),
    ('Oscar Guzmán', 46, 'M', 'oscar.guzman_523@mail.com', 2),
    ('Patricia Ramos', 33, 'F', 'patricia.ramos_524@mail.com', 1),
    ('Quique Navarro', 71, 'M', 'quique.navarro_525@mail.com', 5),
    ('Rosa Peña', 28, 'F', 'rosa.pena_526@mail.com', 1),
    ('Sebastián Ríos', 42, 'M', 'sebastian.rios_527@mail.com', 2),
    ('Tania Sánchez', 38, 'F', 'tania.sanchez_528@mail.com', 2),
    ('Uriel Vega', 25, 'M', 'uriel.vega_529@mail.com', 1),
    ('Valeria Rojas', 49, 'F', 'valeria.rojas_530@mail.com', 2),
    ('Walter Montes', 32, 'M', 'walter.montes_531@mail.com', 1),
    ('Ximena Salas', 55, 'F', 'ximena.salas_532@mail.com', 5),
    ('Yago Cruz', 31, 'M', 'yago.cruz_533@mail.com', 1),
    ('Zoe Morales', 42, 'F', 'zoe.morales_534@mail.com', 2),
    ('Adrián Luna', 37, 'M', 'adrian.luna_535@mail.com', 2),
    ('Blanca Rivas', 34, 'F', 'blanca.rivas_536@mail.com', 1),
    ('Carlos Flores', 49, 'M', 'carlos.flores_537@mail.com', 2),
    ('Diana Tapia', 30, 'F', 'diana.tapia_538@mail.com', 1),
    ('Emilio Silva', 74, 'M', 'emilio.silva_539@mail.com', 5),
    ('Florencia Vidal', 27, 'F', 'florencia.vidal_540@mail.com', 1),
    ('Gustavo Vargas', 40, 'M', 'gustavo.vargas_541@mail.com', 2),
    ('Helena Herrera', 36, 'F', 'helena.herrera_542@mail.com', 2),
    ('Iván Guzmán', 33, 'M', 'ivan.guzman_543@mail.com', 1),
    ('Julia Ramos', 45, 'F', 'julia.ramos_544@mail.com', 2),
    ('Kevin Navarro', 18, 'M', 'kevin.navarro_545@mail.com', 6),
    ('Laura Peña', 39, 'F', 'laura.pena_546@mail.com', 2),
    ('Marco Ríos', 35, 'M', 'marco.rios_547@mail.com', 2),
    ('Nathalie Sánchez', 32, 'F', 'nathalie.sanchez_548@mail.com', 1),
    ('Oscar Vega', 46, 'M', 'oscar.vega_549@mail.com', 2),
    ('Patricia Rojas', 33, 'F', 'patricia.rojas_550@mail.com', 1);

INSERT INTO Usuarios (nombre, edad, genero, email, id_tipo_usuario) VALUES
    ('Quique Montes', 71, 'M', 'quique.montes_551@mail.com', 5),
    ('Rosa Salas', 28, 'F', 'rosa.salas_552@mail.com', 1),
    ('Sebastián Cruz', 42, 'M', 'sebastian.cruz_553@mail.com', 2),
    ('Tania Morales', 38, 'F', 'tania.morales_554@mail.com', 2),
    ('Uriel Luna', 25, 'M', 'uriel.luna_555@mail.com', 1),
    ('Valeria Rivas', 49, 'F', 'valeria.rivas_556@mail.com', 2),
    ('Walter Flores', 32, 'M', 'walter.flores_557@mail.com', 1),
    ('Ximena Tapia', 55, 'F', 'ximena.tapia_558@mail.com', 5),
    ('Yago Silva', 31, 'M', 'yago.silva_559@mail.com', 1),
    ('Zoe Vidal', 42, 'F', 'zoe.vidal_560@mail.com', 2),
    ('Adrián Vargas', 37, 'M', 'adrian.vargas_561@mail.com', 2),
    ('Blanca Herrera', 34, 'F', 'blanca.herrera_562@mail.com', 1),
    ('Carlos Guzmán', 49, 'M', 'carlos.guzman_563@mail.com', 2),
    ('Diana Ramos', 30, 'F', 'diana.ramos_564@mail.com', 1),
    ('Emilio Navarro', 74, 'M', 'emilio.navarro_565@mail.com', 5),
    ('Florencia Peña', 27, 'F', 'florencia.pena_566@mail.com', 1),
    ('Gustavo Ríos', 40, 'M', 'gustavo.rios_567@mail.com', 2),
    ('Helena Sánchez', 36, 'F', 'helena.sanchez_568@mail.com', 2),
    ('Iván Vega', 33, 'M', 'ivan.vega_569@mail.com', 1),
    ('Julia Rojas', 45, 'F', 'julia.rojas_570@mail.com', 2),
    ('Kevin Montes', 18, 'M', 'kevin.montes_571@mail.com', 6),
    ('Laura Salas', 39, 'F', 'laura.salas_572@mail.com', 2),
    ('Marco Cruz', 35, 'M', 'marco.cruz_573@mail.com', 2),
    ('Nathalie Morales', 32, 'F', 'nathalie.morales_574@mail.com', 1),
    ('Oscar Luna', 46, 'M', 'oscar.luna_575@mail.com', 2),
    ('Patricia Rivas', 33, 'F', 'patricia.rivas_576@mail.com', 1),
    ('Quique Flores', 71, 'M', 'quique.flores_577@mail.com', 5),
    ('Rosa Tapia', 28, 'F', 'rosa.tapia_578@mail.com', 1),
    ('Sebastián Silva', 42, 'M', 'sebastian.silva_579@mail.com', 2),
    ('Tania Vidal', 38, 'F', 'tania.vidal_580@mail.com', 2),
    ('Uriel Vargas', 25, 'M', 'uriel.vargas_581@mail.com', 1),
    ('Valeria Herrera', 49, 'F', 'valeria.herrera_582@mail.com', 2),
    ('Walter Guzmán', 32, 'M', 'walter.guzman_583@mail.com', 1),
    ('Ximena Ramos', 55, 'F', 'ximena.ramos_584@mail.com', 5),
    ('Yago Navarro', 31, 'M', 'yago.navarro_585@mail.com', 1),
    ('Zoe Peña', 42, 'F', 'zoe.pena_586@mail.com', 2),
    ('Adrián Ríos', 37, 'M', 'adrian.rios_587@mail.com', 2),
    ('Blanca Sánchez', 34, 'F', 'blanca.sanchez_588@mail.com', 1),
    ('Carlos Vega', 49, 'M', 'carlos.vega_589@mail.com', 2),
    ('Diana Rojas', 30, 'F', 'diana.rojas_590@mail.com', 1),
    ('Emilio Montes', 74, 'M', 'emilio.montes_591@mail.com', 5),
    ('Florencia Salas', 27, 'F', 'florencia.salas_592@mail.com', 1),
    ('Gustavo Cruz', 40, 'M', 'gustavo.cruz_593@mail.com', 2),
    ('Helena Morales', 36, 'F', 'helena.morales_594@mail.com', 2),
    ('Iván Luna', 33, 'M', 'ivan.luna_595@mail.com', 1),
    ('Julia Rivas', 45, 'F', 'julia.rivas_596@mail.com', 2),
    ('Kevin Flores', 18, 'M', 'kevin.flores_597@mail.com', 6),
    ('Laura Tapia', 39, 'F', 'laura.tapia_598@mail.com', 2),
    ('Marco Silva', 35, 'M', 'marco.silva_599@mail.com', 2),
    ('Nathalie Vidal', 32, 'F', 'nathalie.vidal_600@mail.com', 1);

INSERT INTO Usuarios (nombre, edad, genero, email, id_tipo_usuario) VALUES
    ('Oscar Vargas', 46, 'M', 'oscar.vargas_601@mail.com', 2),
    ('Patricia Herrera', 33, 'F', 'patricia.herrera_602@mail.com', 1),
    ('Quique Guzmán', 71, 'M', 'quique.guzman_603@mail.com', 5),
    ('Rosa Ramos', 28, 'F', 'rosa.ramos_604@mail.com', 1),
    ('Sebastián Navarro', 42, 'M', 'sebastian.navarro_605@mail.com', 2),
    ('Tania Peña', 38, 'F', 'tania.pena_606@mail.com', 2),
    ('Uriel Ríos', 25, 'M', 'uriel.rios_607@mail.com', 1),
    ('Valeria Sánchez', 49, 'F', 'valeria.sanchez_608@mail.com', 2),
    ('Walter Vega', 32, 'M', 'walter.vega_609@mail.com', 1),
    ('Ximena Rojas', 55, 'F', 'ximena.rojas_610@mail.com', 5),
    ('Yago Montes', 31, 'M', 'yago.montes_611@mail.com', 1),
    ('Zoe Salas', 42, 'F', 'zoe.salas_612@mail.com', 2),
    ('Adrián Cruz', 37, 'M', 'adrian.cruz_613@mail.com', 2),
    ('Blanca Morales', 34, 'F', 'blanca.morales_614@mail.com', 1),
    ('Carlos Luna', 49, 'M', 'carlos.luna_615@mail.com', 2),
    ('Diana Rivas', 30, 'F', 'diana.rivas_616@mail.com', 1),
    ('Emilio Flores', 74, 'M', 'emilio.flores_617@mail.com', 5),
    ('Florencia Tapia', 27, 'F', 'florencia.tapia_618@mail.com', 1),
    ('Gustavo Silva', 40, 'M', 'gustavo.silva_619@mail.com', 2),
    ('Helena Vidal', 36, 'F', 'helena.vidal_620@mail.com', 2),
    ('Iván Vargas', 33, 'M', 'ivan.vargas_621@mail.com', 1),
    ('Julia Herrera', 45, 'F', 'julia.herrera_622@mail.com', 2),
    ('Kevin Guzmán', 18, 'M', 'kevin.guzman_623@mail.com', 6),
    ('Laura Ramos', 39, 'F', 'laura.ramos_624@mail.com', 2),
    ('Marco Navarro', 35, 'M', 'marco.navarro_625@mail.com', 2),
    ('Nathalie Peña', 32, 'F', 'nathalie.pena_626@mail.com', 1),
    ('Oscar Ríos', 46, 'M', 'oscar.rios_627@mail.com', 2),
    ('Patricia Sánchez', 33, 'F', 'patricia.sanchez_628@mail.com', 1),
    ('Quique Vega', 71, 'M', 'quique.vega_629@mail.com', 5),
    ('Rosa Rojas', 28, 'F', 'rosa.rojas_630@mail.com', 1),
    ('Sebastián Montes', 42, 'M', 'sebastian.montes_631@mail.com', 2),
    ('Tania Salas', 38, 'F', 'tania.salas_632@mail.com', 2),
    ('Uriel Cruz', 25, 'M', 'uriel.cruz_633@mail.com', 1),
    ('Valeria Morales', 49, 'F', 'valeria.morales_634@mail.com', 2),
    ('Walter Luna', 32, 'M', 'walter.luna_635@mail.com', 1),
    ('Ximena Rivas', 55, 'F', 'ximena.rivas_636@mail.com', 5),
    ('Yago Flores', 31, 'M', 'yago.flores_637@mail.com', 1),
    ('Zoe Tapia', 42, 'F', 'zoe.tapia_638@mail.com', 2),
    ('Adrián Vargas', 37, 'M', 'adrian.vargas_639@mail.com', 2),
    ('Blanca Herrera', 34, 'F', 'blanca.herrera_640@mail.com', 1),
    ('Carlos Guzmán', 49, 'M', 'carlos.guzman_641@mail.com', 2),
    ('Diana Ramos', 30, 'F', 'diana.ramos_642@mail.com', 1),
    ('Emilio Navarro', 74, 'M', 'emilio.navarro_643@mail.com', 5),
    ('Florencia Peña', 27, 'F', 'florencia.pena_644@mail.com', 1),
    ('Gustavo Ríos', 40, 'M', 'gustavo.rios_645@mail.com', 2),
    ('Helena Sánchez', 36, 'F', 'helena.sanchez_646@mail.com', 2),
    ('Iván Vega', 33, 'M', 'ivan.vega_647@mail.com', 1),
    ('Julia Rojas', 45, 'F', 'julia.rojas_648@mail.com', 2),
    ('Kevin Montes', 18, 'M', 'kevin.montes_649@mail.com', 6),
    ('Laura Salas', 39, 'F', 'laura.salas_650@mail.com', 2);

INSERT INTO Usuarios (nombre, edad, genero, email, id_tipo_usuario) VALUES
    ('Marco Cruz', 35, 'M', 'marco.cruz_651@mail.com', 2),
    ('Nathalie Morales', 32, 'F', 'nathalie.morales_652@mail.com', 1),
    ('Oscar Luna', 46, 'M', 'oscar.luna_653@mail.com', 2),
    ('Patricia Rivas', 33, 'F', 'patricia.rivas_654@mail.com', 1),
    ('Quique Flores', 71, 'M', 'quique.flores_655@mail.com', 5),
    ('Rosa Tapia', 28, 'F', 'rosa.tapia_656@mail.com', 1),
    ('Sebastián Silva', 42, 'M', 'sebastian.silva_657@mail.com', 2),
    ('Tania Vidal', 38, 'F', 'tania.vidal_658@mail.com', 2),
    ('Uriel Vargas', 25, 'M', 'uriel.vargas_659@mail.com', 1),
    ('Valeria Herrera', 49, 'F', 'valeria.herrera_660@mail.com', 2),
    ('Walter Guzmán', 32, 'M', 'walter.guzman_661@mail.com', 1),
    ('Ximena Ramos', 55, 'F', 'ximena.ramos_662@mail.com', 5),
    ('Yago Navarro', 31, 'M', 'yago.navarro_663@mail.com', 1),
    ('Zoe Peña', 42, 'F', 'zoe.pena_664@mail.com', 2),
    ('Adrián Ríos', 37, 'M', 'adrian.rios_665@mail.com', 2),
    ('Blanca Sánchez', 34, 'F', 'blanca.sanchez_666@mail.com', 1),
    ('Carlos Vega', 49, 'M', 'carlos.vega_667@mail.com', 2),
    ('Diana Rojas', 30, 'F', 'diana.rojas_668@mail.com', 1),
    ('Emilio Montes', 74, 'M', 'emilio.montes_669@mail.com', 5),
    ('Florencia Salas', 27, 'F', 'florencia.salas_670@mail.com', 1),
    ('Gustavo Cruz', 40, 'M', 'gustavo.cruz_671@mail.com', 2),
    ('Helena Morales', 36, 'F', 'helena.morales_672@mail.com', 2),
    ('Iván Luna', 33, 'M', 'ivan.luna_673@mail.com', 1),
    ('Julia Rivas', 45, 'F', 'julia.rivas_674@mail.com', 2),
    ('Kevin Flores', 18, 'M', 'kevin.flores_675@mail.com', 6),
    ('Laura Tapia', 39, 'F', 'laura.tapia_676@mail.com', 2),
    ('Marco Silva', 35, 'M', 'marco.silva_677@mail.com', 2),
    ('Nathalie Vidal', 32, 'F', 'nathalie.vidal_678@mail.com', 1),
    ('Oscar Vargas', 46, 'M', 'oscar.vargas_679@mail.com', 2),
    ('Patricia Herrera', 33, 'F', 'patricia.herrera_680@mail.com', 1),
    ('Quique Guzmán', 71, 'M', 'quique.guzman_681@mail.com', 5),
    ('Rosa Ramos', 28, 'F', 'rosa.ramos_682@mail.com', 1),
    ('Sebastián Navarro', 42, 'M', 'sebastian.navarro_683@mail.com', 2),
    ('Tania Peña', 38, 'F', 'tania.pena_684@mail.com', 2),
    ('Uriel Ríos', 25, 'M', 'uriel.rios_685@mail.com', 1),
    ('Valeria Sánchez', 49, 'F', 'valeria.sanchez_686@mail.com', 2),
    ('Walter Vega', 32, 'M', 'walter.vega_687@mail.com', 1),
    ('Ximena Rojas', 55, 'F', 'ximena.rojas_688@mail.com', 5),
    ('Yago Montes', 31, 'M', 'yago.montes_689@mail.com', 1),
    ('Zoe Salas', 42, 'F', 'zoe.salas_690@mail.com', 2),
    ('Adrián Cruz', 37, 'M', 'adrian.cruz_691@mail.com', 2),
    ('Blanca Morales', 34, 'F', 'blanca.morales_692@mail.com', 1),
    ('Carlos Luna', 49, 'M', 'carlos.luna_693@mail.com', 2),
    ('Diana Rivas', 30, 'F', 'diana.rivas_694@mail.com', 1),
    ('Emilio Flores', 74, 'M', 'emilio.flores_695@mail.com', 5),
    ('Florencia Tapia', 27, 'F', 'florencia.tapia_696@mail.com', 1),
    ('Gustavo Silva', 40, 'M', 'gustavo.silva_697@mail.com', 2),
    ('Helena Vidal', 36, 'F', 'helena.vidal_698@mail.com', 2),
    ('Iván Vargas', 33, 'M', 'ivan.vargas_699@mail.com', 1),
    ('Julia Herrera', 45, 'F', 'julia.herrera_700@mail.com', 2);

select * from usuarios;
    

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
         	


INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    -- === Bloque 1: Primeros usuarios y rutas principales, enfocándose en picos ===
    -- Rutas Cardinales (IDs 1-4) con mayor ocupación en picos
    (1, 1, 1, '2025-09-11', '06:10:00', '06:45:00', 1, 2, 45), -- Ruta Norte, Pico Mañana
    (2, 2, 6, '2025-09-11', '07:05:00', '07:35:00', 4, 24, 40), -- Ruta Sur, Pico Mañana
    (3, 3, 11, '2025-09-11', '07:30:00', '08:05:00', 7, 28, 48), -- Ruta Este, Pico Mañana
    (4, 4, 16, '2025-09-11', '06:40:00', '07:15:00', 10, 19, 38), -- Ruta Oeste, Pico Mañana
    (1, 1, 4, '2025-09-11', '18:15:00', '18:50:00', 3, 1, 42), -- Ruta Norte, Pico Tarde (vuelta)
    (5, 5, 21, '2025-09-11', '07:20:00', '07:50:00', 26, 2, 30), -- Ruta Noroeste, Pico Mañana
    (6, 6, 25, '2025-09-11', '07:15:00', '07:45:00', 35, 24, 35), -- Ruta Sureste, Pico Mañana
    (7, 7, 29, '2025-09-11', '07:40:00', '08:10:00', 8, 29, 25), -- Ruta Noreste, Pico Mañana
    (8, 8, 33, '2025-09-11', '07:55:00', '08:25:00', 34, 10, 20), -- Ruta Suroeste, Pico Mañana
    (2, 2, 9, '2025-09-11', '18:30:00', '19:00:00', 24, 4, 32), -- Ruta Sur, Pico Tarde (vuelta)
    (9, 1, 2, '2025-09-11', '10:10:00', '10:40:00', 21, 13, 20), -- Ruta Norte, Valle Mañana
    (10, 2, 7, '2025-09-11', '10:45:00', '11:15:00', 5, 15, 22), -- Ruta Sur, Valle Mañana
    (11, 3, 12, '2025-09-11', '10:20:00', '10:50:00', 29, 28, 28), -- Ruta Este, Valle Mañana
    (12, 4, 17, '2025-09-11', '11:00:00', '11:30:00', 11, 25, 25), -- Ruta Oeste, Valle Mañana
    (3, 3, 14, '2025-09-11', '18:50:00', '19:20:00', 28, 7, 30), -- Ruta Este, Pico Tarde (vuelta)
    (13, 5, 22, '2025-09-11', '14:00:00', '14:30:00', 33, 21, 15), -- Ruta Noroeste, Valle Largo
    (14, 6, 26, '2025-09-11', '14:30:00', '15:00:00', 6, 22, 18), -- Ruta Sureste, Valle Largo
    (15, 7, 30, '2025-09-11', '15:15:00', '15:45:00', 7, 9, 20), -- Ruta Noreste, Valle Largo
    (16, 8, 34, '2025-09-11', '15:40:00', '16:10:00', 19, 12, 15), -- Ruta Suroeste, Valle Largo
    (4, 4, 19, '2025-09-11', '19:30:00', '20:00:00', 19, 10, 35), -- Ruta Oeste, Pico Tarde (vuelta)
    (17, 1, 3, '2025-09-11', '14:25:00', '14:55:00', 21, 13, 18), -- Ruta Norte, Valle Tarde
    (18, 2, 8, '2025-09-11', '13:10:00', '13:40:00', 24, 31, 20), -- Ruta Sur, Valle Tarde
    (19, 3, 13, '2025-09-11', '15:35:00', '16:05:00', 18, 17, 28), -- Ruta Este, Valle Tarde
    (20, 4, 18, '2025-09-11', '14:40:00', '15:10:00', 25, 20, 19), -- Ruta Oeste, Valle Tarde
    (5, 5, 23, '2025-09-11', '18:40:00', '19:10:00', 2, 26, 28), -- Ruta Noroeste, Pico Tarde (vuelta)
    (21, 1, 4, '2025-09-11', '21:00:00', '21:30:00', 14, 3, 10), -- Ruta Norte, Noche Valle
    (22, 2, 9, '2025-09-11', '21:20:00', '21:50:00', 15, 4, 12), -- Ruta Sur, Noche Valle
    (23, 3, 14, '2025-09-11', '21:35:00', '22:05:00', 7, 28, 15), -- Ruta Este, Noche Valle
    (24, 4, 19, '2025-09-11', '22:00:00', '22:30:00', 34, 12, 10), -- Ruta Oeste, Noche Valle
    (6, 6, 27, '2025-09-11', '19:15:00', '19:45:00', 24, 35, 22), -- Ruta Sureste, Pico Tarde (vuelta)
    (25, 1, 1, '2025-09-11', '07:10:00', '07:45:00', 1, 2, 40),
    (26, 2, 6, '2025-09-11', '06:55:00', '07:25:00', 4, 5, 35),
    (27, 3, 11, '2025-09-11', '08:15:00', '08:45:00', 7, 9, 42),
    (28, 4, 16, '2025-09-11', '07:00:00', '07:35:00', 10, 11, 30),
    (7, 7, 31, '2025-09-11', '19:20:00', '19:50:00', 9, 7, 18), -- Ruta Noreste, Pico Tarde (vuelta)
    (29, 5, 21, '2025-09-11', '08:00:00', '08:30:00', 27, 21, 28),
    (30, 6, 25, '2025-09-11', '07:30:00', '08:00:00', 6, 22, 30),
    (31, 7, 29, '2025-09-11', '06:25:00', '06:55:00', 29, 28, 20),
    (32, 8, 33, '2025-09-11', '08:10:00', '08:40:00', 31, 19, 15),
    (8, 8, 36, '2025-09-11', '21:40:00', '22:10:00', 12, 34, 8), -- Ruta Suroeste, Noche Valle (vuelta)
    (33, 1, 1, '2025-09-11', '08:40:00', '09:00:00', 3, 1, 40), -- Más viajes en pico mañana
    (34, 2, 6, '2025-09-11', '08:50:00', '09:20:00', 24, 15, 30),
    (35, 3, 11, '2025-09-11', '06:10:00', '06:45:00', 7, 8, 45),
    (36, 4, 16, '2025-09-11', '08:20:00', '08:50:00', 12, 19, 40),
    (37, 5, 21, '2025-09-11', '06:30:00', '07:00:00', 2, 33, 25),
    (38, 6, 25, '2025-09-11', '08:35:00', '09:05:00', 30, 6, 32),
    (39, 7, 29, '2025-09-11', '06:50:00', '07:20:00', 28, 32, 22),
    (40, 8, 33, '2025-09-11', '06:15:00', '06:45:00', 31, 25, 10),
    (41, 1, 3, '2025-09-11', '12:30:00', '13:00:00', 2, 21, 20),
    (42, 2, 8, '2025-09-11', '14:00:00', '14:30:00', 24, 31, 25),
    (43, 3, 13, '2025-09-11', '15:00:00', '15:30:00', 8, 18, 30),
    (44, 4, 18, '2025-09-11', '13:00:00', '13:30:00', 11, 20, 20),
    (45, 5, 22, '2025-09-11', '10:00:00', '10:30:00', 26, 27, 10),
    (46, 6, 26, '2025-09-11', '11:00:00', '11:30:00', 30, 24, 15),
    (47, 7, 30, '2025-09-11', '11:45:00', '12:15:00', 7, 29, 22),
    (48, 8, 34, '2025-09-11', '10:30:00', '11:00:00', 10, 31, 12),
    (49, 1, 4, '2025-09-11', '19:00:00', '19:30:00', 14, 3, 30),
    (50, 2, 9, '2025-09-11', '19:20:00', '19:50:00', 16, 6, 30);

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (51, 3, 14, '2025-09-11', '19:40:00', '20:10:00', 9, 17, 35),
    (52, 4, 19, '2025-09-11', '20:10:00', '20:40:00', 12, 19, 25),
    (53, 5, 23, '2025-09-11', '18:00:00', '18:30:00', 2, 26, 20),
    (54, 6, 27, '2025-09-11', '18:20:00', '18:50:00', 24, 35, 22),
    (55, 7, 31, '2025-09-11', '18:30:00', '19:00:00', 32, 9, 15),
    (56, 8, 35, '2025-09-11', '18:50:00', '19:20:00', 10, 34, 10),
    (57, 1, 1, '2025-09-11', '06:05:00', '06:40:00', 1, 21, 38),
    (58, 2, 6, '2025-09-11', '07:00:00', '07:30:00', 4, 5, 33),
    (59, 3, 11, '2025-09-11', '07:45:00', '08:15:00', 7, 29, 40),
    (60, 4, 16, '2025-09-11', '06:30:00', '07:05:00', 10, 11, 30),
    (61, 5, 21, '2025-09-11', '07:00:00', '07:30:00', 26, 27, 28),
    (62, 6, 25, '2025-09-11', '06:50:00', '07:20:00', 35, 30, 32),
    (63, 7, 29, '2025-09-11', '06:30:00', '07:00:00', 29, 28, 20),
    (64, 8, 33, '2025-09-11', '07:40:00', '08:10:00', 31, 25, 15),
    (65, 1, 1, '2025-09-11', '08:00:00', '08:35:00', 13, 3, 40),
    (66, 2, 6, '2025-09-11', '08:05:00', '08:35:00', 24, 16, 35),
    (67, 3, 11, '2025-09-11', '08:30:00', '09:00:00', 28, 18, 42),
    (68, 4, 16, '2025-09-11', '07:50:00', '08:25:00', 19, 12, 37),
    (69, 5, 21, '2025-09-11', '08:20:00', '08:50:00', 33, 21, 25),
    (70, 6, 25, '2025-09-11', '07:45:00', '08:15:00', 6, 22, 28),
    (71, 7, 29, '2025-09-11', '06:40:00', '07:10:00', 7, 32, 21),
    (72, 8, 33, '2025-09-11', '06:20:00', '06:50:00', 25, 19, 10),
    (73, 1, 3, '2025-09-11', '12:10:00', '12:40:00', 2, 21, 22),
    (74, 2, 8, '2025-09-11', '14:15:00', '14:45:00', 5, 15, 25),
    (75, 3, 13, '2025-09-11', '15:10:00', '15:40:00', 17, 9, 30),
    (76, 4, 18, '2025-09-11', '14:00:00', '14:30:00', 11, 20, 20),
    (77, 5, 22, '2025-09-11', '10:30:00', '11:00:00', 26, 27, 12),
    (78, 6, 26, '2025-09-11', '11:30:00', '12:00:00', 24, 6, 18),
    (79, 7, 30, '2025-09-11', '12:00:00', '12:30:00', 32, 28, 25),
    (80, 8, 34, '2025-09-11', '11:00:00', '11:30:00', 31, 25, 15),
    (81, 1, 4, '2025-09-11', '19:40:00', '20:10:00', 3, 1, 28),
    (82, 2, 9, '2025-09-11', '20:00:00', '20:30:00', 6, 4, 20),
    (83, 3, 14, '2025-09-11', '20:15:00', '20:45:00', 17, 7, 28),
    (84, 4, 19, '2025-09-11', '21:00:00', '21:30:00', 12, 10, 18),
    (85, 5, 23, '2025-09-11', '19:00:00', '19:30:00', 33, 27, 20),
    (86, 6, 27, '2025-09-11', '19:30:00', '20:00:00', 22, 24, 25),
    (87, 7, 31, '2025-09-11', '19:45:00', '20:15:00', 9, 32, 12),
    (88, 8, 35, '2025-09-11', '20:30:00', '21:00:00', 34, 12, 8),
    (89, 1, 1, '2025-09-11', '06:15:00', '06:50:00', 1, 2, 42),
    (90, 2, 6, '2025-09-11', '07:10:00', '07:40:00', 4, 5, 38),
    (91, 3, 11, '2025-09-11', '07:50:00', '08:25:00', 29, 28, 40),
    (92, 4, 16, '2025-09-11', '06:50:00', '07:25:00', 10, 11, 33),
    (93, 5, 21, '2025-09-11', '07:15:00', '07:45:00', 2, 26, 27),
    (94, 6, 25, '2025-09-11', '07:00:00', '07:30:00', 22, 30, 29),
    (95, 7, 29, '2025-09-11', '06:35:00', '07:05:00', 7, 29, 22),
    (96, 8, 33, '2025-09-11', '08:00:00', '08:30:00', 25, 34, 18);

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (97, 1, 3, '2025-09-11', '12:45:00', '13:15:00', 21, 13, 20),
    (98, 2, 8, '2025-09-11', '14:20:00', '14:50:00', 31, 15, 28),
    (99, 3, 13, '2025-09-11', '15:20:00', '15:50:00', 17, 9, 32),
    (100, 4, 18, '2025-09-11', '13:30:00', '14:00:00', 20, 11, 25),
    (101, 5, 22, '2025-09-11', '10:45:00', '11:15:00', 27, 33, 15),
    (102, 6, 26, '2025-09-11', '11:40:00', '12:10:00', 24, 6, 20),
    (103, 7, 30, '2025-09-11', '12:10:00', '12:40:00', 32, 28, 28),
    (104, 8, 34, '2025-09-11', '11:15:00', '11:45:00', 25, 10, 18),
    (105, 1, 4, '2025-09-11', '20:10:00', '20:40:00', 14, 3, 25),
    (106, 2, 9, '2025-09-11', '20:40:00', '21:10:00', 16, 4, 28),
    (107, 3, 14, '2025-09-11', '20:50:00', '21:20:00', 17, 7, 30),
    (108, 4, 19, '2025-09-11', '21:30:00', '22:00:00', 19, 10, 20),
    (109, 5, 23, '2025-09-11', '19:10:00', '19:40:00', 21, 26, 22),
    (110, 6, 27, '2025-09-11', '19:50:00', '20:20:00', 24, 30, 20),
    (111, 7, 31, '2025-09-11', '20:20:00', '20:50:00', 9, 32, 10),
    (112, 8, 35, '2025-09-11', '21:10:00', '21:40:00', 34, 12, 5),
    (113, 1, 1, '2025-09-11', '06:20:00', '06:55:00', 1, 2, 48),
    (114, 2, 6, '2025-09-11', '07:15:00', '07:45:00', 4, 24, 42),
    (115, 3, 11, '2025-09-11', '08:00:00', '08:35:00', 7, 28, 45),
    (116, 4, 16, '2025-09-11', '06:45:00', '07:20:00', 10, 19, 32),
    (117, 5, 21, '2025-09-11', '07:25:00', '07:55:00', 26, 27, 28),
    (118, 6, 25, '2025-09-11', '07:10:00', '07:40:00', 35, 30, 30),
    (119, 7, 29, '2025-09-11', '06:50:00', '07:20:00', 8, 29, 25),
    (120, 8, 33, '2025-09-11', '07:50:00', '08:20:00', 31, 25, 18),
    (121, 1, 1, '2025-09-11', '08:10:00', '08:45:00', 2, 21, 38),
    (122, 2, 6, '2025-09-11', '08:20:00', '08:50:00', 5, 31, 30),
    (123, 3, 11, '2025-09-11', '06:30:00', '07:05:00', 29, 28, 40),
    (124, 4, 16, '2025-09-11', '08:05:00', '08:35:00', 11, 20, 30),
    (125, 5, 21, '2025-09-11', '06:50:00', '07:20:00', 2, 33, 20),
    (126, 6, 25, '2025-09-11', '08:40:00', '09:10:00', 24, 6, 28),
    (127, 7, 29, '2025-09-11', '07:10:00', '07:40:00', 32, 28, 22),
    (128, 8, 33, '2025-09-11', '06:35:00', '07:05:00', 10, 31, 12),
    (129, 1, 3, '2025-09-11', '13:00:00', '13:30:00', 21, 13, 18),
    (130, 2, 8, '2025-09-11', '14:30:00', '15:00:00', 31, 15, 25),
    (131, 3, 13, '2025-09-11', '15:40:00', '16:10:00', 9, 17, 28),
    (132, 4, 18, '2025-09-11', '14:20:00', '14:50:00', 20, 11, 18),
    (133, 5, 22, '2025-09-11', '10:50:00', '11:20:00', 33, 21, 10),
    (134, 6, 26, '2025-09-11', '11:50:00', '12:20:00', 6, 22, 15),
    (135, 7, 30, '2025-09-11', '12:30:00', '13:00:00', 28, 32, 20),
    (136, 8, 34, '2025-09-11', '11:30:00', '12:00:00', 10, 31, 10),
    (137, 1, 4, '2025-09-11', '19:15:00', '19:45:00', 3, 1, 25),
    (138, 2, 9, '2025-09-11', '19:40:00', '20:10:00', 6, 4, 22),
    (139, 3, 14, '2025-09-11', '20:00:00', '20:30:00', 17, 7, 28),
    (140, 4, 19, '2025-09-11', '20:45:00', '21:15:00', 19, 10, 18);

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (141, 5, 23, '2025-09-11', '18:10:00', '18:40:00', 21, 26, 20),
    (142, 6, 27, '2025-09-11', '18:40:00', '19:10:00', 24, 30, 22),
    (143, 7, 31, '2025-09-11', '19:10:00', '19:40:00', 32, 28, 15),
    (144, 8, 35, '2025-09-11', '19:50:00', '20:20:00', 12, 34, 10),
    (145, 1, 1, '2025-09-11', '06:40:00', '07:15:00', 1, 2, 40),
    (146, 2, 6, '2025-09-11', '07:35:00', '08:05:00', 4, 5, 30),
    (147, 3, 11, '2025-09-11', '06:05:00', '06:40:00', 7, 8, 42),
    (148, 4, 16, '2025-09-11', '07:15:00', '07:50:00', 10, 11, 35),
    (149, 5, 21, '2025-09-11', '07:05:00', '07:35:00', 26, 27, 25),
    (150, 6, 25, '2025-09-11', '07:20:00', '07:50:00', 35, 24, 28),
    (151, 7, 29, '2025-09-11', '06:45:00', '07:15:00', 29, 28, 20),
    (152, 8, 33, '2025-09-11', '07:30:00', '08:00:00', 31, 25, 15),
    (153, 1, 3, '2025-09-11', '12:00:00', '12:30:00', 2, 21, 18),
    (154, 2, 8, '2025-09-11', '13:00:00', '13:30:00', 5, 15, 20),
    (155, 3, 13, '2025-09-11', '14:00:00', '14:30:00', 8, 18, 25),
    (156, 4, 18, '2025-09-11', '15:00:00', '15:30:00', 19, 11, 18),
    (157, 5, 22, '2025-09-11', '11:00:00', '11:30:00', 27, 33, 10),
    (158, 6, 26, '2025-09-11', '12:00:00', '12:30:00', 24, 6, 12),
    (159, 7, 30, '2025-09-11', '12:30:00', '13:00:00', 32, 28, 18),
    (160, 8, 34, '2025-09-11', '11:30:00', '12:00:00', 25, 10, 8),
    (161, 1, 4, '2025-09-11', '20:30:00', '21:00:00', 14, 3, 20),
    (162, 2, 9, '2025-09-11', '20:50:00', '21:20:00', 16, 4, 22),
    (163, 3, 14, '2025-09-11', '21:05:00', '21:35:00', 17, 7, 25),
    (164, 4, 19, '2025-09-11', '22:00:00', '22:30:00', 20, 10, 15),
    (165, 5, 23, '2025-09-11', '18:50:00', '19:20:00', 3, 26, 18),
    (166, 6, 27, '2025-09-11', '19:40:00', '20:10:00', 6, 24, 20),
    (167, 7, 31, '2025-09-11', '20:30:00', '21:00:00', 32, 9, 10),
    (168, 8, 35, '2025-09-11', '21:20:00', '21:50:00', 34, 12, 5);

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    -- === Bloque 2: Distribución de más viajes, usuarios adicionales y patrones ida/vuelta ===
    (169, 1, 1, '2025-09-11', '06:08:00', '06:43:00', 1, 2, 40),
    (170, 2, 6, '2025-09-11', '07:12:00', '07:42:00', 4, 5, 38),
    (171, 3, 11, '2025-09-11', '07:53:00', '08:23:00', 7, 28, 40),
    (172, 4, 16, '2025-09-11', '06:58:00', '07:33:00', 10, 11, 32),
    (169, 1, 4, '2025-09-11', '17:30:00', '18:05:00', 2, 1, 30), -- Usuario 169 vuelta
    (173, 5, 21, '2025-09-11', '07:18:00', '07:48:00', 26, 27, 28),
    (174, 6, 25, '2025-09-11', '06:48:00', '07:18:00', 35, 30, 30),
    (175, 7, 29, '2025-09-11', '07:28:00', '07:58:00', 29, 28, 22),
    (176, 8, 33, '2025-09-11', '08:00:00', '08:30:00', 31, 19, 15),
    (170, 2, 9, '2025-09-11', '19:10:00', '19:40:00', 5, 4, 25), -- Usuario 170 vuelta
    (177, 1, 2, '2025-09-11', '10:00:00', '10:30:00', 13, 14, 25),
    (178, 2, 7, '2025-09-11', '11:10:00', '11:40:00', 15, 16, 28),
    (179, 3, 12, '2025-09-11', '10:50:00', '11:20:00', 8, 18, 30),
    (180, 4, 17, '2025-09-11', '11:40:00', '12:10:00', 11, 20, 22),
    (181, 5, 21, '2025-09-11', '08:10:00', '08:40:00', 2, 26, 30),
    (182, 6, 25, '2025-09-11', '08:20:00', '08:50:00', 22, 35, 32),
    (183, 7, 29, '2025-09-11', '07:35:00', '08:05:00', 7, 8, 28),
    (184, 8, 33, '2025-09-11', '07:05:00', '07:35:00', 31, 25, 20),
    (185, 1, 3, '2025-09-11', '14:00:00', '14:30:00', 21, 13, 22),
    (186, 2, 8, '2025-09-11', '15:00:00', '15:30:00', 31, 15, 25),
    (187, 3, 13, '2025-09-11', '16:00:00', '16:30:00', 17, 9, 30),
    (188, 4, 18, '2025-09-11', '15:00:00', '15:30:00', 20, 11, 20),
    (189, 5, 22, '2025-09-11', '10:15:00', '10:45:00', 26, 27, 10),
    (190, 6, 26, '2025-09-11', '12:10:00', '12:40:00', 6, 24, 15),
    (191, 7, 30, '2025-09-11', '12:45:00', '13:15:00', 28, 32, 22),
    (192, 8, 34, '2025-09-11', '12:00:00', '12:30:00', 31, 10, 10),
    (193, 1, 4, '2025-09-11', '20:00:00', '20:30:00', 3, 14, 25),
    (194, 2, 9, '2025-09-11', '20:30:00', '21:00:00', 4, 16, 28),
    (195, 3, 14, '2025-09-11', '20:45:00', '21:15:00', 7, 18, 30),
    (196, 4, 19, '2025-09-11', '21:00:00', '21:30:00', 10, 19, 20),
    (197, 5, 23, '2025-09-11', '19:00:00', '19:30:00', 21, 33, 18),
    (198, 6, 27, '2025-09-11', '19:40:00', '20:10:00', 24, 6, 20),
    (199, 7, 31, '2025-09-11', '20:10:00', '20:40:00', 9, 32, 10),
    (200, 8, 35, '2025-09-11', '20:50:00', '21:20:00', 12, 34, 5);
    
    -- === Bloque 3: Más usuarios, viajes de ida/vuelta, más intersecciones, variabilidad horaria ===
    -- Rango de id_usuario para este bloque: ~201-450
    -- Se incluyen viajes en las franjas "Valle" de horarios más extensos.

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (201, 1, 1, '2025-09-11', '06:30:00', '07:05:00', 1, 21, 35),
    (202, 2, 6, '2025-09-11', '07:20:00', '07:50:00', 4, 5, 30),
    (203, 3, 11, '2025-09-11', '08:05:00', '08:35:00', 7, 29, 40),
    (204, 4, 16, '2025-09-11', '07:00:00', '07:30:00', 10, 19, 30),
    (205, 5, 21, '2025-09-11', '07:10:00', '07:40:00', 2, 26, 25), -- Intersección (La Carolina)
    (206, 6, 25, '2025-09-11', '07:50:00', '08:20:00', 24, 6, 28), -- Intersección (Parque Central)
    (207, 7, 29, '2025-09-11', '06:55:00', '07:25:00', 28, 32, 22),
    (208, 8, 33, '2025-09-11', '07:45:00', '08:15:00', 31, 25, 18),
    (201, 1, 4, '2025-09-11', '17:45:00', '18:20:00', 21, 1, 30), -- U201 Vuelta, Parada 21 a 1 (Intersección con Ruta 5)
    (209, 1, 2, '2025-09-11', '10:30:00', '11:00:00', 2, 13, 15), -- U209 en La Carolina (Intersección R5)
    (210, 2, 7, '2025-09-11', '10:55:00', '11:25:00', 5, 15, 18),
    (211, 3, 12, '2025-09-11', '11:00:00', '11:30:00', 28, 8, 20),
    (212, 4, 17, '2025-09-11', '10:10:00', '10:40:00', 19, 11, 25),
    (205, 5, 23, '2025-09-11', '18:00:00', '18:30:00', 33, 2, 22), -- U205 Vuelta, (La Carolina, Int R1)
    (213, 5, 22, '2025-09-11', '14:30:00', '15:00:00', 27, 33, 12),
    (214, 6, 26, '2025-09-11', '14:00:00', '14:30:00', 6, 22, 15), -- U214 en Parque Central (Int R2)
    (215, 6, 27, '2025-09-11', '19:00:00', '19:30:00', 22, 35, 25),
    (216, 7, 30, '2025-09-11', '14:15:00', '14:45:00', 7, 29, 18), -- U216 en Estación Este (Int R3, R7)
    (217, 7, 31, '2025-09-11', '19:30:00', '20:00:00', 32, 9, 20),
    (218, 8, 34, '2025-09-11', '14:45:00', '15:15:00', 10, 31, 10),
    (219, 8, 35, '2025-09-11', '21:00:00', '21:30:00', 12, 19, 5),
    (220, 1, 3, '2025-09-11', '15:00:00', '15:30:00', 13, 14, 25),
    (221, 2, 8, '2025-09-11', '13:30:00', '14:00:00', 31, 15, 28),
    (222, 3, 13, '2025-09-11', '16:00:00', '16:30:00', 9, 17, 32),
    (223, 4, 18, '2025-09-11', '15:30:00', '16:00:00', 20, 11, 20),
    (224, 5, 22, '2025-09-11', '10:00:00', '10:30:00', 26, 27, 10),
    (225, 6, 26, '2025-09-11', '11:00:00', '11:30:00', 24, 6, 15),
    (226, 7, 30, '2025-09-11', '11:45:00', '12:15:00', 32, 28, 20),
    (227, 8, 34, '2025-09-11', '11:30:00', '12:00:00', 10, 31, 12),
    (228, 1, 4, '2025-09-11', '19:40:00', '20:10:00', 3, 1, 28),
    (229, 2, 9, '2025-09-11', '20:00:00', '20:30:00', 6, 4, 20),
    (230, 3, 14, '2025-09-11', '20:15:00', '20:45:00', 17, 7, 28),
    (231, 4, 19, '2025-09-11', '21:00:00', '21:30:00', 12, 10, 18),
    (232, 5, 23, '2025-09-11', '19:00:00', '19:30:00', 33, 27, 20),
    (233, 6, 27, '2025-09-11', '19:30:00', '20:00:00', 22, 24, 25),
    (234, 7, 31, '2025-09-11', '19:45:00', '20:15:00', 9, 32, 12),
    (235, 8, 35, '2025-09-11', '20:30:00', '21:00:00', 34, 12, 8),
    (236, 1, 1, '2025-09-11', '06:10:00', '06:45:00', 1, 2, 45),
    (237, 2, 6, '2025-09-11', '07:05:00', '07:35:00', 4, 24, 40),
    (238, 3, 11, '2025-09-11', '07:30:00', '08:05:00', 7, 28, 48),
    (239, 4, 16, '2025-09-11', '06:40:00', '07:15:00', 10, 19, 38),
    (240, 5, 21, '2025-09-11', '07:20:00', '07:50:00', 26, 2, 30),
    (241, 6, 25, '2025-09-11', '07:15:00', '07:45:00', 35, 24, 35),
    (242, 7, 29, '2025-09-11', '07:40:00', '08:10:00', 8, 29, 25),
    (243, 8, 33, '2025-09-11', '07:55:00', '08:25:00', 34, 10, 20),
    (244, 1, 4, '2025-09-11', '18:15:00', '18:50:00', 3, 1, 42),
    (245, 2, 9, '2025-09-11', '18:30:00', '19:00:00', 24, 4, 32);

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (246, 3, 14, '2025-09-11', '18:50:00', '19:20:00', 28, 7, 30),
    (247, 4, 19, '2025-09-11', '19:30:00', '20:00:00', 19, 10, 35),
    (248, 5, 23, '2025-09-11', '18:40:00', '19:10:00', 2, 26, 28),
    (249, 6, 27, '2025-09-11', '19:15:00', '19:45:00', 24, 35, 22),
    (250, 7, 31, '2025-09-11', '19:20:00', '19:50:00', 9, 7, 18),
    (251, 8, 35, '2025-09-11', '21:40:00', '22:10:00', 12, 34, 8),
    (252, 1, 1, '2025-09-11', '07:10:00', '07:45:00', 1, 2, 40),
    (253, 2, 6, '2025-09-11', '06:55:00', '07:25:00', 4, 5, 35),
    (254, 3, 11, '2025-09-11', '08:15:00', '08:45:00', 7, 9, 42),
    (255, 4, 16, '2025-09-11', '07:00:00', '07:35:00', 10, 11, 30),
    (256, 5, 21, '2025-09-11', '08:00:00', '08:30:00', 27, 21, 28),
    (257, 6, 25, '2025-09-11', '07:30:00', '08:00:00', 6, 22, 30),
    (258, 7, 29, '2025-09-11', '06:25:00', '06:55:00', 29, 28, 20),
    (259, 8, 33, '2025-09-11', '08:10:00', '08:40:00', 31, 19, 15),
    (260, 1, 1, '2025-09-11', '08:40:00', '09:00:00', 3, 1, 40),
    (261, 2, 6, '2025-09-11', '08:50:00', '09:20:00', 24, 15, 30),
    (262, 3, 11, '2025-09-11', '06:10:00', '06:45:00', 7, 8, 45),
    (263, 4, 16, '2025-09-11', '08:20:00', '08:50:00', 12, 19, 40),
    (264, 5, 21, '2025-09-11', '06:30:00', '07:00:00', 2, 33, 25),
    (265, 6, 25, '2025-09-11', '08:35:00', '09:05:00', 30, 6, 32),
    (266, 7, 29, '2025-09-11', '06:50:00', '07:20:00', 28, 32, 22),
    (267, 8, 33, '2025-09-11', '06:15:00', '06:45:00', 31, 25, 10),
    (268, 1, 3, '2025-09-11', '12:30:00', '13:00:00', 2, 21, 20),
    (269, 2, 8, '2025-09-11', '14:00:00', '14:30:00', 24, 31, 25),
    (270, 3, 13, '2025-09-11', '15:00:00', '15:30:00', 8, 18, 30),
    (271, 4, 18, '2025-09-11', '13:00:00', '13:30:00', 11, 20, 20),
    (272, 5, 22, '2025-09-11', '10:00:00', '10:30:00', 26, 27, 10),
    (273, 6, 26, '2025-09-11', '11:00:00', '11:30:00', 30, 24, 15),
    (274, 7, 30, '2025-09-11', '11:45:00', '12:15:00', 7, 29, 22),
    (275, 8, 34, '2025-09-11', '10:30:00', '11:00:00', 10, 31, 12),
    (276, 1, 4, '2025-09-11', '19:00:00', '19:30:00', 14, 3, 30),
    (277, 2, 9, '2025-09-11', '19:20:00', '19:50:00', 16, 4, 30),
    (278, 3, 14, '2025-09-11', '19:40:00', '20:10:00', 9, 17, 35),
    (279, 4, 19, '2025-09-11', '20:10:00', '20:40:00', 12, 19, 25),
    (280, 5, 23, '2025-09-11', '18:00:00', '18:30:00', 2, 26, 20),
    (281, 6, 27, '2025-09-11', '18:20:00', '18:50:00', 24, 35, 22),
    (282, 7, 31, '2025-09-11', '18:30:00', '19:00:00', 32, 9, 15),
    (283, 8, 35, '2025-09-11', '18:50:00', '19:20:00', 10, 34, 10),
    (284, 1, 1, '2025-09-11', '06:05:00', '06:40:00', 1, 21, 38),
    (285, 2, 6, '2025-09-11', '07:00:00', '07:30:00', 4, 5, 33),
    (286, 3, 11, '2025-09-11', '07:45:00', '08:15:00', 7, 29, 40),
    (287, 4, 16, '2025-09-11', '06:30:00', '07:05:00', 10, 11, 30),
    (288, 5, 21, '2025-09-11', '07:00:00', '07:30:00', 26, 27, 28),
    (289, 6, 25, '2025-09-11', '06:50:00', '07:20:00', 35, 30, 32),
    (290, 7, 29, '2025-09-11', '06:30:00', '07:00:00', 29, 28, 20),
    (291, 8, 33, '2025-09-11', '07:40:00', '08:10:00', 31, 25, 15),
    (292, 1, 1, '2025-09-11', '08:00:00', '08:35:00', 13, 3, 40),
    (293, 2, 6, '2025-09-11', '08:05:00', '08:35:00', 24, 16, 35),
    (294, 3, 11, '2025-09-11', '08:30:00', '09:00:00', 28, 18, 42);

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (295, 4, 16, '2025-09-11', '07:50:00', '08:25:00', 19, 12, 37),
    (296, 5, 21, '2025-09-11', '08:20:00', '08:50:00', 33, 21, 25),
    (297, 6, 25, '2025-09-11', '07:45:00', '08:15:00', 6, 22, 28),
    (298, 7, 29, '2025-09-11', '06:40:00', '07:10:00', 7, 32, 21),
    (299, 8, 33, '2025-09-11', '06:20:00', '06:50:00', 25, 19, 10),
    (300, 1, 3, '2025-09-11', '12:10:00', '12:40:00', 2, 21, 22),
    (301, 2, 8, '2025-09-11', '14:15:00', '14:45:00', 5, 15, 25),
    (302, 3, 13, '2025-09-11', '15:10:00', '15:40:00', 17, 9, 30),
    (303, 4, 18, '2025-09-11', '14:00:00', '14:30:00', 11, 20, 20),
    (304, 5, 22, '2025-09-11', '10:30:00', '11:00:00', 26, 27, 12),
    (305, 6, 26, '2025-09-11', '11:30:00', '12:00:00', 24, 6, 18),
    (306, 7, 30, '2025-09-11', '12:00:00', '12:30:00', 32, 28, 25),
    (307, 8, 34, '2025-09-11', '11:00:00', '11:30:00', 31, 25, 15),
    (308, 1, 4, '2025-09-11', '19:40:00', '20:10:00', 3, 1, 28),
    (309, 2, 9, '2025-09-11', '20:00:00', '20:30:00', 6, 4, 20),
    (310, 3, 14, '2025-09-11', '20:15:00', '20:45:00', 17, 7, 28),
    (311, 4, 19, '2025-09-11', '21:00:00', '21:30:00', 12, 10, 18),
    (312, 5, 23, '2025-09-11', '19:00:00', '19:30:00', 33, 27, 20),
    (313, 6, 27, '2025-09-11', '19:30:00', '20:00:00', 22, 24, 25),
    (314, 7, 31, '2025-09-11', '19:45:00', '20:15:00', 9, 32, 12),
    (315, 8, 35, '2025-09-11', '20:30:00', '21:00:00', 34, 12, 8);

-- Relleno hasta 850 viajes
-- Asegurando que todos los 700 usuarios sean utilizados de forma rotativa

-- Bloque 4 (IDs 316-500)
INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (316, 1, 1, '2025-09-11', '06:10:00', '06:45:00', 1, 2, 45),
    (317, 2, 6, '2025-09-11', '07:05:00', '07:35:00', 4, 24, 40),
    (318, 3, 11, '2025-09-11', '07:30:00', '08:05:00', 7, 28, 48),
    (319, 4, 16, '2025-09-11', '06:40:00', '07:15:00', 10, 19, 38),
    (320, 5, 21, '2025-09-11', '07:20:00', '07:50:00', 26, 2, 30),
    (321, 6, 25, '2025-09-11', '07:15:00', '07:45:00', 35, 24, 35),
    (322, 7, 29, '2025-09-11', '07:40:00', '08:10:00', 8, 29, 25),
    (323, 8, 33, '2025-09-11', '07:55:00', '08:25:00', 34, 10, 20),
    (324, 1, 4, '2025-09-11', '18:15:00', '18:50:00', 3, 1, 42),
    (325, 2, 9, '2025-09-11', '18:30:00', '19:00:00', 24, 4, 32),
    (326, 3, 14, '2025-09-11', '18:50:00', '19:20:00', 28, 7, 30),
    (327, 4, 19, '2025-09-11', '19:30:00', '20:00:00', 19, 10, 35),
    (328, 5, 23, '2025-09-11', '18:40:00', '19:10:00', 2, 26, 28),
    (329, 6, 27, '2025-09-11', '19:15:00', '19:45:00', 24, 35, 22),
    (330, 7, 31, '2025-09-11', '19:20:00', '19:50:00', 9, 7, 18),
    (331, 8, 35, '2025-09-11', '21:40:00', '22:10:00', 12, 34, 8),
    (332, 1, 1, '2025-09-11', '07:10:00', '07:45:00', 1, 2, 40),
    (333, 2, 6, '2025-09-11', '06:55:00', '07:25:00', 4, 5, 35),
    (334, 3, 11, '2025-09-11', '08:15:00', '08:45:00', 7, 9, 42),
    (335, 4, 16, '2025-09-11', '07:00:00', '07:35:00', 10, 11, 30),
    (336, 5, 21, '2025-09-11', '08:00:00', '08:30:00', 27, 21, 28),
    (337, 6, 25, '2025-09-11', '07:30:00', '08:00:00', 6, 22, 30),
    (338, 7, 29, '2025-09-11', '06:25:00', '06:55:00', 29, 28, 20),
    (339, 8, 33, '2025-09-11', '08:10:00', '08:40:00', 31, 19, 15),
    (340, 1, 1, '2025-09-11', '08:40:00', '09:00:00', 3, 1, 40),
    (341, 2, 6, '2025-09-11', '08:50:00', '09:20:00', 24, 15, 30),
    (342, 3, 11, '2025-09-11', '06:10:00', '06:45:00', 7, 8, 45),
    (343, 4, 16, '2025-09-11', '08:20:00', '08:50:00', 12, 19, 40),
    (344, 5, 21, '2025-09-11', '06:30:00', '07:00:00', 2, 33, 25),
    (345, 6, 25, '2025-09-11', '08:35:00', '09:05:00', 30, 6, 32),
    (346, 7, 29, '2025-09-11', '06:50:00', '07:20:00', 28, 32, 22),
    (347, 8, 33, '2025-09-11', '06:15:00', '06:45:00', 31, 25, 10),
    (348, 1, 3, '2025-09-11', '12:30:00', '13:00:00', 2, 21, 20),
    (349, 2, 8, '2025-09-11', '14:00:00', '14:30:00', 24, 31, 25),
    (350, 3, 13, '2025-09-11', '15:00:00', '15:30:00', 8, 18, 30),
    (351, 4, 18, '2025-09-11', '13:00:00', '13:30:00', 11, 20, 20),
    (352, 5, 22, '2025-09-11', '10:00:00', '10:30:00', 26, 27, 10),
    (353, 6, 26, '2025-09-11', '11:00:00', '11:30:00', 30, 24, 15),
    (354, 7, 30, '2025-09-11', '11:45:00', '12:15:00', 7, 29, 22),
    (355, 8, 34, '2025-09-11', '10:30:00', '11:00:00', 10, 31, 12);

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (356, 1, 4, '2025-09-11', '19:00:00', '19:30:00', 14, 3, 30),
    (357, 2, 9, '2025-09-11', '19:20:00', '19:50:00', 16, 4, 30),
    (358, 3, 14, '2025-09-11', '19:40:00', '20:10:00', 9, 17, 35),
    (359, 4, 19, '2025-09-11', '20:10:00', '20:40:00', 12, 19, 25),
    (360, 5, 23, '2025-09-11', '18:00:00', '18:30:00', 2, 26, 20),
    (361, 6, 27, '2025-09-11', '18:20:00', '18:50:00', 24, 35, 22),
    (362, 7, 31, '2025-09-11', '18:30:00', '19:00:00', 32, 9, 15),
    (363, 8, 35, '2025-09-11', '18:50:00', '19:20:00', 10, 34, 10),
    (364, 1, 1, '2025-09-11', '06:05:00', '06:40:00', 1, 21, 38),
    (365, 2, 6, '2025-09-11', '07:00:00', '07:30:00', 4, 5, 33),
    (366, 3, 11, '2025-09-11', '07:45:00', '08:15:00', 7, 29, 40),
    (367, 4, 16, '2025-09-11', '06:30:00', '07:05:00', 10, 11, 30),
    (368, 5, 21, '2025-09-11', '07:00:00', '07:30:00', 26, 27, 28),
    (369, 6, 25, '2025-09-11', '06:50:00', '07:20:00', 35, 30, 32),
    (370, 7, 29, '2025-09-11', '06:30:00', '07:00:00', 29, 28, 20),
    (371, 8, 33, '2025-09-11', '07:40:00', '08:10:00', 31, 25, 15),
    (372, 1, 1, '2025-09-11', '08:00:00', '08:35:00', 13, 3, 40),
    (373, 2, 6, '2025-09-11', '08:05:00', '08:35:00', 24, 16, 35),
    (374, 3, 11, '2025-09-11', '08:30:00', '09:00:00', 28, 18, 42),
    (375, 4, 16, '2025-09-11', '07:50:00', '08:25:00', 19, 12, 37),
    (376, 5, 21, '2025-09-11', '08:20:00', '08:50:00', 33, 21, 25),
    (377, 6, 25, '2025-09-11', '07:45:00', '08:15:00', 6, 22, 28),
    (378, 7, 29, '2025-09-11', '06:40:00', '07:10:00', 7, 32, 21),
    (379, 8, 33, '2025-09-11', '06:20:00', '06:50:00', 25, 19, 10),
    (380, 1, 3, '2025-09-11', '12:10:00', '12:40:00', 2, 21, 22),
    (381, 2, 8, '2025-09-11', '14:15:00', '14:45:00', 5, 15, 25),
    (382, 3, 13, '2025-09-11', '15:10:00', '15:40:00', 17, 9, 30),
    (383, 4, 18, '2025-09-11', '14:00:00', '14:30:00', 11, 20, 20),
    (384, 5, 22, '2025-09-11', '10:30:00', '11:00:00', 26, 27, 12),
    (385, 6, 26, '2025-09-11', '11:30:00', '12:00:00', 24, 6, 18),
    (386, 7, 30, '2025-09-11', '12:00:00', '12:30:00', 32, 28, 25),
    (387, 8, 34, '2025-09-11', '11:00:00', '11:30:00', 31, 25, 15),
    (388, 1, 4, '2025-09-11', '19:40:00', '20:10:00', 3, 1, 28),
    (389, 2, 9, '2025-09-11', '20:00:00', '20:30:00', 6, 4, 20),
    (390, 3, 14, '2025-09-11', '20:15:00', '20:45:00', 17, 7, 28),
    (391, 4, 19, '2025-09-11', '21:00:00', '21:30:00', 12, 10, 18),
    (392, 5, 23, '2025-09-11', '19:00:00', '19:30:00', 33, 27, 20),
    (393, 6, 27, '2025-09-11', '19:30:00', '20:00:00', 22, 24, 25),
    (394, 7, 31, '2025-09-11', '19:45:00', '20:15:00', 9, 32, 12),
    (395, 8, 35, '2025-09-11', '20:30:00', '21:00:00', 34, 12, 8);

-- Bloque 5 (IDs 396-580)
INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (396, 1, 1, '2025-09-11', '06:15:00', '06:50:00', 1, 2, 42),
    (397, 2, 6, '2025-09-11', '07:10:00', '07:40:00', 4, 5, 38),
    (398, 3, 11, '2025-09-11', '07:50:00', '08:25:00', 29, 28, 40),
    (399, 4, 16, '2025-09-11', '06:50:00', '07:25:00', 10, 11, 33),
    (400, 5, 21, '2025-09-11', '07:15:00', '07:45:00', 2, 26, 27),
    (401, 6, 25, '2025-09-11', '07:00:00', '07:30:00', 22, 30, 29),
    (402, 7, 29, '2025-09-11', '06:35:00', '07:05:00', 7, 29, 22),
    (403, 8, 33, '2025-09-11', '08:00:00', '08:30:00', 25, 34, 18),
    (404, 1, 3, '2025-09-11', '12:45:00', '13:15:00', 21, 13, 20),
    (405, 2, 8, '2025-09-11', '14:20:00', '14:50:00', 31, 15, 28),
    (406, 3, 13, '2025-09-11', '15:20:00', '15:50:00', 17, 9, 32),
    (407, 4, 18, '2025-09-11', '13:30:00', '14:00:00', 20, 11, 25),
    (408, 5, 22, '2025-09-11', '10:45:00', '11:15:00', 27, 33, 15),
    (409, 6, 26, '2025-09-11', '11:40:00', '12:10:00', 24, 6, 20),
    (410, 7, 30, '2025-09-11', '12:10:00', '12:40:00', 32, 28, 28),
    (411, 8, 34, '2025-09-11', '11:15:00', '11:45:00', 25, 10, 18),
    (412, 1, 4, '2025-09-11', '20:10:00', '20:40:00', 14, 3, 25),
    (413, 2, 9, '2025-09-11', '20:40:00', '21:10:00', 16, 4, 28),
    (414, 3, 14, '2025-09-11', '20:50:00', '21:20:00', 17, 7, 30),
    (415, 4, 19, '2025-09-11', '21:30:00', '22:00:00', 19, 10, 20),
    (416, 5, 23, '2025-09-11', '19:10:00', '19:40:00', 21, 26, 22),
    (417, 6, 27, '2025-09-11', '19:50:00', '20:20:00', 24, 30, 20),
    (418, 7, 31, '2025-09-11', '20:20:00', '20:50:00', 9, 32, 10),
    (419, 8, 35, '2025-09-11', '21:10:00', '21:40:00', 34, 12, 5);

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    -- === Bloque 6 (IDs 581-700) y reuso de usuarios ===
    (420, 1, 1, '2025-09-11', '06:20:00', '06:55:00', 1, 2, 48),
    (421, 2, 6, '2025-09-11', '07:15:00', '07:45:00', 4, 24, 42),
    (422, 3, 11, '2025-09-11', '08:00:00', '08:35:00', 7, 28, 45),
    (423, 4, 16, '2025-09-11', '06:45:00', '07:20:00', 10, 19, 32),
    (424, 5, 21, '2025-09-11', '07:25:00', '07:55:00', 26, 27, 28),
    (425, 6, 25, '2025-09-11', '07:10:00', '07:40:00', 35, 30, 30),
    (426, 7, 29, '2025-09-11', '06:50:00', '07:20:00', 8, 29, 25),
    (427, 8, 33, '2025-09-11', '07:50:00', '08:20:00', 31, 25, 18),
    (428, 1, 1, '2025-09-11', '08:10:00', '08:45:00', 2, 21, 38),
    (429, 2, 6, '2025-09-11', '08:20:00', '08:50:00', 5, 31, 30),
    (430, 3, 11, '2025-09-11', '06:30:00', '07:05:00', 29, 28, 40),
    (431, 4, 16, '2025-09-11', '08:05:00', '08:35:00', 11, 20, 30),
    (432, 5, 21, '2025-09-11', '06:50:00', '07:20:00', 2, 33, 20),
    (433, 6, 25, '2025-09-11', '08:40:00', '09:10:00', 24, 6, 28),
    (434, 7, 29, '2025-09-11', '07:10:00', '07:40:00', 32, 28, 22),
    (435, 8, 33, '2025-09-11', '06:35:00', '07:05:00', 10, 31, 12),
    (436, 1, 3, '2025-09-11', '13:00:00', '13:30:00', 21, 13, 18),
    (437, 2, 8, '2025-09-11', '14:30:00', '15:00:00', 31, 15, 25),
    (438, 3, 13, '2025-09-11', '15:40:00', '16:10:00', 9, 17, 28),
    (439, 4, 18, '2025-09-11', '14:20:00', '14:50:00', 20, 11, 18),
    (440, 5, 22, '2025-09-11', '10:50:00', '11:20:00', 33, 21, 10),
    (441, 6, 26, '2025-09-11', '11:50:00', '12:20:00', 6, 22, 15),
    (442, 7, 30, '2025-09-11', '12:30:00', '13:00:00', 28, 32, 20),
    (443, 8, 34, '2025-09-11', '11:30:00', '12:00:00', 10, 31, 10),
    (444, 1, 4, '2025-09-11', '19:15:00', '19:45:00', 3, 1, 25),
    (445, 2, 9, '2025-09-11', '19:40:00', '20:10:00', 6, 4, 22),
    (446, 3, 14, '2025-09-11', '20:00:00', '20:30:00', 17, 7, 28),
    (447, 4, 19, '2025-09-11', '20:45:00', '21:15:00', 19, 10, 18),
    (448, 5, 23, '2025-09-11', '18:10:00', '18:40:00', 21, 26, 20),
    (449, 6, 27, '2025-09-11', '18:40:00', '19:10:00', 24, 30, 22),
    (450, 7, 31, '2025-09-11', '19:10:00', '19:40:00', 32, 28, 15),
    (451, 8, 35, '2025-09-11', '19:50:00', '20:20:00', 12, 34, 10);
    -- Generar 400 viajes más para 700 usuarios

-- Bloque 7 (Usuarios 452-700) - viajes de ida
INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (452, 1, 1, '2025-09-11', '06:30:00', '07:05:00', 1, 21, 35),
    (453, 2, 6, '2025-09-11', '07:20:00', '07:50:00', 4, 5, 30),
    (454, 3, 11, '2025-09-11', '08:05:00', '08:35:00', 7, 29, 40),
    (455, 4, 16, '2025-09-11', '07:00:00', '07:30:00', 10, 19, 30),
    (456, 5, 21, '2025-09-11', '07:10:00', '07:40:00', 2, 26, 25),
    (457, 6, 25, '2025-09-11', '07:50:00', '08:20:00', 24, 6, 28),
    (458, 7, 29, '2025-09-11', '06:55:00', '07:25:00', 28, 32, 22),
    (459, 8, 33, '2025-09-11', '07:45:00', '08:15:00', 31, 25, 18),
    (460, 1, 2, '2025-09-11', '09:30:00', '10:00:00', 2, 13, 20),
    (461, 2, 7, '2025-09-11', '10:00:00', '10:30:00', 5, 15, 22),
    (462, 3, 12, '2025-09-11', '10:30:00', '11:00:00', 7, 28, 25),
    (463, 4, 17, '2025-09-11', '10:50:00', '11:20:00', 10, 11, 18),
    (464, 5, 22, '2025-09-11', '14:00:00', '14:30:00', 26, 27, 10),
    (465, 6, 26, '2025-09-11', '14:30:00', '15:00:00', 24, 6, 12),
    (466, 7, 30, '2025-09-11', '15:15:00', '15:45:00', 7, 29, 15),
    (467, 8, 34, '2025-09-11', '15:40:00', '16:10:00', 10, 31, 8);
    -- 183 registros más para completar 850, algunos siendo vuelta.
    -- (simulación rápida del resto, para mantener el patrón)
    
-- Se sigue este patrón hasta que los 700 usuarios han tenido al menos un viaje y se alcancen las 850 filas
-- Los siguientes insert se generaron usando la lógica de los bloques anteriores

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (468, 1, 3, '2025-09-11', '12:00:00', '12:30:00', 13, 14, 20),
    (469, 2, 8, '2025-09-11', '13:30:00', '14:00:00', 15, 16, 25),
    (470, 3, 13, '2025-09-11', '14:00:00', '14:30:00', 18, 17, 30),
    (471, 4, 18, '2025-09-11', '15:00:00', '15:30:00', 20, 11, 20),
    (472, 5, 22, '2025-09-11', '11:00:00', '11:30:00', 27, 33, 10),
    (473, 6, 26, '2025-09-11', '12:00:00', '12:30:00', 24, 6, 12),
    (474, 7, 30, '2025-09-11', '12:30:00', '13:00:00', 32, 28, 18),
    (475, 8, 34, '2025-09-11', '11:30:00', '12:00:00', 25, 19, 8),
    (476, 1, 4, '2025-09-11', '20:30:00', '21:00:00', 3, 14, 20),
    (477, 2, 9, '2025-09-11', '20:50:00', '21:20:00', 4, 16, 22),
    (478, 3, 14, '2025-09-11', '21:05:00', '21:35:00', 7, 18, 25),
    (479, 4, 19, '2025-09-11', '22:00:00', '22:30:00', 10, 19, 15),
    (480, 5, 23, '2025-09-11', '18:50:00', '19:20:00', 3, 2, 18),
    (481, 6, 27, '2025-09-11', '19:40:00', '20:10:00', 22, 24, 20),
    (482, 7, 31, '2025-09-11', '20:30:00', '21:00:00', 28, 32, 10),
    (483, 8, 35, '2025-09-11', '21:20:00', '21:50:00', 34, 12, 5),
    (484, 1, 1, '2025-09-11', '06:10:00', '06:45:00', 1, 21, 45),
    (485, 2, 6, '2025-09-11', '07:05:00', '07:35:00', 4, 24, 40),
    (486, 3, 11, '2025-09-11', '07:30:00', '08:05:00', 7, 28, 48),
    (487, 4, 16, '2025-09-11', '06:40:00', '07:15:00', 10, 19, 38),
    (488, 5, 21, '2025-09-11', '07:20:00', '07:50:00', 26, 2, 30),
    (489, 6, 25, '2025-09-11', '07:15:00', '07:45:00', 35, 24, 35),
    (490, 7, 29, '2025-09-11', '07:40:00', '08:10:00', 8, 29, 25),
    (491, 8, 33, '2025-09-11', '07:55:00', '08:25:00', 34, 10, 20),
    (492, 1, 4, '2025-09-11', '18:15:00', '18:50:00', 3, 1, 42),
    (493, 2, 9, '2025-09-11', '18:30:00', '19:00:00', 24, 4, 32),
    (494, 3, 14, '2025-09-11', '18:50:00', '19:20:00', 28, 7, 30),
    (495, 4, 19, '2025-09-11', '19:30:00', '20:00:00', 19, 10, 35),
    (496, 5, 23, '2025-09-11', '18:40:00', '19:10:00', 2, 26, 28),
    (497, 6, 27, '2025-09-11', '19:15:00', '19:45:00', 24, 35, 22),
    (498, 7, 31, '2025-09-11', '19:20:00', '19:50:00', 9, 7, 18),
    (499, 8, 35, '2025-09-11', '21:40:00', '22:10:00', 12, 34, 8),
    (500, 1, 1, '2025-09-11', '07:10:00', '07:45:00', 1, 2, 40),
    (501, 2, 6, '2025-09-11', '06:55:00', '07:25:00', 4, 5, 35),
    (502, 3, 11, '2025-09-11', '08:15:00', '08:45:00', 7, 9, 42),
    (503, 4, 16, '2025-09-11', '07:00:00', '07:35:00', 10, 11, 30),
    (504, 5, 21, '2025-09-11', '08:00:00', '08:30:00', 27, 21, 28),
    (505, 6, 25, '2025-09-11', '07:30:00', '08:00:00', 6, 22, 30),
    (506, 7, 29, '2025-09-11', '06:25:00', '06:55:00', 29, 28, 20),
    (507, 8, 33, '2025-09-11', '08:10:00', '08:40:00', 31, 19, 15),
    (508, 1, 1, '2025-09-11', '08:40:00', '09:00:00', 3, 1, 40),
    (509, 2, 6, '2025-09-11', '08:50:00', '09:20:00', 24, 15, 30),
    (510, 3, 11, '2025-09-11', '06:10:00', '06:45:00', 7, 8, 45),
    (511, 4, 16, '2025-09-11', '08:20:00', '08:50:00', 12, 19, 40),
    (512, 5, 21, '2025-09-11', '06:30:00', '07:00:00', 2, 33, 25),
    (513, 6, 25, '2025-09-11', '08:35:00', '09:05:00', 30, 6, 32),
    (514, 7, 29, '2025-09-11', '06:50:00', '07:20:00', 28, 32, 22),
    (515, 8, 33, '2025-09-11', '06:15:00', '06:45:00', 31, 25, 10);

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (516, 1, 3, '2025-09-11', '12:30:00', '13:00:00', 2, 21, 20),
    (517, 2, 8, '2025-09-11', '14:00:00', '14:30:00', 24, 31, 25),
    (518, 3, 13, '2025-09-11', '15:00:00', '15:30:00', 8, 18, 30),
    (519, 4, 18, '2025-09-11', '13:00:00', '13:30:00', 11, 20, 20),
    (520, 5, 22, '2025-09-11', '10:00:00', '10:30:00', 26, 27, 10),
    (521, 6, 26, '2025-09-11', '11:00:00', '11:30:00', 30, 24, 15),
    (522, 7, 30, '2025-09-11', '11:45:00', '12:15:00', 7, 29, 22),
    (523, 8, 34, '2025-09-11', '10:30:00', '11:00:00', 10, 31, 12),
    (524, 1, 4, '2025-09-11', '19:00:00', '19:30:00', 14, 3, 30),
    (525, 2, 9, '2025-09-11', '19:20:00', '19:50:00', 16, 4, 30),
    (526, 3, 14, '2025-09-11', '19:40:00', '20:10:00', 9, 17, 35),
    (527, 4, 19, '2025-09-11', '20:10:00', '20:40:00', 12, 19, 25),
    (528, 5, 23, '2025-09-11', '18:00:00', '18:30:00', 2, 26, 20),
    (529, 6, 27, '2025-09-11', '18:20:00', '18:50:00', 24, 35, 22),
    (530, 7, 31, '2025-09-11', '18:30:00', '19:00:00', 32, 9, 15),
    (531, 8, 35, '2025-09-11', '18:50:00', '19:20:00', 10, 34, 10);
    -- Duplicando los 531 viajes generados en Bloque 1 y 2, y añadiendo más hasta 850+
    -- El resto de usuarios (hasta 700) también toman un viaje.

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (532, 1, 1, '2025-09-11', '06:05:00', '06:40:00', 1, 21, 38),
    (533, 2, 6, '2025-09-11', '07:00:00', '07:30:00', 4, 5, 33),
    (534, 3, 11, '2025-09-11', '07:45:00', '08:15:00', 7, 29, 40),
    (535, 4, 16, '2025-09-11', '06:30:00', '07:05:00', 10, 11, 30),
    (536, 5, 21, '2025-09-11', '07:00:00', '07:30:00', 26, 27, 28),
    (537, 6, 25, '2025-09-11', '06:50:00', '07:20:00', 35, 30, 32),
    (538, 7, 29, '2025-09-11', '06:30:00', '07:00:00', 29, 28, 20),
    (539, 8, 33, '2025-09-11', '07:40:00', '08:10:00', 31, 25, 15),
    (540, 1, 1, '2025-09-11', '08:00:00', '08:35:00', 13, 3, 40),
    (541, 2, 6, '2025-09-11', '08:05:00', '08:35:00', 24, 16, 35),
    (542, 3, 11, '2025-09-11', '08:30:00', '09:00:00', 28, 18, 42),
    (543, 4, 16, '2025-09-11', '07:50:00', '08:25:00', 19, 12, 37),
    (544, 5, 21, '2025-09-11', '08:20:00', '08:50:00', 33, 21, 25),
    (545, 6, 25, '2025-09-11', '07:45:00', '08:15:00', 6, 22, 28),
    (546, 7, 29, '2025-09-11', '06:40:00', '07:10:00', 7, 32, 21),
    (547, 8, 33, '2025-09-11', '06:20:00', '06:50:00', 25, 19, 10),
    (548, 1, 3, '2025-09-11', '12:10:00', '12:40:00', 2, 21, 22),
    (549, 2, 8, '2025-09-11', '14:15:00', '14:45:00', 5, 15, 25),
    (550, 3, 13, '2025-09-11', '15:10:00', '15:40:00', 17, 9, 30),
    (551, 4, 18, '2025-09-11', '14:00:00', '14:30:00', 11, 20, 20),
    (552, 5, 22, '2025-09-11', '10:30:00', '11:00:00', 26, 27, 12),
    (553, 6, 26, '2025-09-11', '11:30:00', '12:00:00', 24, 6, 18),
    (554, 7, 30, '2025-09-11', '12:00:00', '12:30:00', 32, 28, 25),
    (555, 8, 34, '2025-09-11', '11:00:00', '11:30:00', 31, 25, 15),
    (556, 1, 4, '2025-09-11', '19:40:00', '20:10:00', 3, 1, 28),
    (557, 2, 9, '2025-09-11', '20:00:00', '20:30:00', 6, 4, 20),
    (558, 3, 14, '2025-09-11', '20:15:00', '20:45:00', 17, 7, 28),
    (559, 4, 19, '2025-09-11', '21:00:00', '21:30:00', 12, 10, 18),
    (560, 5, 23, '2025-09-11', '19:00:00', '19:30:00', 33, 27, 20),
    (561, 6, 27, '2025-09-11', '19:30:00', '20:00:00', 22, 24, 25),
    (562, 7, 31, '2025-09-11', '19:45:00', '20:15:00', 9, 32, 12),
    (563, 8, 35, '2025-09-11', '20:30:00', '21:00:00', 34, 12, 8),
    (564, 1, 1, '2025-09-11', '06:15:00', '06:50:00', 1, 2, 42),
    (565, 2, 6, '2025-09-11', '07:10:00', '07:40:00', 4, 5, 38),
    (566, 3, 11, '2025-09-11', '07:50:00', '08:25:00', 29, 28, 40),
    (567, 4, 16, '2025-09-11', '06:50:00', '07:25:00', 10, 11, 33),
    (568, 5, 21, '2025-09-11', '07:15:00', '07:45:00', 2, 26, 27),
    (569, 6, 25, '2025-09-11', '07:00:00', '07:30:00', 22, 30, 29),
    (570, 7, 29, '2025-09-11', '06:35:00', '07:05:00', 7, 29, 22),
    (571, 8, 33, '2025-09-11', '08:00:00', '08:30:00', 25, 34, 18),
    (572, 1, 3, '2025-09-11', '12:45:00', '13:15:00', 21, 13, 20),
    (573, 2, 8, '2025-09-11', '14:20:00', '14:50:00', 31, 15, 28),
    (574, 3, 13, '2025-09-11', '15:20:00', '15:50:00', 17, 9, 32),
    (575, 4, 18, '2025-09-11', '13:30:00', '14:00:00', 20, 11, 25),
    (576, 5, 22, '2025-09-11', '10:45:00', '11:15:00', 27, 33, 15),
    (577, 6, 26, '2025-09-11', '11:40:00', '12:10:00', 24, 6, 20),
    (578, 7, 30, '2025-09-11', '12:10:00', '12:40:00', 32, 28, 28),
    (579, 8, 34, '2025-09-11', '11:15:00', '11:45:00', 25, 10, 18);

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (580, 1, 4, '2025-09-11', '20:10:00', '20:40:00', 14, 3, 25),
    (581, 2, 9, '2025-09-11', '20:40:00', '21:10:00', 16, 4, 28),
    (582, 3, 14, '2025-09-11', '20:50:00', '21:20:00', 9, 17, 30),
    (583, 4, 19, '2025-09-11', '21:30:00', '22:00:00', 10, 19, 20),
    (584, 5, 23, '2025-09-11', '19:10:00', '19:40:00', 3, 26, 22),
    (585, 6, 27, '2025-09-11', '19:50:00', '20:20:00', 6, 24, 20),
    (586, 7, 31, '2025-09-11', '20:20:00', '20:50:00', 32, 28, 10),
    (587, 8, 35, '2025-09-11', '21:10:00', '21:40:00', 34, 12, 5),
    (588, 1, 1, '2025-09-11', '06:40:00', '07:15:00', 1, 21, 40),
    (589, 2, 6, '2025-09-11', '07:35:00', '08:05:00', 4, 5, 30),
    (590, 3, 11, '2025-09-11', '06:05:00', '06:40:00', 7, 8, 42),
    (591, 4, 16, '2025-09-11', '07:15:00', '07:50:00', 10, 11, 35),
    (592, 5, 21, '2025-09-11', '07:05:00', '07:35:00', 26, 27, 25),
    (593, 6, 25, '2025-09-11', '07:20:00', '07:50:00', 35, 30, 28),
    (594, 7, 29, '2025-09-11', '06:45:00', '07:15:00', 29, 28, 20),
    (595, 8, 33, '2025-09-11', '07:30:00', '08:00:00', 31, 25, 15),
    (596, 1, 3, '2025-09-11', '12:00:00', '12:30:00', 2, 21, 18),
    (597, 2, 8, '2025-09-11', '13:00:00', '13:30:00', 5, 15, 20),
    (598, 3, 13, '2025-09-11', '14:00:00', '14:30:00', 8, 18, 25),
    (599, 4, 18, '2025-09-11', '15:00:00', '15:30:00', 19, 11, 18),
    (600, 5, 22, '2025-09-11', '11:00:00', '11:30:00', 27, 33, 10),
    (601, 6, 26, '2025-09-11', '12:00:00', '12:30:00', 24, 6, 12),
    (602, 7, 30, '2025-09-11', '12:30:00', '13:00:00', 32, 28, 18),
    (603, 8, 34, '2025-09-11', '11:30:00', '12:00:00', 25, 19, 8),
    (604, 1, 4, '2025-09-11', '20:30:00', '21:00:00', 3, 14, 20),
    (605, 2, 9, '2025-09-11', '20:50:00', '21:20:00', 4, 16, 22),
    (606, 3, 14, '2025-09-11', '21:05:00', '21:35:00', 7, 18, 25),
    (607, 4, 19, '2025-09-11', '22:00:00', '22:30:00', 10, 19, 15),
    (608, 5, 23, '2025-09-11', '18:50:00', '19:20:00', 3, 26, 18),
    (609, 6, 27, '2025-09-11', '19:40:00', '20:10:00', 22, 24, 20),
    (610, 7, 31, '2025-09-11', '20:30:00', '21:00:00', 28, 32, 10),
    (611, 8, 35, '2025-09-11', '21:20:00', '21:50:00', 34, 12, 5),
    (612, 1, 1, '2025-09-11', '06:10:00', '06:45:00', 1, 2, 45),
    (613, 2, 6, '2025-09-11', '07:05:00', '07:35:00', 4, 24, 40),
    (614, 3, 11, '2025-09-11', '07:30:00', '08:05:00', 7, 28, 48),
    (615, 4, 16, '2025-09-11', '06:40:00', '07:15:00', 10, 19, 38),
    (616, 5, 21, '2025-09-11', '07:20:00', '07:50:00', 26, 2, 30),
    (617, 6, 25, '2025-09-11', '07:15:00', '07:45:00', 35, 24, 35),
    (618, 7, 29, '2025-09-11', '07:40:00', '08:10:00', 8, 29, 25),
    (619, 8, 33, '2025-09-11', '07:55:00', '08:25:00', 34, 10, 20),
    (620, 1, 4, '2025-09-11', '18:15:00', '18:50:00', 3, 1, 42);

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (621, 2, 9, '2025-09-11', '18:30:00', '19:00:00', 24, 4, 32),
    (622, 3, 14, '2025-09-11', '18:50:00', '19:20:00', 28, 7, 30),
    (623, 4, 19, '2025-09-11', '19:30:00', '20:00:00', 19, 10, 35),
    (624, 5, 23, '2025-09-11', '18:40:00', '19:10:00', 2, 26, 28),
    (625, 6, 27, '2025-09-11', '19:15:00', '19:45:00', 24, 35, 22),
    (626, 7, 31, '2025-09-11', '19:20:00', '19:50:00', 9, 7, 18),
    (627, 8, 35, '2025-09-11', '21:40:00', '22:10:00', 12, 34, 8),
    (628, 1, 1, '2025-09-11', '07:10:00', '07:45:00', 1, 2, 40),
    (629, 2, 6, '2025-09-11', '06:55:00', '07:25:00', 4, 5, 35),
    (630, 3, 11, '2025-09-11', '08:15:00', '08:45:00', 7, 9, 42),
    (631, 4, 16, '2025-09-11', '07:00:00', '07:35:00', 10, 11, 30),
    (632, 5, 21, '2025-09-11', '08:00:00', '08:30:00', 27, 21, 28),
    (633, 6, 25, '2025-09-11', '07:30:00', '08:00:00', 6, 22, 30),
    (634, 7, 29, '2025-09-11', '06:25:00', '06:55:00', 29, 28, 20),
    (635, 8, 33, '2025-09-11', '08:10:00', '08:40:00', 31, 19, 15),
    (636, 1, 1, '2025-09-11', '08:40:00', '09:00:00', 3, 1, 40),
    (637, 2, 6, '2025-09-11', '08:50:00', '09:20:00', 24, 15, 30),
    (638, 3, 11, '2025-09-11', '06:10:00', '06:45:00', 7, 8, 45),
    (639, 4, 16, '2025-09-11', '08:20:00', '08:50:00', 12, 19, 40),
    (640, 5, 21, '2025-09-11', '06:30:00', '07:00:00', 2, 33, 25),
    (641, 6, 25, '2025-09-11', '08:35:00', '09:05:00', 30, 6, 32),
    (642, 7, 29, '2025-09-11', '06:50:00', '07:20:00', 28, 32, 22),
    (643, 8, 33, '2025-09-11', '06:15:00', '06:45:00', 31, 25, 10),
    (644, 1, 3, '2025-09-11', '12:30:00', '13:00:00', 2, 21, 20),
    (645, 2, 8, '2025-09-11', '14:00:00', '14:30:00', 24, 31, 25),
    (646, 3, 13, '2025-09-11', '15:00:00', '15:30:00', 8, 18, 30),
    (647, 4, 18, '2025-09-11', '13:00:00', '13:30:00', 11, 20, 20),
    (648, 5, 22, '2025-09-11', '10:00:00', '10:30:00', 26, 27, 10),
    (649, 6, 26, '2025-09-11', '11:00:00', '11:30:00', 30, 24, 15),
    (650, 7, 30, '2025-09-11', '11:45:00', '12:15:00', 7, 29, 22);

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (651, 8, 34, '2025-09-11', '10:30:00', '11:00:00', 10, 31, 12),
    (652, 1, 4, '2025-09-11', '19:00:00', '19:30:00', 14, 3, 30),
    (653, 2, 9, '2025-09-11', '19:20:00', '19:50:00', 16, 4, 30),
    (654, 3, 14, '2025-09-11', '19:40:00', '20:10:00', 9, 17, 35),
    (655, 4, 19, '2025-09-11', '20:10:00', '20:40:00', 12, 19, 25),
    (656, 5, 23, '2025-09-11', '18:00:00', '18:30:00', 2, 26, 20),
    (657, 6, 27, '2025-09-11', '18:20:00', '18:50:00', 24, 35, 22),
    (658, 7, 31, '2025-09-11', '18:30:00', '19:00:00', 32, 9, 15),
    (659, 8, 35, '2025-09-11', '18:50:00', '19:20:00', 10, 34, 10),
    (660, 1, 1, '2025-09-11', '06:05:00', '06:40:00', 1, 21, 38),
    (661, 2, 6, '2025-09-11', '07:00:00', '07:30:00', 4, 5, 33),
    (662, 3, 11, '2025-09-11', '07:45:00', '08:15:00', 7, 29, 40),
    (663, 4, 16, '2025-09-11', '06:30:00', '07:05:00', 10, 11, 30),
    (664, 5, 21, '2025-09-11', '07:00:00', '07:30:00', 26, 27, 28),
    (665, 6, 25, '2025-09-11', '06:50:00', '07:20:00', 35, 30, 32),
    (666, 7, 29, '2025-09-11', '06:30:00', '07:00:00', 29, 28, 20),
    (667, 8, 33, '2025-09-11', '07:40:00', '08:10:00', 31, 25, 15),
    (668, 1, 1, '2025-09-11', '08:00:00', '08:35:00', 13, 3, 40),
    (669, 2, 6, '2025-09-11', '08:05:00', '08:35:00', 24, 16, 35),
    (670, 3, 11, '2025-09-11', '08:30:00', '09:00:00', 28, 18, 42),
    (671, 4, 16, '2025-09-11', '07:50:00', '08:25:00', 19, 12, 37),
    (672, 5, 21, '2025-09-11', '08:20:00', '08:50:00', 33, 21, 25),
    (673, 6, 25, '2025-09-11', '07:45:00', '08:15:00', 6, 22, 28),
    (674, 7, 29, '2025-09-11', '06:40:00', '07:10:00', 7, 32, 21),
    (675, 8, 33, '2025-09-11', '06:20:00', '06:50:00', 25, 19, 10),
    (676, 1, 3, '2025-09-11', '12:10:00', '12:40:00', 2, 21, 22),
    (677, 2, 8, '2025-09-11', '14:15:00', '14:45:00', 5, 15, 25),
    (678, 3, 13, '2025-09-11', '15:10:00', '15:40:00', 17, 9, 30),
    (679, 4, 18, '2025-09-11', '14:00:00', '14:30:00', 11, 20, 20),
    (680, 5, 22, '2025-09-11', '10:30:00', '11:00:00', 26, 27, 12),
    (681, 6, 26, '2025-09-11', '11:30:00', '12:00:00', 24, 6, 18),
    (682, 7, 30, '2025-09-11', '12:00:00', '12:30:00', 32, 28, 25),
    (683, 8, 34, '2025-09-11', '11:00:00', '11:30:00', 31, 25, 15),
    (684, 1, 4, '2025-09-11', '19:40:00', '20:10:00', 3, 1, 28),
    (685, 2, 9, '2025-09-11', '20:00:00', '20:30:00', 6, 4, 20),
    (686, 3, 14, '2025-09-11', '20:15:00', '20:45:00', 17, 7, 28),
    (687, 4, 19, '2025-09-11', '21:00:00', '21:30:00', 12, 10, 18),
    (688, 5, 23, '2025-09-11', '19:00:00', '19:30:00', 33, 27, 20),
    (689, 6, 27, '2025-09-11', '19:30:00', '20:00:00', 22, 24, 25),
    (690, 7, 31, '2025-09-11', '19:45:00', '20:15:00', 9, 32, 12);

INSERT INTO Uso_Transporte_NEW (id_usuario, id_ruta, id_horario, fecha, hora_abordaje, hora_descenso, id_parada_abordaje, id_parada_descenso, ocupacion) VALUES
    (691, 8, 35, '2025-09-11', '20:30:00', '21:00:00', 34, 12, 8),
    (692, 1, 1, '2025-09-11', '06:15:00', '06:50:00', 1, 2, 42),
    (693, 2, 6, '2025-09-11', '07:10:00', '07:40:00', 4, 5, 38),
    (694, 3, 11, '2025-09-11', '07:50:00', '08:25:00', 29, 28, 40),
    (695, 4, 16, '2025-09-11', '06:50:00', '07:25:00', 10, 11, 33),
    (696, 5, 21, '2025-09-11', '07:15:00', '07:45:00', 2, 26, 27),
    (697, 6, 25, '2025-09-11', '07:00:00', '07:30:00', 22, 30, 29),
    (698, 7, 29, '2025-09-11', '06:35:00', '07:05:00', 7, 29, 22),
    (699, 8, 33, '2025-09-11', '08:00:00', '08:30:00', 25, 34, 18),
    (700, 1, 3, '2025-09-11', '12:45:00', '13:15:00', 21, 13, 20),
    (1, 2, 8, '2025-09-11', '14:20:00', '14:50:00', 31, 15, 28), -- Usuario 1 viaja de nuevo
    (2, 3, 13, '2025-09-11', '15:20:00', '15:50:00', 17, 9, 32), -- Usuario 2 viaja de nuevo
    (3, 4, 18, '2025-09-11', '13:30:00', '14:00:00', 20, 11, 25),
    (4, 5, 22, '2025-09-11', '10:45:00', '11:15:00', 27, 33, 15),
    (5, 6, 26, '2025-09-11', '11:40:00', '12:10:00', 24, 6, 20),
    (6, 7, 30, '2025-09-11', '12:10:00', '12:40:00', 32, 28, 28),
    (7, 8, 34, '2025-09-11', '11:15:00', '11:45:00', 25, 10, 18),
    (8, 1, 4, '2025-09-11', '20:10:00', '20:40:00', 14, 3, 25),
    (9, 2, 9, '2025-09-11', '20:40:00', '21:10:00', 16, 4, 28),
    (10, 3, 14, '2025-09-11', '20:50:00', '21:20:00', 9, 17, 30),
    (11, 4, 19, '2025-09-11', '21:30:00', '22:00:00', 10, 19, 20),
    (12, 5, 23, '2025-09-11', '19:10:00', '19:40:00', 3, 26, 22),
    (13, 6, 27, '2025-09-11', '19:50:00', '20:20:00', 6, 24, 20),
    (14, 7, 31, '2025-09-11', '20:20:00', '20:50:00', 28, 32, 10),
    (15, 8, 35, '2025-09-11', '21:10:00', '21:40:00', 34, 12, 5),
    (16, 1, 1, '2025-09-11', '06:40:00', '07:15:00', 1, 2, 40),
    (17, 2, 6, '2025-09-11', '07:35:00', '08:05:00', 4, 5, 30),
    (18, 3, 11, '2025-09-11', '06:05:00', '06:40:00', 7, 8, 42),
    (19, 4, 16, '2025-09-11', '07:15:00', '07:50:00', 10, 11, 35),
    (20, 5, 21, '2025-09-11', '07:05:00', '07:35:00', 26, 27, 25);

ALTER TABLE Uso_Transporte_NEW
DROP COLUMN ocupacion;

select * from Uso_Transporte_NEW;


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
    
