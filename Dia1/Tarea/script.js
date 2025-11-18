
// tabla de persona
create table persona (
    id int not null primary key auto_increment,
    tipo_documento enum('cedula', 'pasaporte', 'tarjeta de identidad')not null, documento varchar(50) not null, nombre varchar(50) not null,
    apellido varchar(50) not null,
    ciudad varchar(50) not null);
// tabla de cliente 
create table cliente (
    id int not null primary key auto_increment,
    gana_puntos int not null,
    foreign key(id) references persona(id));
// tabla vendedor 
create table vendedor (
    id int not null primary key auto_increment,
    usuario varchar(50),
    contrasena varchar(50),
    rol enum('administrador','vendedor','cajero')
    foreign key(id) references persona(id)
);
//tabla marca
create table marca(
    id int not null primary key auto_increment,
    nombre varchar(50));
// tabla categoria
create table categoria(
    id int not null primary key auto_increment,
    nombre varchar(50));
// tabla producto
create table producto(
    id int not null primary key auto_increment,
    nombre varchar(50),
    descripcion varchar(100),
    marca_fk int not null,
    categoria_fk int not null,
    precio_compra int,
    precio_venta int,
    foreign key (marca_fk) references marca(id),
    foreign key (categoria_fk) references categoria(id),
);
// tabla venta 
create table venta(
    id int not null primary key auto_increment,
    cliente_id int not null,
    vendedor_id int not null,
    fecha datatime not null,
    total int not null
    forign key (cliente_id) references cliente(id),
    forign key (vendedor_id) references vendedor(id)
);
// tabla detalle venta 
create table venta detalleventa(
    id int not null primary key auto_increment,
    venta_fk int not null,
    foreign key(venta_fk) references ventas(id)
);