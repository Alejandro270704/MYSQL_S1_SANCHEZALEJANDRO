 Jovenes, adjunto el MER, recordarles lo siguiente que no sale en la imagen: 

Enums:
* Tabla Persona:
	* Tipo de documento: ('CC','CE')
* Tabla detalle_paquete:
	* paquete_servicio: ('servicio', 'producto')
* Tabla detalle_venta:
	* tipo_venta ('producto','paquete','servicio');
	* codigo hace referencia al id de lo vendido, producto, paquete o servicio.
	
Tengan presente que los enums se usan para evitar que se ingresen foraneas vacías luego el lunes veremos el uso de procedures y functions para validar con if dicho modelado.
Quedo atento a cualquier duda, recuerden llenar los datos y entender por supuesto la base de datos y el modelo de negocio planteado. 

NOTA: servicio, producto y paquete no se relacionan al venderse porque se harán internamente con el enum de detalle de venta.

Script:

drop database veterinaria;
CREATE DATABASE veterinaria;
USE veterinaria;

CREATE TABLE persona (
  id INT NOT NULL AUTO_INCREMENT,
  tipo_documento ENUM('CC', 'CE') NOT NULL,
  documento VARCHAR(45) NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  apellido VARCHAR(45) NOT NULL,
  direccion VARCHAR(150),
  correo VARCHAR(50) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (documento)
);

CREATE TABLE cliente (
  id INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES persona(id)
);

CREATE TABLE usuario (
  id INT NOT NULL AUTO_INCREMENT,
  usuario VARCHAR(45) NOT NULL,
  contrasenha VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES persona(id)
);

CREATE TABLE especialidad (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE veterinario (
  id INT NOT NULL AUTO_INCREMENT,
  tarjeta_profesional VARCHAR(45) NOT NULL,
  especialidad INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES persona(id),
  FOREIGN KEY (especialidad) REFERENCES especialidad(id)
);

CREATE TABLE tipo_animal (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE animal (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  cliente_id INT NOT NULL,
  tipo_animal_id INT NOT NULL,
  anho_nacimiento INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (tipo_animal_id) REFERENCES tipo_animal(id),
  FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE producto (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  descripcion VARCHAR(150) NOT NULL,
  precio_compra DOUBLE NOT NULL,
  stock INT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE precios_producto (
  id INT NOT NULL AUTO_INCREMENT,
  producto_id INT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  precio DOUBLE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (producto_id) REFERENCES producto(id)
);

CREATE TABLE proveedor (
  id INT NOT NULL AUTO_INCREMENT,
  nit VARCHAR(45) NOT NULL,
  razon_social VARCHAR(45) NOT NULL,
  correo VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE compra (
  id INT NOT NULL AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  proveedor_id INT NOT NULL,
  fecha_compra DATE NOT NULL,
  fecha_registro DATETIME NOT NULL,
  total DOUBLE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (proveedor_id) REFERENCES proveedor(id),
  FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

CREATE TABLE detalle_compra (
  id INT NOT NULL AUTO_INCREMENT,
  producto_id INT NOT NULL,
  cantidad INT NOT NULL,
  subtotal DOUBLE NOT NULL,
  compra_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (producto_id) REFERENCES producto(id),
  FOREIGN KEY (compra_id) REFERENCES compra(id)
);

CREATE TABLE servicio (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  precio VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE paquete (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  precio VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE detalle_paquete (
  id INT NOT NULL AUTO_INCREMENT,
  paquete_servicio ENUM('servicio','producto') NOT NULL,
  cantidad INT NOT NULL,
  subtotal DOUBLE NOT NULL,
  paquete_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (paquete_id) REFERENCES paquete(id)
);

CREATE TABLE venta (
  id INT NOT NULL AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  cliente_id INT NOT NULL,
  fecha_venta DATE NOT NULL,
  fecha_ingreso DATETIME NOT NULL,
  total VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (usuario_id) REFERENCES usuario(id),
  FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE detalle_venta (
  id INT NOT NULL AUTO_INCREMENT,
  tipo_venta ENUM('producto','paquete','servicio') NOT NULL,
  codigo INT NOT NULL,
  cantidad INT NOT NULL,
  subtotal DOUBLE NOT NULL,
  venta_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (venta_id) REFERENCES venta(id)
);

CREATE TABLE citas (
  id INT NOT NULL AUTO_INCREMENT,
  veterinario_id INT NOT NULL,
  animal_id INT NOT NULL,
  fecha_inicio DATETIME NOT NULL,
  fecha_fin DATETIME NOT NULL,
  total DOUBLE NOT NULL,
  vendedor_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (vendedor_id) REFERENCES usuario(id),
  FOREIGN KEY (veterinario_id) REFERENCES veterinario(id),
  FOREIGN KEY (animal_id) REFERENCES animal(id)
);


-- segunda parta insertar data

INSERT INTO persona (tipo_documento, documento, nombre, apellido, direccion, correo, fecha_nacimiento) VALUES
('CC','1001','Laura','Gómez','Cra 10 #20-30','laura@gmail.com','1990-04-15'),
('CE','2001','Daniel','Ruiz','Cll 5 #7-11','daniel@gmail.com','1985-06-21'),
('CC','1002','Sofía','Martínez','Cll 45 #12-80','sofia@gmail.com','1998-11-03'),
('CC','1003','Andrés','Pardo','Av Siempre Viva 123','andres@gmail.com','1992-02-19'),
('CC','1004','Juliana','Torres','Cll 9 #6-22','juliana@gmail.com','1995-09-28'),

('CC','1005','Camilo','Herrera','Cll 18 #3-22','camilo.h@gmail.com','1994-03-12'),
('CE','2002','Elena','Suárez','Av 30 #15-40','elena.suarez@gmail.com','1989-07-08'),
('CC','1006','Mateo','Quintero','Cll 8 #10-55','mateo.q@gmail.com','2000-01-20'),
('CC','1007','Valentina','Ríos','Cll 70 #22-18','valen.rios@gmail.com','1997-09-10'),
('CC','1008','Felipe','Ardila','Cll 14 #4-63','felipeardila@gmail.com','1993-12-05'),

('CE','2003','María','Beltrán','Cll 50 #6-25','maria.beltran@gmail.com','1991-04-30'),
('CC','1009','Esteban','Reyes','Cra 22 #9-70','esteban.reyes@gmail.com','1996-08-14'),
('CC','1010','Daniela','Cruz','Cll 33 #11-08','daniela.cruz@gmail.com','1999-05-27'),
('CC','1011','Jorge','Serrano','Cll 12 #3-15','jorge.serrano@gmail.com','1988-11-18'),
('CC','1012','Natalia','Pérez','Cll 99 #15-44','natalia.perez@gmail.com','1994-07-02');

INSERT INTO cliente (id) VALUES
(1),
(3),
(6),
(7),
(10);

INSERT INTO usuario (id, usuario, contrasenha) VALUES
(2,'druiz','pass123'),
(4,'apardo','qwerty'),
(5,'jtorres','julipass'),
(8,'mateoq','abc123'),
(9,'valerios','pass987'),
(11,'mbeltran','clave321'),
(12,'ereyes','est123'),
(13,'dacruz','danpass'),
(14,'jserrano','serr123'),
(15,'nperez','np1234');

INSERT INTO especialidad (nombre) VALUES
('Medicina general'),
('Ortopedia'),
('Dermatología'),
('Odontología Veterinaria');


INSERT INTO veterinario (id, tarjeta_profesional, especialidad) VALUES
(4,'TP-001',1),
(5,'TP-002',2),
(11,'TP-003',3),
(12,'TP-004',4);

INSERT INTO tipo_animal (nombre) VALUES
('Perro'),
('Gato'),
('Conejo'),
('Ave');

INSERT INTO animal (nombre, cliente_id, tipo_animal_id, anho_nacimiento) VALUES
('Max',1,1,2018),
('Luna',1,2,2020),
('Copito',3,3,2021),
('Rocky',6,1,2019),
('Michi',7,2,2022),
('Pancho',10,4,2020);

INSERT INTO producto (nombre, descripcion, precio_compra, stock) VALUES
('Concentrado Premium','Alimento para perro adulto',20000,50),
('Desparasitante Gato','Tabletas antiparasitarias',8000,100),
('Shampoo Medicado','Control dermatológico',12000,30),
('Juguete mordedor','Goma resistente',6000,80),
('Arena para gato','Arena sanitaria',9000,60);

INSERT INTO precios_producto (producto_id, nombre, precio) VALUES
(1,'Venta mostrador',30000),
(2,'Venta mostrador',12000),
(3,'Venta mostrador',20000),
(4,'Venta mostrador',10000),
(5,'Venta mostrador',14000);

INSERT INTO proveedor (nit, razon_social, correo) VALUES
('900111222','PetFoods SA','ventas@petfoods.com'),
('900222333','VetSupply SAS','contacto@vetsupply.com');

INSERT INTO compra (usuario_id, proveedor_id, fecha_compra, fecha_registro, total) VALUES
(2,1,'2025-01-15','2025-01-15 10:30:00',600000),
(2,2,'2025-01-18','2025-01-18 11:00:00',350000);

INSERT INTO detalle_compra (producto_id, cantidad, subtotal, compra_id) VALUES
(1,20,400000,1),
(3,8,160000,1),
(2,10,120000,2),
(5,15,210000,2);

INSERT INTO servicio (nombre, precio) VALUES
('Consulta general','35000'),
('Vacunación','45000'),
('Baño medicado','30000'),
('Limpieza dental','55000');

INSERT INTO paquete (nombre, precio) VALUES
('Paquete Cachorro','90000'),
('Paquete Gato Premium','110000'),
('Paquete Salud Total','150000');

INSERT INTO detalle_paquete (paquete_servicio, cantidad, subtotal, paquete_id) VALUES
('servicio',1,35000,1),
('producto',1,30000,1),

('servicio',1,45000,2),
('producto',1,20000,2),

('servicio',1,35000,3),
('servicio',1,30000,3),
('producto',1,14000,3);

INSERT INTO venta (usuario_id, cliente_id, fecha_venta, fecha_ingreso, total) VALUES
(2,1,'2025-01-20','2025-01-20 09:00:00','65000'),
(4,3,'2025-01-22','2025-01-22 14:30:00','140000'),
(8,6,'2025-01-25','2025-01-25 11:15:00','30000'),
(9,10,'2025-01-28','2025-01-28 10:45:00','150000');

INSERT INTO detalle_venta (tipo_venta, codigo, cantidad, subtotal, venta_id) VALUES
('producto',1,1,30000,1),
('servicio',1,1,35000,1),

('paquete',2,1,110000,2),
('servicio',2,1,30000,2),

('producto',4,1,10000,3),
('servicio',3,1,20000,3),

('paquete',3,1,150000,4);

INSERT INTO citas (veterinario_id, animal_id, fecha_inicio, fecha_fin, total, vendedor_id) VALUES
(4,1,'2025-01-10 09:00:00','2025-01-10 09:30:00',35000,2),
(5,2,'2025-01-11 10:00:00','2025-01-11 10:45:00',45000,4),
(11,4,'2025-01-15 13:00:00','2025-01-15 13:40:00',30000,8),
(12,6,'2025-01-18 08:30:00','2025-01-18 09:20:00',55000,9);