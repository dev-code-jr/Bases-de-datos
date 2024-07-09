-- DDL (Data Definition Language)

Create database CocaPepsi;

use CocaPepsi;

Create table Proveedores(
	codigoProveedor int not null auto_increment,
    nombreProveedor varchar(50) not null,
    direccionProveedor varchar (50) not null,
    primary key (codigoProveedor)
);

Create table Clientes(
	DPI bigint(13) not null,
    nombresCliente varchar(50) not null,
    apellidosCliente varchar(50) not null,
    telefono int not null,
    direccion varchar(50) not null,
    primary key (DPI)
);

Create table Productos(
	codigoProducto int not null auto_increment,
    nombreProducto varchar(50) not null,
    idProveedor_fk int not null,
    costo real (10,2) not null,
    precio real (10,2) not null,
    primary key (codigoProducto),
    foreign key (idProveedor_fk) references Proveedores (codigoProveedor)
);

Create table DetalleFactura(
	idDFactura int not null auto_increment,
	dpiCliente_fk bigint(13) not null,
    idProducto_fk int not null,
    primary key (idDFactura),
    foreign key (dpiCliente_fk) REFERENCES Clientes(dpi),
    FOREIGN KEY (idProducto_fk) REFERENCES Productos(codigoProducto)
);

Create table Facturas(
	idFactura INT AUTO_INCREMENT NOT NULL,
    idDFactura_fk INT NOT NULL,
    totalCompra DECIMAL (5,2),
    PRIMARY KEY (idFactura),
    FOREIGN KEY (idDFactura_fk) REFERENCES DetalleFactura(idDFactura)
);

-- DML (Data Manipulation Language)

Insert into Proveedores (nombreProveedor, direccionProveedor)
	values('EMBOTELLADORA LA MARIPOSA, S.A.', '43 C 1-20 Z-12 COL MONTE MARIA I');
Insert into Proveedores (nombreProveedor, direccionProveedor)
	values('CERVECERIA CENTRO AMERICANA', '3 Av Final Z-2 Finca el Zapote');
Insert into Proveedores (nombreProveedor, direccionProveedor)
	values('DEPOSITO Y ABARROTERIA KARIN', '14 C B 2-49 Z-3');
Insert into Proveedores (nombreProveedor, direccionProveedor)
	values('AVANCEL', '5 Av A 13-58 Z-9 Edif Pflorencia Nv 4 No 402');
Insert into Proveedores (nombreProveedor, direccionProveedor)
	values('GUGAR S.A', '24 C 0-30 Z-4');
      
Insert into Clientes(dpi, nombresCliente, apellidosCliente, telefono, direccion)
	values(7915612310101, 'Jose Eduardo', 'Juarez Espinoza', 78916483, '20 Av 17-36 Zona 18 Alameda , Alameda');
Insert into Clientes(dpi, nombresCliente, apellidosCliente, telefono, direccion)
	values(2963182820101, 'Miguel Fernando', 'Lopez Lopez', 16234365, '4 Av 1-87 Z-1 Mix Col Lport');
Insert into Clientes(dpi, nombresCliente, apellidosCliente, telefono, direccion)
	values(1192090990101, 'Victor Josue', 'Alvaro Hernandez', 89246418, 'Km 14.5 Carr A El Salvador Queen Plaza Of 9 Y 10');
Insert into Clientes(dpi, nombresCliente, apellidosCliente, telefono, direccion)
	values(1326458960101, 'Ana Elizabeth', 'Gonzalez Estrada', 93170746, '20 Avenida 11-84 Zona 15 Vista Hermosa Iii');
Insert into Clientes(dpi, nombresCliente, apellidosCliente, telefono, direccion)
	values(7891198160101, 'Stephany Maria', 'Estrada Gonzalez', 17462422, '9 Av A 1-70 Z-17 Col Lourdes');
      
Insert into Productos(nombreProducto, idProveedor_fk, costo, precio)
	values('Té lipton', 3, 180.01, 18.50);
Insert into Productos(nombreProducto, idProveedor_fk, costo, precio)
	values('Cerveza gallo', 2, 250.46, 22.63);
Insert into Productos(nombreProducto, idProveedor_fk, costo, precio)
	values('Coca-Cola ', 1, 220.89, 21.00);
Insert into Productos(nombreProducto, idProveedor_fk, costo, precio)
	values('Pepsi lite', 5, 130.33, 16.23);
Insert into Productos(nombreProducto, idProveedor_fk, costo, precio)
	values('Powerade', 4, 95.64, 11.50);
      
Insert into DetalleFactura(dpiCliente_fk, idProducto_fk)
	values(7891198160101, 2);
Insert into DetalleFactura(dpiCliente_fk, idProducto_fk)
	values(1326458960101, 3);
Insert into DetalleFactura(dpiCliente_fk, idProducto_fk)
	values(1192090990101, 5);
Insert into DetalleFactura(dpiCliente_fk, idProducto_fk)
	values(2963182820101, 1);
Insert into DetalleFactura(dpiCliente_fk, idProducto_fk)
	values(7915612310101, 4);
      
Insert into Facturas(idDFactura_fk, totalCompra)
	values(3, 11.50);
Insert into Facturas(idDFactura_fk, totalCompra)
	values(1, 22.63);
Insert into Facturas(idDFactura_fk, totalCompra)
	values(5, 16.23);
Insert into Facturas(idDFactura_fk, totalCompra)
	values(2, 21.00);
Insert into Facturas(idDFactura_fk, totalCompra)
	values(4, 18.50);
      
      
