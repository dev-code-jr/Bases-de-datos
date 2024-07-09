Drop database if exists DBJavaEEVentas2022222;
Create database DBJavaEEVentas2022222;

use DBJavaEEVentas2022222;

Create table Cliente(
	codigoCliente int not null auto_increment,
    DPICliente varchar(15) not null,
    nombresCliente varchar(200) not null,
    direccionCliente varchar(150) not null,
    estado varchar(1) not null,
    primary key PK_codigoCliente (codigoCliente)
);

Create table Empleado(
	codigoEmpleado int not null auto_increment,
    DPIEmpleado varchar(15) not null,
    nombresEmpleado varchar(200) not null,
    telefonoEmpleado varchar(8) not null,
    estado varchar(1) not null,
    usuario varchar(20) not null,
	primary key PK_codigoEmpleado(codigoEmpleado)
);

Create table Producto(
	codigoProducto int not null auto_increment,
    nombreProducto varchar(200) not null,
    precio double not null,
    stock int not null,
    estado varchar(1),
    primary key PK_codigoProducto(codigoProducto)
);

Create table Venta(
	codigoVenta int not null auto_increment,
    numeroSerie varchar(55) not null,
    fechaVenta date not null,
    monto double not null,
    estado varchar(1) not null,
    codigoCliente int not null,
    codigoEmpleado int not null,
    primary key PK_codigoVenta(codigoVenta),
    constraint FK_Venta_Cliente foreign key (codigoCliente) 
		references Cliente (codigoCliente),
	constraint FK_Venta_Empleado foreign key (codigoEmpleado)
		references Empleado(codigoEmpleado)
);

Create table DetalleVenta(
	codigoDetalleVenta int not null auto_increment,
    codigoProducto int not null,
    cantidad int not null,
    precioVenta double not null,
    codigoVenta int not null,
	primary key PK_codigoDetalleVenta (codigoDetalleVenta),
    constraint FK_DetalleVenta_Producto foreign key (codigoProducto)
		references Producto (codigoProducto),
	constraint FK_DetalleVenta_Venta foreign key (codigoVenta)
		references Venta(codigoVenta)
);

Create table CarritoCompra(
	codigoCarrito int auto_increment not null,
    item int not null,
    codigoProducto int not null,
    descripcionProducto varchar(150) not null,
    precioProducto double not null,
    cantidad int not null,
    stock int not null,
    estado varchar(1) not null,
    subTotal double not null,
    primary key PK_codigoCarrito (codigoCarrito)
);


insert into Cliente (DPICliente, nombresCliente, direccionCliente, estado) 
	values ('1579420230101', 'Pedro Armas', 'Mixco, Guatemala', '1');
insert into Cliente (DPICliente, nombresCliente, direccionCliente, estado) 
	values ('1579123450108', 'Luis Olmedo', 'Guatemala, Guatemala', '1');
insert into Cliente (DPICliente, nombresCliente, direccionCliente, estado) 
	values ('1579987450102', 'Jorge Tala', 'Sacatepequez, Guatemala', '1');
insert into Cliente (DPICliente, nombresCliente, direccionCliente, estado) 
	values ('1579257410107', 'Mario Rodriguez', 'Villa Nueva, Guatemala', '1');

insert into Empleado (DPIEmpleado, nombresEmpleado, telefonoEmpleado, estado, usuario) 
	values ('123', 'Edwar René Chamalé González', '58152768','1', 'echamale-2022222');
insert into Empleado (DPIEmpleado, nombresEmpleado, telefonoEmpleado, estado, usuario) 
	values ('123', 'José Rodrigo Chanquin Linux', '43210509','1', 'jchanquin-2022240');
insert into Empleado (DPIEmpleado, nombresEmpleado, telefonoEmpleado, estado, usuario) 
	values ('1579558740106', 'Palermo Suarez', '24587963','1', 'psuarez25');
insert into Empleado (DPIEmpleado, nombresEmpleado, telefonoEmpleado, estado, usuario) 
	values ('1579663520108', 'Luisa Aragon', '36251478','1', 'laragon40');

insert into Producto (nombreProducto, precio, stock, estado) 
	values('Teclado Durabrand', 105.00,25,'1');
insert into Producto (nombreProducto, precio, stock, estado) 
	values('Mouse inhalambrico Microfost', 74.50,15,'1');
insert into Producto (nombreProducto, precio, stock, estado) 
	values('Laptop Acer Nitro 5', 9850.00,5,'1');
insert into Producto (nombreProducto, precio, stock, estado) 
	values('Monitor Haier 32"', 1225.80,60,'1');

insert into Venta (numeroSerie, fechaVenta, monto, estado, codigoCliente, codigoEmpleado) 
	values('0000012', now(), 20.00, 1, 1, 2);

Select * from Cliente;

select * from Producto;

Select * from Empleado;
Select * from Venta;
select * from DetalleVenta;

Select * from Empleado where usuario = 'echamale-2022222' and DPIEmpleado = '123';

