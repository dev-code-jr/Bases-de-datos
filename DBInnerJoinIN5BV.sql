-- Edwar René Chamalé Gonzaléz
-- Quinto perito en computación, "B" - Jornada vespertina
-- Número de carnet: 2022222 

drop database if exists DBInnerJoinIN5BV;
Create database DBInnerJoinIN5BV;

use DBInnerJoinIN5BV;

Create table Clientes(
	codigoCliente int not null auto_increment,
    nombreCliente varchar(60) not null,
    telefonoContacto varchar(8) not null,
    primary key PK_codigoCliente (codigoCliente)
);

Create table Pedidos(
	codigoPedido int not null,
    numeroFactura int not null,
    codigoCliente int not null,
    primary key PK_codigoPedido (codigoPedido),
    constraint FK_Pedidos_Clientes foreign key(codigoCliente)
		references Clientes(codigoCliente)
);

Insert into Clientes(nombreCliente, telefonoContacto)
	values('Edwar Chamale', '26781262');
Insert into Clientes(nombreCliente, telefonoContacto)
	values('Jose Rosales', '95713612');
Insert into Clientes(nombreCliente, telefonoContacto)
	values('Mario Montufar', '12623753');
Insert into Clientes(nombreCliente, telefonoContacto)
	values('Ana Gonzalez', '78524641');    
    
select * from Clientes;

Insert into Pedidos(codigoPedido, numeroFactura, codigoCliente)
	values(106, 185, 3);
Insert into Pedidos(codigoPedido, numeroFactura, codigoCliente)
	values(107, 42, 4);
Insert into Pedidos(codigoPedido, numeroFactura, codigoCliente)
	values(108, 62, 3);
Insert into Pedidos(codigoPedido, numeroFactura, codigoCliente)
	values(109, 63, 2);
/*Insert into Pedidos(codigoPedido, numeroFactura, codigoCliente)
	values(110, 70, 1);*/
    
select * from Pedidos;

-- ------------------------------INNER JOIN------------------------------
Select * from Clientes C INNER JOIN Pedidos P
	on C.codigoCliente = P.codigoCliente;
-- ------------------------------INNER JOIN------------------------------
Select Clientes.nombreCliente, Pedidos.codigoPedido 
	from Clientes INNER JOIN Pedidos
		on Clientes.codigoCliente = Pedidos.codigoCliente;
-- ------------------------------LEFT JOIN------------------------------
Select * from Clientes LEFT JOIN Pedidos 
	on Clientes.codigoCliente = Pedidos.codigoCliente;
-- ------------------------------LEFT JOIN------------------------------
Select Clientes.nombreCliente, Pedidos.codigoPedido
	from Clientes LEFT JOIN Pedidos
		on Clientes.codigoCliente = Pedidos.codigoCliente;
-- ------------------------------RIGHT JOIN------------------------------
Select * from Clientes RIGHT JOIN Pedidos
	on Clientes.codigoCliente = Pedidos.codigoCliente;
-- ------------------------------RIGHT JOIN------------------------------
Select Clientes.nombreCliente, Pedidos.codigoCliente
	from Clientes RIGHT JOIN Pedidos
		on Clientes.codigoCliente = Pedidos.codigoCliente;
-- ------------------------------OUTER JOIN------------------------------
-- Si no se puede usar la palabra full se hace una union
Select * from Clientes FULL JOIN Pedidos
	on Clientes.codigoCliente = Pedidos.codigoCliente;

Select * from Clientes LEFT JOIN Pedidos 
	on Clientes.codigoCliente = Pedidos.codigoCliente

UNION
    
Select * from Clientes RIGHT JOIN Pedidos
	on Clientes.codigoCliente = Pedidos.codigoCliente;
    
Select Clientes.nombreCliente, Pedidos.codigoPedido from Clientes, Pedidos;

-- 
