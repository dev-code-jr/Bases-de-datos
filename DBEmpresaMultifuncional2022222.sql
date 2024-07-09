/*Edwar René Chamalé González
Quinto perito en computación (Informatica) IN5BV
Jornada: Vespertina
Fecha: 10/02/2023 Hora inicio: 14:07:00 
*/
Drop database if exists DBEmpresaMultifuncional20222222;
Create database DBEmpresaMultifuncional20222222;

Use DBEmpresaMultifuncional20222222;

Create table Categorias(
	categoriaID int not null,
    nombreCategoria varchar(45) not null,
    sueldoBase decimal(6,2) not null,
    bonificacion decimal(6,2) not null,
	bonificacionEmpresa decimal(6,2) not null,
    tipoCategoria varchar(20) not null,
    primary key PK_codigoCategoriaID (categoriaID)
);

Create table Regiones(
	regionID int not null,
    nombreRegion varchar(20) not null,
    primary key PK_regionID (regionID)
);

Create table Departamentos(
	departamentoID int not null,
    departamento varchar(20) not null,
    regionID int not null,
    primary key PK_departamentoID (departamentoID),
	constraint FK_Departamentos_Regiones foreign key (regionID)
		references Regiones (regionID)
);

Create table Oficinas(
	oficinaID int not null,
    direccion varchar(256) not null,
    departamentoID int not null,
    primary key PK_oficinaID (oficinaID),
    constraint FK_Oficinas_Departamentos foreign key (departamentoID)
		references Departamentos (departamentoID)
);

Create table Telefonos(
	telefonoID int not null,
    numeroTelefono varchar(10) not null,
    oficinaID int not null,
    primary key PK_telefonoId (telefonoID),
	constraint FK_Telefonos_Oficinas foreign key (oficinaID)
		references Oficinas (oficinaID)
);

Create table Secciones(
	seccionID int not null,
    nombreSeccion varchar(50) not null,
    oficinaID int not null,
    primary key PK_seccionID (seccionID),
	constraint FK_Secciones_Oficinas foreign key (oficinaID)
		references Oficinas (oficinaID)
);

Create table Empleados(
	empleadoID int not null,
    nombre varchar(45) not null,
    fechaDeNacimiento date not null,
    edad int,
    telefonoPersonal varchar(10) not null,
    fechaDeContratacion date not null,
    categoriaID int not null,
    seccionID int not null,
    primary key PK_empleadoID (empleadoID),
    constraint FK_Empleados_Categorias foreign key (categoriaID)
		references Categorias (categoriaID),
	constraint FK_Empleados_Secciones foreign key (seccionID)
		references Secciones (seccionID)
);

-- ----- CRUD - Create - Read - Update - Delete -----
-- ----- Procedimientos almacenados de Categorias -----
-- ----- Agregar Categoria -----

Delimiter $$
	Create procedure sp_AgregarCategoria ( in catID int,
										   in nomCategoria varchar(45),
                                           in suBase decimal(6,2),
                                           in bon decimal(6,2),
                                           in bonEmpresa decimal(6,2),
                                           in tipCategoria varchar(20))
		Begin
			Insert into Categorias (categoriaID, 
								    nombreCategoria, 
                                    sueldoBase, 
                                    bonificacion, 
                                    bonificacionEmpresa, 
                                    tipoCategoria)
				values(catID, nomCategoria, suBase, bon, bonEmpresa, tipCategoria);
						
        End$$
Delimiter ;

call sp_AgregarCategoria(4041,'Conserje',2000.09,250.00, 50.00,'Administrativo');
call sp_AgregarCategoria(4042,'Secretaria', 8296.77,250.00, 300.00,'Administrativo');
call sp_AgregarCategoria(4043,'Vendedor', 8007.76,250.00, 200.00,'Comercial');
call sp_AgregarCategoria(4044,'Jefe de sección', 8206.29,250.00, 600.00,'Administrativo');
call sp_AgregarCategoria(4045,'Recepcionista', 4092.33,250.00, 500.00,'Administrativo');
call sp_AgregarCategoria(4046,'Contador', 9499.12,250.00, 350.00,'Administrativo');
call sp_AgregarCategoria(4047,'Técnico', 5978.87,250.00, 300.00,'Administrativo');
call sp_AgregarCategoria(4048,'Director', 4157.39,250.00, 750.00,'Administrativo');
call sp_AgregarCategoria(4049,'Recepcionista', 6474.35,250.00,300.00,'Administrativo');
call sp_AgregarCategoria(4050,'Auditor', 3654.16,250.00, 600.00,'Administrativo');
call sp_AgregarCategoria(4051,'Programador', 6259.51,250.00, 600.00,'Administrativo');
call sp_AgregarCategoria(4052,'Mecánico', 7549.52,250.00, 1200.00,'Administrativo');
call sp_AgregarCategoria(4053,'Diseñador', 7807.12,250.00, 700.00,'Administrativo');
call sp_AgregarCategoria(4054,'Policía', 2500.7,250.00, 50.00,'Administrativo');
call sp_AgregarCategoria(4055,'Auxiliar', 5207.79,250.00, 500.00,'Administrativo');

-- ----- Listar Categorias -----

Delimiter $$
	Create procedure sp_ListarCategorias ()
		Begin
			Select 
				C.categoriaID,
                C.nombreCategoria,
                C.sueldoBase, 
                C.bonificacion,
                C.bonificacionEmpresa,
                C.tipoCategoria
				from Categorias C;
			
        End$$
Delimiter ;

call sp_ListarCategorias();

-- ----- Buscar Categoria -----

Delimiter $$
	Create procedure sp_BuscarCategoria ( in catID int)
		Begin
			Select
				C.categoriaID,
                C.nombreCategoria,
                C.sueldoBase,
                C.bonificacion,
                C.bonificacionEmpresa,
                C.tipoCategoria
                from Categorias C
					where C.categoriaID = catID;
                
        End$$
Delimiter ;

call sp_BuscarCategoria(4054);

-- ----- Editar Categoria -----

Delimiter $$
	Create procedure sp_EditarCategoria ( in catID int,
										  in nomCategoria varchar(45),
                                          in suBase decimal(6,2),
                                          in bon decimal(6,2),
                                          in bonEmpresa decimal(6,2),
                                          in tipCategoria varchar(20))
		Begin
			Update Categorias C
				set C.nombreCategoria = nomCategoria,
					C.sueldoBase = suBase,
                    C.bonificacion = bon,
                    C.bonificacionEmpresa = bonEmpresa,
                    C.tipoCategoria = tipCategoria
						where C.categoriaID = catID;
        End$$
Delimiter ;

call sp_EditarCategoria(4054, 'Policia de transito', 2400.2, 250.00, 40.00, 'Gobierno');
call sp_EditarCategoria(4041, 'Jefe de mantenimiento', 2200.55, 250.00, 50, 'Administrativo');
call sp_EditarCategoria(4042, 'Contabilidad', 8200.00, 250.00, 400.00, 'Administrativo');
call sp_EditarCategoria(4043, 'Repartidor', 2800.00, 250.00, 150.00, 'Administrativo');
call sp_EditarCategoria(4044, 'Jefe de area', 9230.22, 250.00, 566.00, 'Administrativo');
call sp_EditarCategoria(4046, 'Conserje auxiliar', 3200.00, 250.00, 230.00, 'Administrativo');
call sp_EditarCategoria(4055, 'Jefe', 5000.00, 250.00, 2500.00, 'Administrativo');
call sp_EditarCategoria(4053, 'Dibujante', 5000.00, 250.00, 800.00, 'Administrativo');
call sp_EditarCategoria(4051, 'Programador senior', 9999.00, 250.00, 5000.00, 'Administrativo');
call sp_EditarCategoria(4050, 'Contador', 9499.41, 250.00, 2500.00, 'Administrativo');

-- ----- Eliminar Categoria -----

Delimiter $$
	Create procedure sp_EliminarCategoria (in catID int)
		Begin	
			Delete from Categorias 
				where Categorias.categoriaID = catID;
        End$$
Delimiter ;

-- ----- CRUD - Create - Read - Update - Delete -----
-- ----- Procedimientos almacenados de Regiones -----
-- ----- Agregar Region -----

Delimiter $$
	Create procedure sp_AgregarRegion ( in regID int,
										in nomRegion varchar(20))
		Begin
			Insert into Regiones (regionID, nombreRegion)
				values(regID, nomRegion);
        End$$
Delimiter ;

call sp_AgregarRegion(1,'Metropolitana');
call sp_AgregarRegion(2,'Nororiente');
call sp_AgregarRegion(3,'Central');
call sp_AgregarRegion(4,'Norte');
call sp_AgregarRegion(5,'Suroriente');
call sp_AgregarRegion(6,'Noroccidente');
call sp_AgregarRegion(7,'Suroccidente');
call sp_AgregarRegion(8,'Petén');

-- ----- Listar Regiones -----

Delimiter $$
	Create procedure sp_ListarRegiones ()
		Begin
			Select
				R.regionID,
                R.nombreRegion
                from Regiones R;
        End$$
Delimiter ;

call sp_ListarRegiones();

-- ----- Buscar Region -----

Delimiter $$
	Create procedure sp_BuscarRegion ( in regID int)
		Begin
			Select 
				R.regionID,
                R.nombreRegion
                from Regiones R
					where R.regionID = regID;
        End$$
Delimiter ;

call sp_BuscarRegion(5);

-- ----- Editar Region -----

Delimiter $$
	Create procedure sp_EditarRegion ( in regID int,
									   in nomRegion varchar(20))
		Begin 
			Update Regiones R
				set R.nombreRegion = nomRegion
					where R.regionID = regID;
        End$$
Delimiter ;

call sp_EditarRegion();
call sp_EditarRegion();
call sp_EditarRegion();
call sp_EditarRegion();
call sp_EditarRegion();
call sp_EditarRegion();
call sp_EditarRegion();
call sp_EditarRegion();
call sp_EditarRegion();
call sp_EditarRegion();

-- ----- Eliminar Region -----

Delimiter $$
	Create procedure sp_EliminarRegion ( in regID int)
		Begin
			Delete from Regiones
				where Regiones.regionID = regID;
        End$$
Delimiter ;

call sp_EliminarRegion();
call sp_EliminarRegion();
call sp_EliminarRegion();
call sp_EliminarRegion();
call sp_EliminarRegion();

-- ----- CRUD - Create - Read - Update - Delete -----
-- ----- Procedimientos almacenados para Departamentos -----
-- ----- Agregar Departamento -----

Delimiter $$
	Create procedure sp_AgregarDepartamento ( in depID int,
											  in dep varchar(20),
                                              in regID int)
		Begin
			Insert into Departamentos (departamentoID, departamento, regionID)
				values(depID, dep, regID);
        End$$
Delimiter ;

call sp_AgregarDepartamento(1001,'Ciudad de Guatemala',1);
call sp_AgregarDepartamento(1002,'El Progreso',2);
call sp_AgregarDepartamento(1003,'Chimaltenango', 3);
call sp_AgregarDepartamento(1004,'Chiquimula', 2);
call sp_AgregarDepartamento(1005,'Baja Verapaz', 4);
call sp_AgregarDepartamento(1006,'Alta Verapaz', 4);
call sp_AgregarDepartamento(1007,'Santa Rosa', 5);
call sp_AgregarDepartamento(1008,'Quiche', 6);
call sp_AgregarDepartamento(1009,'Izabal', 2);
call sp_AgregarDepartamento(1010,'Retalhuleu',7);
call sp_AgregarDepartamento(1011,'Zacapa', 2);
call sp_AgregarDepartamento(1012,'Suchitepequez', 5);
call sp_AgregarDepartamento(1013,'Peten', 8);
call sp_AgregarDepartamento(1014,'Jutiapa', 5);
call sp_AgregarDepartamento(1015,'Huehuetenango',6);

-- ----- Listar Departamentos -----

Delimiter $$
	Create procedure sp_ListarDepartamentos ()
		Begin
			Select 
				D.departamentoID,
                D.departamento,
                D.regionID
				from Departamentos D;
        End$$
Delimiter ;

call sp_ListarDepartamentos();

-- ----- Buscar Departamento -----

Delimiter $$
	Create procedure sp_BuscarDepartamento ( in depID int)
		Begin
			Select 
				D.departamentoID,
                D.departamento,
                D.regionID
                from Departamentos D
					where D.departamentoID = depID;
        End$$
Delimiter ;

call sp_BuscarDepartamento(1008);

-- ----- Editar Departamento -----

Delimiter $$
	Create procedure sp_EditarDepartamento ( in depID int,
											 in dep varchar(20))
		Begin
			Update Departamentos D
				set D.departamento = dep
						where D.departamentoID = depID;
        End$$
Delimiter ;

call sp_EditarDepartamento();
call sp_EditarDepartamento();
call sp_EditarDepartamento();
call sp_EditarDepartamento();
call sp_EditarDepartamento();
call sp_EditarDepartamento();
call sp_EditarDepartamento();
call sp_EditarDepartamento();
call sp_EditarDepartamento();
call sp_EditarDepartamento();

-- ----- Eliminar Departamento -----

Delimiter $$
	Create procedure sp_EliminarDepartamento ( in depID int)
		Begin
			Delete from Departamentos 
				where Departamento.departamentoID = depID;
        End$$
Delimiter ;

call sp_EliminarDepartamento();
call sp_EliminarDepartamento();
call sp_EliminarDepartamento();
call sp_EliminarDepartamento();
call sp_EliminarDepartamento();

-- ----- CRUD - Create - Read - Update - Delete -----
-- ----- Procedimientos almacenados de Oficinas -----
-- ----- Agregar Oficina -----

Delimiter $$
	Create procedure sp_AgregarOficina ( in ofiID int,
										 in direc varchar(256),
                                         in depID int)
		Begin
			Insert into Oficinas (oficinaID, direccion, departamentoID)
				values(ofiID, direc, depID);
        End$$
Delimiter ;

call sp_AgregarOficina(7001, 'Blv. Los Próceres 13-50 zona 10, Ciudad Capital', 1001);
call sp_AgregarOficina(7002, '16 Av. 15 calle "A" zona 1, El Progreso', 1002);
call sp_AgregarOficina(7003, '18 calle zona 3, Chimaltenango', 1003);
call sp_AgregarOficina(7004, '28 calle zona 4, Chiquimula ', 1004);
call sp_AgregarOficina(7005, '16 Av. entre 26 y 27 calle zona 5, Baja Verapaz', 1005);
call sp_AgregarOficina(7006, '11 Avenida, zona 6 Alta Verapaz', 1006);
call sp_AgregarOficina(7007, '11 Av. y 27 calle zona 7, Santa Rosa', 1007);
call sp_AgregarOficina(7008, '0 Avenida 11-04 zona 1, Quiche', 1008);
call sp_AgregarOficina(7009, 'Barrio el Estrecho, Puerto Barrios, Izabal', 1009);
call sp_AgregarOficina(7010, '8va. Calle final Colonia Concepción Zona 3 Retalhuleu.', 1010);
call sp_AgregarOficina(7011, 'Calzada Miguel García Granados, Zacapa', 1011);
call sp_AgregarOficina(7012, 'carretera al pacífico, Cuyotenango, Suchitepéquez', 1012);
call sp_AgregarOficina(7013, 'Santa Elena de la Cruz, Flores,El Petén', 1013);
call sp_AgregarOficina(7014, 'KM. 189 CARRETERA A CHAMPERICO ZONA 4 DE Jalapa', 1014);
call sp_AgregarOficina(7015, '5 Calle 7-96 Zona 1 Huehuetenango', 1015);

-- ----- Listar Oficinas -----

Delimiter $$
	Create procedure sp_ListarOficinas ()
		Begin
			Select
				O.oficinaID,
                O.direccion,
                O.departamentoID
                from Oficinas O;
        End$$
Delimiter ;

call sp_ListarOficinas();

-- ----- Buscar Oficina -----

Delimiter $$
	Create procedure sp_BuscarOficina ( in ofiID int)
		Begin
			Select 
				O.oficinaID,
                O.direccion,
                O.departamentoID
                from Oficinas O
					where O.oficinaID = ofiID;
        End$$
Delimiter ;

call sp_BuscarOficina(7007);

-- ----- Editar Oficina -----

Delimiter $$
	Create procedure sp_EditarOficina ( in ofiID int,
										in derec varchar(256),
                                        in depID int)
		Begin
			Update Oficinas O
				set O.direccion = derec,
					O.departamentoID = depID
						where O.oficinaID = ofiID;
        End$$
Delimiter ;

call sp_EditarOficina();
call sp_EditarOficina();
call sp_EditarOficina();
call sp_EditarOficina();
call sp_EditarOficina();
call sp_EditarOficina();
call sp_EditarOficina();
call sp_EditarOficina();
call sp_EditarOficina();
call sp_EditarOficina();

-- ----- Eliminar Oficina -----

Delimiter $$
	Create procedure sp_EliminarOficina ( in ofiID int)
		Begin
			Delete from Oficinas
				where Oficinas.oficinaID = ofiID;
        End$$
Delimiter ;

call sp_EliminarOficina();
call sp_EliminarOficina();
call sp_EliminarOficina();
call sp_EliminarOficina();
call sp_EliminarOficina();

-- ----- CRUD - Create - Read -  Update - Delete -----
-- ----- Procedimientos almacenados de Telefonos -----
-- ----- Agregar telefono -----

Delimiter $$
	Create procedure sp_AgregarTelefono ( in telID int,
										  in numTel varchar(10),
                                          in ofiID int)
		Begin
			Insert into Telefonos (telefonoID, numeroTelefono, oficinaID)
				values(telID, numTel, ofiID);
        End$$
Delimiter ;

call sp_AgregarTelefono(501,'7589-6523',7001);
call sp_AgregarTelefono(502,'7485-9623',7002);
call sp_AgregarTelefono(503,'8594-7859',7003);
call sp_AgregarTelefono(504,'2659-8456',7004);
call sp_AgregarTelefono(505,'8597-4859',7005);
call sp_AgregarTelefono(506,'2598-6421',7006);
call sp_AgregarTelefono(507,'1526-9854',7007);
call sp_AgregarTelefono(508,'6958-7485',7008);
call sp_AgregarTelefono(509,'3659-8264',7009);
call sp_AgregarTelefono(510,'9586-7485',7010);
call sp_AgregarTelefono(511,'9658-9325',7011);
call sp_AgregarTelefono(512,'8596-2358',7012);
call sp_AgregarTelefono(513,'8597-4826',7013);
call sp_AgregarTelefono(514,'9568-4752',7014);
call sp_AgregarTelefono(515,'1023-9586',7015);

-- ----- Listar Telefonos ----- 

Delimiter $$
	Create procedure sp_ListarTelefonos ()
		Begin
			Select 
				T.telefonoID,
                T.numeroTelefono,
                T.oficinaID
                from Telefonos T;
        End$$
Delimiter ;

call sp_ListarTelefonos();

-- ----- Buscar Telefono -----

Delimiter $$
	Create procedure sp_BuscarTelefono ( in telID int)
		Begin
			Select 
				T.telefonoID,
                T.numeroTelefono,
                T.oficinaID
                from Telefonos T
					where T.telefonoID = telID;
		End$$
Delimiter ;

call sp_BuscarTelefono(508);

-- ----- Editar Telefono -----

Delimiter $$
	Create procedure sp_EditarTelefono ( in telID int,
										 in numTel varchar(10),
                                         in ofiID int)
		Begin
			Update Telefonos T
				set T.numeroTelefono = numTel,
                    T.oficinaID = ofiID
						where T.telefonoID = telID;
        End$$
Delimiter ;

call sp_EditarTelefono();
call sp_EditarTelefono();
call sp_EditarTelefono();
call sp_EditarTelefono();
call sp_EditarTelefono();
call sp_EditarTelefono();
call sp_EditarTelefono();
call sp_EditarTelefono();
call sp_EditarTelefono();
call sp_EditarTelefono();

-- ----- Eliminar Telefono -----

Delimiter $$
	Create procedure sp_EliminarTelefono ( in telID int)
		Begin
			Delete from Telefonos
				where Telefonos.telefonoID = telID;
        End$$
Delimiter ;

call sp_EliminarTelefono();
call sp_EliminarTelefono();
call sp_EliminarTelefono();
call sp_EliminarTelefono();
call sp_EliminarTelefono();

-- ----- CRUD - Create - Read - Update - Delete -----
-- ----- Procedimientos almacenados de Secciones -----
-- ----- Agregar Seccion -----

Delimiter $$
	Create procedure sp_AgregarSeccion ( in secID int,
										 in nomSec varchar(50),
                                         in ofiID int)
		Begin
			Insert into Secciones (seccionID, nombreSeccion, oficinaID)
				values(secID, nomSec, ofiID);
        End$$
Delimiter ;

call sp_AgregarSeccion(5001,'Ventas', 7001);
call sp_AgregarSeccion(5002,'TICS', 7002);
call sp_AgregarSeccion(5003,'Contabilidad', 7003);
call sp_AgregarSeccion(5004,'Atención al Cliente', 7004);
call sp_AgregarSeccion(5005,'Mantenimiento', 7005);
call sp_AgregarSeccion(5006,'Seguridad', 7006);
call sp_AgregarSeccion(5007,'Producción', 7007);
call sp_AgregarSeccion(5008,'Compras', 7008);
call sp_AgregarSeccion(5009,'Recursos Humanos', 7009);
call sp_AgregarSeccion(5010,'Marketing',7010);
call sp_AgregarSeccion(5011,'Administración', 7011);
call sp_AgregarSeccion(5012,'Finanzas', 7012);
call sp_AgregarSeccion(5013,'Auditoría', 7013);
call sp_AgregarSeccion(5014,'Desarrollo', 7014);
call sp_AgregarSeccion(5015,'Mecánica',7015);

-- ----- Listar Secciones -----

Delimiter $$
	Create procedure sp_ListarSecciones ()
		Begin
			Select 
				S.seccionID,
                S.nombreSeccion,
                S.oficinaID
                from Secciones S;
        End$$
Delimiter ;

call sp_ListarSecciones();

-- ----- Buscar Seccion -----

Delimiter $$
	Create procedure sp_BuscarSeccion ( in secID int)
		Begin
			Select 
				S.seccionID,
                S.nombreSeccion,
                S.oficinaID
				from Secciones S
					where S.seccionID = secID;
        End$$
Delimiter ;

call sp_BuscarSeccion(5012);

-- ----- Editar Seccion -----

Delimiter $$
	Create procedure sp_EditarSeccion ( in secID int,
										in nomSec varchar(50),
                                        in ofiID int)
		Begin
			Update Secciones S
				set S.nombreSeccion = nomSec,
					S.oficinaID = ofiID
						where S.secID = secID;
        End$$
Delimiter ;

call sp_EditarSeccion();
call sp_EditarSeccion();
call sp_EditarSeccion();
call sp_EditarSeccion();
call sp_EditarSeccion();
call sp_EditarSeccion();
call sp_EditarSeccion();
call sp_EditarSeccion();
call sp_EditarSeccion();
call sp_EditarSeccion();

-- ----- Eliminar Seccion -----

Delimiter $$
	Create procedure sp_EliminarSeccion ( in secID int)
		Begin
			Delete from Secciones 
				where Secciones.seccionID = secID;
        End$$
Delimiter ;

call sp_EliminarSeccion();
call sp_EliminarSeccion();
call sp_EliminarSeccion();
call sp_EliminarSeccion();
call sp_EliminarSeccion();

-- ----- CRUD - Create - Read - Update - Delete -----
-- ----- Procedimientos almacenados -----
-- ----- Agregar Empleado -----

Delimiter $$
	Create procedure sp_AgregarEmpleado ( in empID int,
										  in nom varchar(45),
                                          in fechDeNacimiento date,
                                          in telPersonal varchar(10),
                                          in fechDeContratación date,
                                          in catID int,
                                          in seccID int)
		Begin 
			Insert into Empleados (empleadoID, 
								   nombre, 
                                   fechaDeNacimiento, 
                                   telefonoPersonal, 
                                   fechaDeContratacion, 
                                   categoriaID, 
                                   seccionID)
				values(empID, nom, fechDeNacimiento, telPersonal, fechDeContratacion, catID, seccID);
        End$$
Delimiter ;

call sp_AgregarEmpleado(101,'Carny Ferrie Marns Suarez','1995-12-05','6808-4302','2015-12-28',4041,5005);
call sp_AgregarEmpleado(102,'Felipa Antinia McBrier Ferry','1990-03-11','4950-2900', '2012-01-01',4044,5007);
call sp_AgregarEmpleado(103,'Alexandra Sofia Bartelli Guzman','1996-05-12','6804-7186', '2008-04-18',4042,5009);
call sp_AgregarEmpleado(104,'Jose Andres Roskilly Rosales','1992-02-14','6089-9070', '2006-03-16',4043,5001);
call sp_AgregarEmpleado(105,'Pierson Galileo Perez Gillio','1992-6-15','4934-9837', '2013-08-16',4044,5001);
call sp_AgregarEmpleado(106,'Jose Pedro Massingberd Zannoti','1994-03-20','1057-8055', '2012-10-13',4044,5002);
call sp_AgregarEmpleado(107,'Verin Carlo Auditore Calcutt','1992-10-14','0378-6727', '2009-09-30',4048,5002);
call sp_AgregarEmpleado(108,'Kessi Fry Gozales Fritschel','1970-12-01','0527-1537', '2014-01-06',4047,5002);
call sp_AgregarEmpleado(109,'Jessica Alejandra Connold Guzman','1972-08-10','6586-2142', '2013-11-17',4044,5003);
call sp_AgregarEmpleado(110,'Kacie Abigail Doren Abbis','1985-04-12','1512-7957','2008-07-08',4049,5004);
call sp_AgregarEmpleado(111,'Jose Poul Fawltey Salay','1984-08-15','6822-0089', '2007-09-29',4046,5003);
call sp_AgregarEmpleado(112,'Terri Isabel Prickly Pridgeon','1980-06-14','1007-4882', '2005-12-21',4048,5003);
call sp_AgregarEmpleado(113,'Humfrid Jose Budgie Cokly','1980-12-14','4934-6854', '2012-11-24',4044,5004);
call sp_AgregarEmpleado(114,'Myrta Ana Plowes Jade','1960-07-10','0378-6060','2005-01-05',4054,5006);
call sp_AgregarEmpleado(115,'Bernardina Olga Juarez Nolda','1970-08-12','6217-5580', '2015-07-07',4044,5006);
call sp_AgregarEmpleado(116,'Goldie Sadina Dunn Volpe','1990-05-15','4193-6317', '2014-05-29',4042,5007);
call sp_AgregarEmpleado(117,'Kania Guisela Montenegro Moores','1969-01-15','5545-5578', '2011-11-25',4048,5007);
call sp_AgregarEmpleado(118,'Drusy Freddy Frostick Avila','1985-09-16','7253-3902', '2014-02-06',4042,5008);
call sp_AgregarEmpleado(119,'Mead Giancarlo Abadam Casinos','1990-04-18','4508-5318', '2012-01-01',4048,5008);
call sp_AgregarEmpleado(120,'Carly Anai Mcurdy Batkin','1962-11-15','8982-2262', '2005-09-21',4044,5009);
call sp_AgregarEmpleado(121,'Manfred Jose Muckle Kennedy','1970-10-12','8769-5506', '2012-03-25',4053,5010);
call sp_AgregarEmpleado(122,'Jose Kyle Trinke Rougue','1975-06-18','9734-6020', '2013-01-08',4044,5010);
call sp_AgregarEmpleado(123,'Celesta Valery Gittus Roche','1978-06-19','6121-9681', '2006-03-02',4055,5011);
call sp_AgregarEmpleado(124,'Peyton Madison Aers Godinez','1978-09-17','2497-9770', '2012-12-16',4044,5011);
call sp_AgregarEmpleado(125,'Bryan Kristopher Martinez Molina','1975-03-26','9401-9245', '2013-08-16',4046,5012);
call sp_AgregarEmpleado(126,'Riordan Zacari Akid Matias','1960-12-15','9837-7547', '2010-05-27',4048,5012);
call sp_AgregarEmpleado(127,'Hirsch Bruno Couch Muss','1962-09-14','99549921', '2007-03-26',4044,5014);
call sp_AgregarEmpleado(128,'Jose Conor Struijs Satij','1978-08-15','17790641', '2011-06-05',4048,5014);
call sp_AgregarEmpleado(129,'Ginnifer Sofia Lawrence Cornillot','1975-03-12','43946419', '2013-08-30',4051,5014);
call sp_AgregarEmpleado(130,'Jose Red Oakey Manrique','1960-02-18','38249248', '2011-03-27',4048,5005);
call sp_AgregarEmpleado(131,'Javier Alejandro Barahona Pasan','1990-11-13','5563-7813','2010-02-15',4044,5005);
call sp_AgregarEmpleado(132,'Brandon Tony Rosenfield Vasquez', '1997-04-26', '3992-1162', '2016-01-28',4048,5001);
call sp_AgregarEmpleado(133,'Britany Luisa Estrada Marisol', '1970-03-23', '4093-0234', '2018-06-07',4048,5004);
call sp_AgregarEmpleado(134,'Denys Steve Holley Donnan', '1974-12-21', '2756-5999', '2017-09-16',4048,5006);
call sp_AgregarEmpleado(135,'Rafa Alexander Colo Gonzales', '1989-07-11', '4603-5587', '2016-09-13',4044,5008);
call sp_AgregarEmpleado(136,'Abygail Jenilee Guyonnet Armas', '1996-03-03', '3857-2699', '2017-05-08',4048,5009);
call sp_AgregarEmpleado(137,'Peter Adolfo Alfaro Noguera', '1989-01-09', '8088-9644', '2015-11-19',4048,5010);
call sp_AgregarEmpleado(138,'Olivia Fernanda Quiñones Salazar', '1996-09-16', '2534-1777', '2018-01-19',4048,5011);
call sp_AgregarEmpleado(139,'Alejandro Emanuel Salazar Barrera', '1970-10-31', '3365-1077', '2018-12-07',4044,5012);
call sp_AgregarEmpleado(140,'Emmy Andrea Velasquez Avila', '1994-07-03', '3793-4587', '2018-09-28',4050,5013);
call sp_AgregarEmpleado(141,'Karol Gabriela Fajardo Callen', '1982-03-14', '3949-2949', '2018-11-23',4044,5013);
call sp_AgregarEmpleado(142,'Jose Adolfo Suarez Acevedo', '1977-02-09', '2223-1010', '2015-08-31',4048,5013);
call sp_AgregarEmpleado(143,'Joaquin Fernando Williment Lemus', '1994-01-05', '6754-3230', '2017-11-10',4052,5015);
call sp_AgregarEmpleado(144,'Dina Guisela Valle Carrillo', '1983-05-20', '2308-2261', '2018-01-09',4044,5015);
call sp_AgregarEmpleado(145,'Brayan Alexander Pineda Prichard', '1990-06-19', '4081-2076', '2017-06-23',4048,5015);

-- ----- Listar Empleados -----

Delimiter $$
	Create procedure sp_ListarEmpleados ()
		Begin
			Select 
				E.empleadoID,
                E.nombre,
                E.fechaDeNacimiento,
                E.edad,
                E.telefonoPersonal,
                E.fechaDeContratacion,
                E.categoriaID,
                E.seccionID
                from Empleados E;
        End$$
Delimiter ;

 call sp_ListarEmpleados();

-- ----- Buscar Empleado -----

Delimiter $$
	Create procedure sp_BuscarEmpleado ( in empID int)
		Begin 
			Select 
				E.empleadoID,
                E.nombre,
                E.fechaDeNacimiento,
                E.edad,
                E.telefonoPersonal,
                E.fechaDeContratacion,
                E.categoriaID,
                E.seccionID
				from Empleados E
					where E.empleadoID = empID;
        End$$
Delimiter ;

call sp_BuscarEmpleado(120);

-- ----- Editar Empleado -----

Delimiter $$
	Create procedure sp_EditarEmpleado ( in empID int,
										 in nom varchar(45),
                                         in fechDeNacimiento date,
                                         in telPersonal varchar(10),
                                         in fechDeContratacion date,
                                         in catID int,
                                         in seccID int)
		Begin
			Update Empleados E
				set E.nombre = nom,
					E.fechaDeNacimiento = fechDeNacimiento,
                    E.telefonoPersonal = telPersonal,
                    E.fechaDeContratacion = fechDeContratacion,
                    E.categoriaID = catID,
                    E.seccionID = seccID
						where E.empleadoID = empID;
        End$$
Delimiter ;

call sp_EditarEmpleado();
call sp_EditarEmpleado();
call sp_EditarEmpleado();
call sp_EditarEmpleado();
call sp_EditarEmpleado();
call sp_EditarEmpleado();
call sp_EditarEmpleado();
call sp_EditarEmpleado();
call sp_EditarEmpleado();
call sp_EditarEmpleado();

-- ----- Eliminar Empleado -----

Delimiter $$
	Create procedure sp_EliminarEmpleado ( in empID int)
		Begin
			Delete from Empleados 
				where Empleados.empleadoID = empID;
        End$$
Delimiter ;

call sp_EliminarEmpleado();
call sp_EliminarEmpleado();
call sp_EliminarEmpleado();
call sp_EliminarEmpleado();
call sp_EliminarEmpleado();

-- ----- Delete -----
-- ----- Delete -----
-- ----- Delete -----
-- ----- Delete -----
-- ----- Delete -----
-- ----- Delete -----
-- ----- Delete Categoria -----

call sp_EliminarCategoria(4045);
call sp_EliminarCategoria(4049);
call sp_EliminarCategoria(4041);
call sp_EliminarCategoria(4043);
call sp_EliminarCategoria(4047);

-- ----- Selects -----

Select * from Empleados;

Select max(Empleados.empleadoID) as Resultado from Empleados;

-- 1) Nombre y edad de los empleados.
Select Empleados.nombre, 2023 - year(fechaDeNacimiento) as Edad from Empleados;

-- 3) Fecha de contratacion de cada empleado
Select Empleados.nombre, Empleados.fechaDeContratacion as Fecha_De_Contratacion from Empleados;

-- 4) Edad de los empleados
Select 2023 - year(Empleados.fechaDeNacimiento) as Edades_Empleados from Empleados;

-- 5) Numero de empleados que hay para cada una de las edades.
Select 2023 - year(Empleados.fechaDeNacimiento) as Edades, count(*) as NumeroDeEdades from Empleados group by 2023 - year(Empleados.fechaDeNacimiento);

-- Edad media de los empleados por departamento
Select departamento, avg(2023-year(E.fechaDeNacimiento)) as Promedio from Empleados E INNER JOIN Secciones S
	on S.seccionID = E.seccionID
		INNER JOIN Oficinas O on O.oficinaID = S.OficinaID
			INNER JOIN Departamentos D on D.departamentoID = O.departamentoID group by departamento;
