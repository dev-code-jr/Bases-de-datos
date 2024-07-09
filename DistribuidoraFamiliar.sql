Drop database if exists DistribuidoraFamiliar;
Create database DistribuidoraFamiliar;

Use DistribuidoraFamiliar;

Create table Clientes(
	codigoCliente int not null auto_increment,
    nombreCliente varchar(50) not null,
    apellidoCliente varchar(50) not null,
    direccionCliente varchar(256) not null,
    telefonoCliente varchar(10) not null,
    emailCliente varchar(100),
    primary key PK_codigoCliente (codigoCliente)
);

Create table Empleados(
	codigoEmpleado int not null,
    nombreEmpleado varchar(50) not null,
    apellidoEmpleado varchar(50) not null,
    direccionEmpleado varchar(256) not null,
    telefono varchar(10) not null,
    emailEmpleado varchar(100) not null,
    fechaDeNacimiento date not null,
    edad int,
    fechaDeContratacion date not null,
    salario decimal(10,2) not null, 
    cargo varchar(50) not null,
    primary key PK_codigoEmpleado (codigoEmpleado)
);

Create table Marcas(
	codigoMarca int not null,
    nombreMarca varchar(60) not null,
    descripcionMarca varchar(256) not null,
    primary key PK_codigoMarca (codigoMarca)
);

Create table Categorias(
	codigoCategoria int not null,
    nombreCategoria varchar(60) not null,
    descripcionCategoria varchar(256) not null,
    primary key PK_codigoCategoria (codigoCategoria)
);

Create table Tallas(
	codigoTalla int not null auto_increment,
    nombreTalla varchar(50) not null,
    primary key PK_codigoTalla (codigoTalla)
);

Create table Productos(
	codigoProducto int not null,
    nombreProducto varchar(60) not null,
    descripcion varchar(256) not null,
    precio decimal(10,2) not null,
    codigoMarca int not null,
    codigoCategoria int not null,
    primary key PK_codigoProducto (codigoProducto),
    constraint FK_Productos_Marcas foreign key (codigoMarca)
		references Marcas (codigoMarca),
	constraint FK_Productos_Categorias foreign key (codigoCategoria)
		references Categorias (codigoCategoria)
);

Create table Inventario(
	codigoInventario int not null,
    cantidad int not null, 
    codigoTalla int not null,
    codigoProducto int not null,
	primary key PK_codigoInventario (codigoInventario),
    constraint FK_Inventario_Tallas foreign key (codigoTalla)
		references Tallas (codigoTalla),
	constraint FK_Inventario_Productos foreign key (codigoProducto)
		references Productos (codigoProducto)
);

Create table Ventas(
	codigoVenta int not null,
    fechaVenta datetime not null,
    totalVenta decimal(10,2) not null,
    codigoCliente int not null,
    codigoEmpleado int not null,
    primary key PK_codigoVenta (codigoVenta),
    constraint FK_Ventas_Clientes foreign key (codigoCliente)
		references Clientes (codigoCliente),
	constraint FK_Ventas_Empleados foreign key (codigoEmpleado)
		references Empleados (codigoEmpleado)
);

/* Procedimientos almacenos de la entidad Clientes */
Delimiter $$
	Create procedure sp_AgregarCliente ( in nombreCliente varchar(50),
										 in apellidoCliente varchar(50),
                                         in direccionCliente varchar(256),
                                         in telefonoCliente varchar(10))
		Begin
			Insert into Clientes (nombreCliente, apellidoCliente, direccionCliente, telefonoCliente)
				values(nombreCliente, apellidoCliente, direccionCliente, telefonoCliente);
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_ListarClientes ()
		Begin
			Select
				C.codigoCliente,
                C.nombreCliente,
                C.apellidoCliente,
                C.direccionCliente,
                C.telefonoCliente, 
                C.emailCliente
                from Clientes C;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_BuscarCliente ( in codCliente int)
		Begin
			Select
				C.codigoCliente,
                C.nombreCliente,
                C.apellidoCliente,
                C.direccionCliente,
                C.telefonoCliente, 
                C.emailCliente
                from Clientes C
                where C.idCliente = codCliente;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EditarCliente ( in codCliente int,
										in nomCliente varchar(50),
                                        in apeCliente varchar(50),
                                        in direccCliente varchar(256),
                                        in telCliente varchar(10),
                                        in correo varchar(100))
		Begin
			Update Clientes C
				set C.nombreCliente = nomCliente,
					C.apellidoCliente = apeCliente,
                    C.direccionCliente = direccCliente,
                    C.telefonoCliente = telCliente,
                    C.email = correo
                    where C.codigoCliente = codCliente;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EliminarCliente ( in codCliente int)
		Begin
			Delete from Clientes
				where Clientes.codigoCliente = codCliente;
        End$$
Delimiter ;

/* Procedimientos almacenados de la entidad Empleados */

Delimiter $$
	Create procedure sp_AgregarEmpleado ( in codigoEmpleado int,
										  in nombreEmpleado varchar(50),
                                          in apellidoEmpleado varchar(50),
                                          in direccionEmpleado varchar(256),
                                          in telefono varchar(20),
                                          in emailEmpleado varchar(100),
                                          in fechaDeNacimiento date,
                                          in fechaDeContratacion date,
                                          in salario decimal(10,2),
                                          in cargo varchar(50))
		Begin
			Insert into Empleados
				(codigoEmpleado, nombreEmpleado, apellidoEmpleado, direccionEmpleado, telefono, 
                 emailEmpleado, fechaDeNacimiento, fechaDeContratacion,salario, cargo)
					values(codigoEmpleado, nombreEmpleado, apellidoEmpleado, direccionEmpleado, telefono, 
                 emailEmpleado, fechaDeNacimiento, fechaDeContratacion,salario, cargo);
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_ListarEmpleados ()
		Begin
			Select
				E.codigoEmpleado,
				E.nombreEmpleado,
				E.apellidoEmpleado,
				E.direccionEmpleado,
				E.telefono,
				E.emailEmpleado,
				E.fechaDeNacimiento,
				E.edad,
				E.fechaDeContratacion,
				E.salario,
				E.cargo
                from Empleados E;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_BuscarEmpleado ( in codEmpleado int)
		Begin
			Select
				E.codigoEmpleado,
				E.nombreEmpleado,
				E.apellidoEmpleado,
				E.direccionEmpleado,
				E.telefono,
				E.emailEmpleado,
				E.fechaDeNacimiento,
				E.edad,
				E.fechaDeContratacion,
				E.salario,
				E.cargo
                from Empleados E
                where E.codigoEmpleado = codEmpleado;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EditarEmpleado ( in codEmpleado int,
										 in nomEmpleado varchar(50),
										 in apeEmpleado varchar(50),
										 in direccEmpleado varchar(256),
										 in tel varchar(20),
										 in correoEmpleado varchar(100),
										 in fechDeNacimiento date,
										 in fechDeContratacion date,
										 in sal decimal(10,2),
										 in carg varchar(50))
		Begin
			Update Empleados E
				set E.nombreEmpleado = nomEmpleado,
					E.apellidoEmpleado = apeEmpleado,
                    E.direccionEmpleado = direccEmpleado,
                    E.telefono = tel,
                    E.emailEmpleado = correoEmpleado,
                    E.fechaDeNacimiento = fechDeNacimiento,
                    E.fechaDeContratacion = fechDeContratacion,
                    E.salario = sal,
                    E.cargo = carg
                    where E.codigoEmpleado = codEmpleado;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EliminarEmpleado ( in codEmpleado int)
		Begin
			Delete from Empleados 
				where Empleados.codigoEmpleado = codEmpleado;
        End$$
Delimiter ;

/* Procedimientos almacenados de la entidad Marcas */

Delimiter $$
	Create procedure sp_AgregarMarca ( in codigoMarca int,
									   in nombreMarca varchar(60),
                                       in descripcionMarca varchar(256))
		Begin
			Insert into Marcas (codigoMarca, nombreMarca, descripcionMarca)
				values(codigoMarca, nombreMarca, descripcionMarca);
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_ListarMarcas ()
		Begin
			Select 
				M.codigoMarca,
                M.nombreMarca,
                M.descripcionMarca
                from Marcas M;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_BuscarMarca ( in codMarca int)
		Begin
			Select 
				M.codigoMarca,
                M.nombreMarca,
                M.descripcionMarca
                from Marcas M
                where M.codigoMarca = codMarca;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EditarMarca ( in codMarca int,
									  in nomMarca varchar(60),
                                      in descrMarca varchar(256))
		Begin
			Update Marcas M
				set M.nombreMarca = nomMarca,
					M.descripcionMarca = descrMarca
					where M.codigoMarca = codMarca;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EliminarMarca ( in codMarca int)
		Begin
			Delete from Marcas 
				where Marcas.codigoMarca = codMarca;
        End$$
Delimiter ;

/* Procedimientos almacenados de la entidad Categorias */

Delimiter $$
	Create procedure sp_AgregarCategoria ( in codigoCategoria int,
										   in nombreCategoria varchar(60),
                                           in descripcionCategoria varchar(256))
		Begin
			Insert into Categorias (codigoCategoria, nombreCategoria, descripcionCategoria)
				values(codigoCategoria, nombreCategoria, descripcionCategoria);
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_ListarCategorias ()
		Begin
			Select 
				C.codigoCategoria, 
                C.nombreCategoria, 
                C.descripcionCategoria
                from Categorias C;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_BuscarCategoria ( in codCategoria int)
		Begin
			Select 
				C.codigoCategoria, 
                C.nombreCategoria, 
                C.descripcionCategoria
                from Categorias C
                where C.codigoCategoria = codCategoria;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EditarCategoria ( in codCategoria int,
										  in nomCategoria varchar(60),
                                          in descrCategoria varchar(256))
		Begin
			Update Categorias C
				set C.nombreCategoria = nomCategoria,
					C.descripcionCategoria = descrCategoria
                    where C.codigoCategoria = codCategoria;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EliminarCategoria ( in codCategoria int)
		Begin
			Delete from Categorias
				where Categorias.codigoCategoria = codCategoria;
        End$$
Delimiter ;

/* Procedimientos almacenados de la entidad Tallas */

Delimiter $$
	Create procedure sp_AgregarTalla ( in codigoTalla int, in nombreTalla varchar(50))
		Begin
			Insert into Tallas (codigoTalla, nombreTalla)
				values(codigoaTalla, nombreTalla);
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_ListarTallas ()
		Begin
			Select
				T.codigoTalla, 
                T.nombreTalla
                from Tallas T;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_BuscarTalla ( in codTalla int)
		Begin
			Select
				T.codigoTalla, 
                T.nombreTalla
                from Tallas T
                where T.codigoTalla = codTalla;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EditarTalla ( in codTalla int, in nomTalla varchar(50))
		Begin
			Update Tallas T
				set T.nombreTalla = nomTalla
                where T.codigoTalla = codTalla;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EliminarTalla ( in codTalla int)
		Begin
			Delete from Tallas
				where Tallas.codigoTalla = codTalla;
        End$$
Delimiter ;

/* Procedimientos almacenados de la entidad Productos */

Delimiter $$
	Create procedure sp_AgregarProducto ( in codigoProducto int,
										  in nombreProducto varchar(60),
                                          in descripcion varchar(256),
                                          in precio decimal(10,2),
                                          in codigoMarca int,
                                          in codigoCategoria int)
		Begin
			Insert into Productos (codigoProducto, nombreProducto, descripcion, precio, codigoMarca, codigoCategoria)
				values(codigoProducto, nombreProducto, descripcion, precio, codigoMarca, codigoCategoria);
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_ListarProductos ()
		Begin
			Select
				P.codigoProducto, 
                P.nombreProducto, 
                P.descripcion, 
                P.precio, 
                P.codigoMarca, 
                P.codigoCategoria
				from Productos P;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_BuscarProducto ( in codProducto int)
		Begin
			Select
				P.codigoProducto, 
                P.nombreProducto, 
                P.descripcion, 
                P.precio, 
                P.codigoMarca, 
                P.codigoCategoria
				from Productos P
                where P.codigoProducto = codProducto;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EditarProducto ( in codProducto int, 
										 in nomProducto varchar(60), 
                                         in descr varchar(256), 
                                         in prec decimal(10,2))
		Begin
			Update Productos P
				set P.nombreProducto = nomProducto,
					P.descripcion = descr,
                    P.precio = precio
                    where P.codigoProducto = codProducto;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EliminarProducto ( in codProducto int)
		Begin
			Delete from Productos
				where Productos.codigoProducto = codProducto;
        End$$
Delimiter ;

/* Procedimientos almacenados de la entidad Inventario */

Delimiter $$
	Create procedure sp_AgregarInventario ( in codigoInventario int,
											in cantidad int,
                                            in codigoTalla int,
                                            in codigoProducto int)
		Begin
			Insert into Inventario (codigoInventario, cantidad, codigoTalla, codigoProducto)
				values(codigoInventario, cantidad, codigoTalla, codigoProducto);
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_ListarInventario ()
		Begin
			Select
				I.codigoInventario, 
                I.cantidad, 
                I.codigoTalla, 
                I.codigoProducto
                from Inventario I;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_BuscarInventario ( in codInventario int)
		Begin
			Select
				I.codigoInventario, 
                I.cantidad, 
                I.codigoTalla, 
                I.codigoProducto
                from Inventario I
                where I.codigoInventario = codInventario;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EditarInventario ( in codInventario int, 
										   in cant int)
		Begin
			Update Inventario I
				set I.cantidad = cant
                where I.codigoInventario = codInventario;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EliminarInventario ( in codInventario int)
		Begin
			Delete from Inventario 
				where Inventario.codigoInventario = codInventario;
        End$$
Delimiter ;