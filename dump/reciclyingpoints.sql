DROP DATABASE IF EXISTS recicling_points;
CREATE DATABASE recicling_points CHARACTER SET utf8mb4;
USE recicling_points;



CREATE TABLE Usuario(
id_usuario INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
correo VARCHAR(40) NOT NULL,
contrasena VARCHAR(100) NOT NULL,
tipo_usuario VARCHAR(30) NOT NULL,
fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
estado VARCHAR(30) NOT NULL,
puntos INT UNSIGNED DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE administrador(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
correo VARCHAR(40) NOT NULL,
contrasena VARCHAR(100) NOT NULL,
tipo_usuario VARCHAR(30) NOT NULL,
fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
estado VARCHAR(30) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE soporte_tecnico(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
fallas VARCHAR(100) NOT NULL,
mantenimiento VARCHAR(100) NOT NULL
) ENGINE=InnoDB;



CREATE TABLE entrega_material(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_usuario INT UNSIGNED NOT NULL,
lugar VARCHAR(40) NOT NULL,
fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
peso DECIMAL(8,2) NOT NULL,
tipo_material ENUM ('papel','plastico','carton','latas','vidrio') NOT NULL,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB;



CREATE TABLE encargado(
id_encargado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
punto VARCHAR(25) NOT NULL,
id_entrega_material INT UNSIGNED,
FOREIGN KEY (id_entrega_material) REFERENCES entrega_material(id) ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE supermercado(
id_supermercado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_encargado INT UNSIGNED NOT NULL,
nombre VARCHAR(30) NOT NULL,
direccion VARCHAR(50) NOT NULL,
FOREIGN KEY (id_encargado) REFERENCES encargado(id_encargado) ON DELETE CASCADE
) ENGINE=InnoDB;



CREATE TABLE materiales(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_supermercado INT UNSIGNED NOT NULL,
id_usuario INT UNSIGNED NOT NULL,
nombre VARCHAR(30) NOT NULL,
puntos INT NOT NULL,
estado ENUM ('optimo', 'bueno' , 'falta') NOT NULL,
FOREIGN KEY (id_supermercado) REFERENCES supermercado(id_supermercado) ON DELETE CASCADE,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB;



CREATE TABLE Horario(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_supermercado INT UNSIGNED NOT NULL,
id_usuario INT UNSIGNED NOT NULL,
H_inicial TIME NOT NULL,
H_final TIME NOT NULL,
FOREIGN KEY (id_supermercado) REFERENCES supermercado(id_supermercado) ON DELETE CASCADE,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB;





CREATE TABLE Canjes(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_usuario INT UNSIGNED NOT NULL,
descripcion VARCHAR(60) NOT NULL,
beneficio VARCHAR(50) NOT NULL,
puntos_utilizados INT NOT NULL,
fecha_canje TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Calificacion(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_usuario INT UNSIGNED NOT NULL,
fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
descripcion VARCHAR(100) NOT NULL,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Reportes_error(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_usuario INT UNSIGNED NOT NULL,
id_soporte_tecnico INT UNSIGNED NOT NULL,
descripcion VARCHAR(100) NOT NULL,
estado ENUM ('bien','error') NOT NULL,
fecha_reporte TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
FOREIGN KEY (id_soporte_tecnico) REFERENCES soporte_tecnico(id) ON DELETE CASCADE
) ENGINE=InnoDB;



CREATE TABLE Roles(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_usuario INT UNSIGNED,
id_administrador INT UNSIGNED,
id_supermercado INT UNSIGNED,
id_soporte_tecnico INT UNSIGNED,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
FOREIGN KEY (id_administrador) REFERENCES administrador(id) ON DELETE CASCADE,
FOREIGN KEY (id_supermercado) REFERENCES supermercado(id_supermercado) ON DELETE CASCADE,
FOREIGN KEY (id_soporte_tecnico) REFERENCES soporte_tecnico(id) ON DELETE CASCADE
) ENGINE=InnoDB;


INSERT INTO Usuario (nombre, correo, contrasena, tipo_usuario, estado, puntos) VALUES
('Ana Torres', 'ana@test.com', '123456', 'cliente', 'activo', 30),
('Luis Perez', 'luis@test.com', '123456', 'cliente', 'activo', 80),
('Sofia Martinez', 'sofia@test.com', '123456', 'cliente', 'inactivo', 10),
('David Ramirez', 'david@test.com', '123456', 'cliente', 'activo', 200),
('Laura Gomez', 'laura@test.com', '123456', 'cliente', 'activo', 60),
('Pedro Sanchez', 'pedro@test.com', '123456', 'admin', 'activo', 0),
('Camila Herrera', 'camila@test.com', '123456', 'cliente', 'activo', 15),
('Andres Castro', 'andres@test.com', '123456', 'cliente', 'suspendido', 5),
('Valentina Rios', 'valentina@test.com', '123456', 'cliente', 'activo', 95),
('Jorge Diaz', 'jorge@test.com', '123456', 'cliente', 'activo', 40);


INSERT INTO administrador 
(nombre, correo, contrasena, tipo_usuario, estado)
VALUES 
('Admin Principal', 'admin1@sistema.com', '123456', 'superadmin', 'activo'),
('Soporte Tecnico', 'soporte@sistema.com', 'admin123', 'admin', 'activo');


INSERT INTO entrega_material 
(id_usuario, lugar, peso, tipo_material)
VALUES
(1, 'Centro de Reciclaje Norte', 12.50, 'papel'),
(2, 'Punto Verde Central', 8.75, 'plastico'),
(3, 'Estacion Ecologica Sur', 15.20, 'carton'),
(4, 'Recicladora Municipal', 5.40, 'latas'),
(5, 'Centro Ambiental Este', 20.00, 'vidrio');


INSERT INTO encargado
(nombre, punto, id_entrega_material)
VALUES
('Miguel Herrera', 'Punto Norte', 1),
('Daniela Ruiz', 'Punto Central', 2),
('Fernando Lopez', 'Punto Sur', 3),
('Patricia Gomez', 'Punto Este', 4),
('Ricardo Mendoza', 'Punto Oeste', 5);

INSERT INTO supermercado
(id_encargado, nombre, direccion)
VALUES
(1, 'Super Ahorro Norte', 'Av. Principal 123, Zona Norte'),
(2, 'Mercado Central Plus', 'Calle 45 #12-89, Centro'),
(3, 'EcoMarket Sur', 'Carrera 10 #22-15, Zona Sur');

INSERT INTO materiales
(id_supermercado, id_usuario, nombre, puntos, estado)
VALUES
(1, 1, 'Papel Reciclado', 20, 'optimo'),
(2, 2, 'Botellas Plasticas', 15, 'bueno'),
(3, 3, 'Carton Industrial', 30, 'optimo'),
(1, 4, 'Latas de Aluminio', 25, 'bueno'),
(2, 5, 'Vidrio Transparente', 10, 'falta');


INSERT INTO Horario
(id_supermercado, id_usuario, H_inicial, H_final)
VALUES
(1, 1, '08:00:00', '12:00:00'),
(2, 2, '13:00:00', '17:00:00'),
(3, 3, '09:30:00', '15:30:00');

INSERT INTO Canjes
(id_usuario, descripcion, beneficio, puntos_utilizados)
VALUES
(1, 'Canje de puntos por descuento', '10% de descuento en supermercado', 100),
(2, 'Canje por bono de compra', 'Bono de $20.000', 200),
(3, 'Canje por producto ecológico', 'Kit reutilizable', 150),
(4, 'Canje promocional mensual', 'Bolsa ecológica gratis', 50);

INSERT INTO Calificacion
(id_usuario, descripcion)
VALUES
(1, 'Excelente servicio y proceso de reciclaje muy organizado.'),
(2, 'Buena atencion, pero podria mejorar el tiempo de espera.'),
(3, 'Me gusto la iniciativa ecologica y los beneficios obtenidos.');

INSERT INTO Calificacion
(id_usuario, descripcion)
VALUES
(1, 'Excelente servicio, muy organizado y rápido.'),
(2, 'Buena atención, aunque el tiempo de espera fue un poco largo.'),
(3, 'Me gustó la iniciativa ecológica y los beneficios recibidos.');


INSERT INTO Reportes_error
(id_usuario, id_soporte_tecnico, descripcion, estado)
VALUES
(1, 1, 'No puedo acceder al sistema de reciclaje.', 'error'),
(2, 2, 'La página de canjes no carga correctamente.', 'error');

INSERT INTO soporte_tecnico (nombre, correo)
VALUES
('Sofia Martinez', 'sofia.soporte@test.com'),
('Carlos Perez', 'carlos.soporte@test.com');


DESCRIBE soporte_tecnico;

INSERT INTO soporte_tecnico (fallas, mantenimiento)
VALUES
('Problemas con login de usuarios', 'Revisión de sistema web'),
('Errores en la página de canjes', 'Actualización del servidor y base de datos');


INSERT INTO Reportes_error
(id_usuario, id_soporte_tecnico, descripcion, estado)
VALUES
(1, 1, 'No puedo iniciar sesión en el sistema', 'error'),
(2, 2, 'Problemas al canjear puntos en el portal web', 'error'),
(3, 3, 'La sección de historial de entregas no carga', 'error');

-- Rol de usuario
INSERT INTO Roles (id_usuario)
VALUES (1);

-- Rol de administrador
INSERT INTO Roles (id_administrador)
VALUES (1);

-- Rol de supermercado
INSERT INTO Roles (id_supermercado)
VALUES (1);

-- Rol de soporte técnico
INSERT INTO Roles (id_soporte_tecnico)
VALUES (1);