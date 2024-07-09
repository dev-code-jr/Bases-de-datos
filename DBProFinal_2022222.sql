/*Programador 
	Nombre: Edwar René Chamalé Gonzaléz
	Carné: 2022222
    Creación:
		Fecha: 9/02/2023 Hora de inicio: 09:30:55am
	Modificaciones
		Fecha 9/02/2023 Hora de pausado: 11:00:25am
        Fecha de retomación: 11/02/2023 
			Hora de inicio: 23:49:22pm 
				Fecha de pausado: 12/02/2023 Hora de pausado: 00:48:56pm
        Fecha de retomación: 20/02/2023 
			Hora de inicio: 22:12:11pm 
				Fecha de pausado: 21/02/2023 Hora de pausado: 01:55:12am
        Fecha de retomación: 21/02/2023 
			Hora de inicio: 23:38:21pm 
				Fecha de pausdo: 22/02/2023 Hora de pausado: 02:12:41am
        Fecha de retomación: 22/02/2023 
			Hora de inicio: 21:22:32pm 
				Fecha de pausado: 22/02/2023Hora de pausado: 23:55:55pm
        Fecha de retomación: 23/02/2023 
			Hora de inicio: 23:35:42pm 
				Fecha de pausado: 24/02/2023 Hora de pausado: 02:33:00am
		Fecha de retomación: 24/02/2023
			Hora de inicio: 11:35:11am
				Hora de finalizacion: 16:43:10pm
	Trabajo completado
		Fecha de finalización: 24/02/2023 
			Hora de finalización: 16:43:10pm
   */ 
Drop database if exists DBProFinal_2022222;

Create database DBProFinal_2022222;
Use DBProFinal_2022222;

Create table Regiones(
	regionID int not null,
    nombreRegion varchar(20) not null,
    primary key PK_regionID (regionID)
);

Create table TipoEmpleado(
	codigoTipoEmpleadoID int not null,
    nombreTipoEmpleado varchar(45) not null,
    sueldoBase decimal(10,2) not null,
    bonificacion decimal(10,2) not null,
    bonificacionEmpresa decimal(10,2) not null,
    primary key PK_codigoTipoEmpleadoID (codigoTipoEmpleadoID)
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
    numeroTelefono varchar(15) not null,
    oficinaID int not null,
    primary key PK_telefonoID (telefonoID),
    constraint FK_Telefonos_Oficinas foreign key (oficinaID)
		references Oficinas (oficinaID)
);

Create table DepartamentoEmpresa(
	departamentoEmpresaID int not null,
    nombreDepartamento varchar(30) not null,
    oficinaID int not null,
    primary key PK_departamentoEmpresaID (departamentoEmpresaID),
    constraint FK_DepartamentoEmpresa_Oficinas foreign key (oficinaID)
		references Oficinas (oficinaID)
);

Create table Empleados(
	empleadoID int not null,
    nombre varchar(45) not null,
    fechaDeNacimiento date not null,
    edad int,
    telefonoPersonal varchar(15) not null,
    fechaDeContratacion date not null,
    tipoEmpleadoID int not null,
    departamentoEmpresaID int not null,
    primary key PK_empleadoID (empleadoID),
    constraint FK_Empleados_TipoEmpleado foreign key (tipoEmpleadoID)
		references TipoEmpleado (codigoTipoEmpleadoID),
	constraint FK_Empleados_DepartamentoEmpresa foreign key (departamentoEmpresaID)
		references DepartamentoEmpresa (departamentoEmpresaID)
);

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

Call sp_AgregarRegion(101, 'Metropolitana');
Call sp_AgregarRegion(102, 'Central');
Call sp_AgregarRegion(103, 'Nororiente');
Call sp_AgregarRegion(104, 'Norte');
Call sp_AgregarRegion(105, 'Suroriente');
Call sp_AgregarRegion(106, 'Noroccidente');
Call sp_AgregarRegion(107, 'Suroccidente');
Call sp_AgregarRegion(108, 'Petén');

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

Call sp_ListarRegiones();

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

Call sp_BuscarRegion(103);

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

/*Call sp_EditarRegion(103, 'Metropolitana');
Call sp_EditarRegion(104, 'Central');
Call sp_EditarRegion(106, 'Nororiente');
Call sp_EditarRegion(103, 'Norte');
Call sp_EditarRegion(104, 'Norte');
Call sp_EditarRegion(106, 'Norte');
Call sp_EditarRegion(103, 'Petén');
call sp_EditarRegion(104, 'Central');
call sp_EditarRegion(106, 'Noroccidente');
Call sp_EditarRegion(103, 'Nororiente');*/

-- ----- Eliminar Region -----

Delimiter $$
	Create procedure sp_EliminarRegion ( in regID int)
		Begin
			Delete from Regiones 
				where Regiones.regionID = regID;
        End$$
Delimiter ;

-- ----- CRUD - Create - Read - Update - Delete -----
-- ----- Procedimientos almacenados de TipoEmpleado -----
-- ----- Agregar Tipo Empleado -----

Delimiter $$
	Create procedure sp_AgregarTipoEmpleado ( in codTipoEmpleado int,
											  in nomTipoEmpleado varchar(45),
											  in suBase decimal(10,2),
                                              in bon decimal(10,2),
                                              in bonEmpresa decimal(10,2))
		Begin
			Insert into TipoEmpleado (codigoTipoEmpleadoID, 
									  nombreTipoEmpleado, 
                                      sueldoBase, 
                                      bonificacion, 
                                      bonificacionEmpresa)
				values(codTipoEmpleado, nomTipoEmpleado, suBase, bon, bonEmpresa);
        End$$
Delimiter ;

Call sp_AgregarTipoEmpleado(1001, 'Ingeniero mecanico administrativo', 50000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1002, 'Ingeniero electrico', 50000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1003, 'Ingeniero civil', 50000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1004, 'Ingeniero de software', 50000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1005, 'Ingeniero quimico', 50000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1006, 'Ingeniero industrial', 50000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1007, 'Diseñador grafico', 50000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1008, 'Diseñador de interiores', 9000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1009, 'Diseñador web', 8000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1010, 'Diseñador industrial', 45000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1011, 'Policia', 50000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1012, 'Enfermero', 7500.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1013, 'Medico', 50000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1014, 'Abogado', 50000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1015, 'Periodista', 50000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1016, 'Fotografo', 6000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1017, 'Arquitecto', 6000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1018, 'Programador', 11000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1019, 'Desarrollador de software', 12000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1020, 'Recepcionista', 6500.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1021, 'Psicologo', 8700.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1022, 'Analista de sistemas', 5000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1023, 'Investigador', 7000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1024, 'Contador', 4500.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1025, 'Analista financiero', 8550.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1026, 'Agente de seguros', 9500.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1027, 'Consultor', 8220.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1028, 'Gerente de proyectos de produccion', 8500.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1029, 'Analista de datos', 15000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1030, 'Agente inmobiliario', 16500.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1031, 'Ingeniero de ciber seguridad', 17000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1032, 'Ingeniero en informatica', 50000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1033, 'Mecanico', 8412.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1034, 'Tecnico de mantenimiento', 7862.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1035, 'Tecnico en reparacion de computadoras', 15513.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1036, 'Desarrollador web', 15000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1037, 'Consultor de tecnologia administrativo', 50000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1038, 'Auxiliar de enfermeria', 16500.00, 5000.00, 150.00);
Call sp_AgregarTipoEmpleado(1039, 'Asistente social', 7500.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1040, 'Analista de calidad', 15000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1041, 'Analista de produccion', 10000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1042, 'Analista de recursos humanos', 8000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1043, 'Analista de desarrollo organizacional', 9000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1044, 'Director de marketing', 50000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1045, 'Ayudante de marketing', 10000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1046, 'Auxiliar de marketing', 9000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1047, 'Gerente de finanzas', 50000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1048, 'Programador junior', 38000.00, 350.00, 150.00);
Call sp_AgregarTipoEmpleado(1049, 'Programador semi - senior', 10000.00, 500.00, 150.00);
Call sp_AgregarTipoEmpleado(1050, 'Programador senior administrativo', 50000.00, 500.00, 150.00);

-- ----- Listar Tipo Empleados -----

Delimiter $$
	Create procedure sp_ListarTipoEmpleados ()
		Begin
			Select 
				TE.codigoTipoEmpleadoID,
                TE.nombreTipoEmpleado, 
                TE.sueldoBase, 
                TE.bonificacion,
                TE.bonificacionEmpresa
				from TipoEmpleado TE;
        End$$
Delimiter ;

Call sp_ListarTipoEmpleados();

-- ----- Buscar Tipo Empleado -----

Delimiter $$
	Create procedure sp_BuscarTipoEmpleado ( in codTipoEmpleado int)
		Begin
			Select
				TE.codigoTipoEmpleadoID,
                TE.nombreTipoEmpleado,
                TE.sueldoBase,
                TE.bonificacion,
                TE.bonificacionEmpresa
                from TipoEmpleado TE
					where TE.codigoTipoEmpleadoID = codTipoEmpleado;
        End$$
Delimiter ;

Call sp_BuscarTipoEmpleado(1002);

-- ----- Editar Tipo Empleado -----

Delimiter $$
	Create procedure sp_EditarTipoEmpleado ( in codTipoEmpleado int,
											 in nomTipoEmpleado varchar(45),
                                             in suBase decimal(10,2),
                                             in bon decimal(10,2),
                                             in bonEmpresa decimal(10,2))
		Begin
			Update TipoEmpleado TE
				set TE.nombreTipoEmpleado = nomTipoEmpleado,
					TE.sueldoBase = suBase,
                    TE.bonificacion = bon,
                    TE.bonificacionEmpresa = bonEmpresa
					where TE.codigoTipoEmpleadoID = codTipoEmpleado; 
        End$$
Delimiter ;

/*Call sp_EditarTipoEmpleado(1002, 'Director ejecutivo general', 12500.00, 500.00, 250.00); 
Call sp_EditarTipoEmpleado(1003, 'Director de operaciones generales', 10000.00, 500.00, 175.00);
Call sp_EditarTipoEmpleado(1004, 'Encargado de marketing', 9500.00, 350.00, 150.00);
Call sp_EditarTipoEmpleado(1005, 'Director superior de tecnologia', 11500.00, 500.00, 150.00);
Call sp_EditarTipoEmpleado(1010, 'Director analista de ingresos', 8500.00, 350.00, 150.00);
Call sp_EditarTipoEmpleado(1011, 'Director analista de datos', 9500.00, 350.00, 150.00);
Call sp_EditarTipoEmpleado(1012, 'Gerente superior tecnico general', 10500.00, 500.00, 150.00);
Call sp_EditarTipoEmpleado(1013, 'Gerente de planificacion de proyectos', 7500.00, 350.00, 150.00);
Call sp_EditarTipoEmpleado(1014, 'Gerente de operaciones avanzadas', 7500.00, 350.00, 150.00);
Call sp_EditarTipoEmpleado(1017, 'Gerente de desarrollo organizacional', 10000.00, 500.00, 250.00);
*/

-- ----- Eliminar Tipo Empleado -----

Delimiter $$
	Create procedure sp_EliminarTipoEmpleado ( in codTipoEmpleado int)
		Begin 
			Delete from TipoEmpleado
				where TipoEmpleado.codigoTipoEmpleadoID = codTipoEmpleado;
        End$$
Delimiter ;

-- ----- CRUD - Create - Read - Update - Delete -----
-- ----- Procedimientos almacenados de Departamentos -----
-- ----- Agregar Departamento -----

Delimiter $$
	Create procedure sp_AgregarDepartamento (in depID int,
											 in dep varchar(20),
                                             in regID int)
		Begin
			Insert into Departamentos (departamentoID, departamento, regionID)
				values(depID, dep, regID);
        End$$
Delimiter ;

Call sp_AgregarDepartamento(2001, 'Alta Verapaz', 104);
Call sp_AgregarDepartamento(2002, 'Baja Verapaz', 104);
Call sp_AgregarDepartamento(2003, 'Chimaltenango', 106);
Call sp_AgregarDepartamento(2004, 'Chiquimula', 103);
Call sp_AgregarDepartamento(2005, 'El Progreso', 103);
Call sp_AgregarDepartamento(2006, 'Escuintla', 106);
Call sp_AgregarDepartamento(2007, 'Guatemala', 101);
Call sp_AgregarDepartamento(2008, 'Huehuetenango', 106);
Call sp_AgregarDepartamento(2009, 'Izabal', 103);
Call sp_AgregarDepartamento(2010, 'Jalapa', 103);
Call sp_AgregarDepartamento(2011, 'Jutiapa', 103);
Call sp_AgregarDepartamento(2012, 'Petén', 104);
Call sp_AgregarDepartamento(2013, 'Quetzaltenango', 106);
Call sp_AgregarDepartamento(2014, 'Quiché', 106);
Call sp_AgregarDepartamento(2015, 'Retalhuleu', 107);
Call sp_AgregarDepartamento(2016, 'Sacatepéquez', 102);
Call sp_AgregarDepartamento(2017, 'San Marcos', 106);
Call sp_AgregarDepartamento(2018, 'Santa Rosa', 105);
Call sp_AgregarDepartamento(2019, 'Sololá', 106);
Call sp_AgregarDepartamento(2020, 'Suchitepéquez', 107);
Call sp_AgregarDepartamento(2021, 'Totonicapán', 106);
Call sp_AgregarDepartamento(2022, 'Zacapa', 103);

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

Call sp_ListarDepartamentos();

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

Call sp_BuscarDepartamento(2022);

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

/*Call sp_EditarDepartamento(2001, 'Guatemala');
Call sp_EditarDepartamento(2002, 'Escuintla');
Call sp_EditarDepartamento(2003, 'Jalapa');
Call sp_EditarDepartamento(2004, 'Jutiapa');
Call sp_EditarDepartamento(2005, 'Izabal');
Call sp_EditarDepartamento(2001, 'Alta Verapaz');
Call sp_EditarDepartamento(2002, 'Baja Verapaz');
Call sp_EditarDepartamento(2003, 'Chimaltenango');
Call sp_EditarDepartamento(2004, 'Chiquimula');
Call sp_EditarDepartamento(2005, 'El Progreso');*/

-- ----- Eliminar Departamento -----

Delimiter $$
	Create procedure sp_EliminarDepartamento ( in depID int) 
		Begin
			Delete from Departamentos
				where Departamentos.departamentoID = depID;
        End$$
Delimiter ;

-- ----- CRUD - Create - Read - Update - Delete -----
-- ----- Procedimientos almacenos para Oficinas -----
-- ----- Agregar Oficina -----

Delimiter $$
	Create procedure sp_AgregarOficina ( in ofiID int,
										 in direc varchar(256),
                                         in departID int)
		Begin
			Insert into Oficinas (oficinaID, direccion, departamentoID)
				values(ofiID, direc, departID);
        End$$
Delimiter ;

Call sp_AgregarOficina(3001, '3a Avenida, Barrio el Porvenir, Tactic', 2001);
Call sp_AgregarOficina(3002, '1a Calle, zona 5, San Pedro Carchá', 2001);
Call sp_AgregarOficina(3003, '2a Avenida, Barrio el centro, San Juan Chamelco', 2001);
Call sp_AgregarOficina(3004, '4a Calle, Barrio el Carmen, Cubulco', 2002);
Call sp_AgregarOficina(3005, '2a Avenida, zona 1, Salamá', 2002);
Call sp_AgregarOficina(3006, '5a Calle, Barrio el Centro, San Miguel Chicaj', 2002);
Call sp_AgregarOficina(3007, '1a Avenida, zona 3, San Andrés Itzapa', 2003);
Call sp_AgregarOficina(3008, '3a Calle, Barrio el Centro, Tecpán Guatemala', 2003);
Call sp_AgregarOficina(3009, '2a Avenida, zona 1, Chimaltenango', 2003);
Call sp_AgregarOficina(3010, '6a Avenida, Barrio el Centro, San Jacinto', 2004);
Call sp_AgregarOficina(3011, '1a Calle, Zona 1, Chiquimula', 2004);
Call sp_AgregarOficina(3012, '2a Avenida, Barrio el Progreso, Olapa', 2004);
Call sp_AgregarOficina(3013, '1a Avenida, Zona 3, Guastatoya', 2005);
Call sp_AgregarOficina(3014, '4a Calle, Barrio el Centro, Sanarate', 2005);
Call sp_AgregarOficina(3015, '3a Avenida, zona 1, El Jícaro', 2005);
Call sp_AgregarOficina(3016, '5a Calle, zona 1, Escuintla', 2006);
Call sp_AgregarOficina(3017, '1a Avenida, Barrio el Centro, La Democracia', 2006);
Call sp_AgregarOficina(3018, '3a Calle, Barrio el Carmen, Tiquisate', 2006);
Call sp_AgregarOficina(3019, '1a Avenida, zona 10, Cuidad de Guatemala', 2007);
Call sp_AgregarOficina(3020, '2a Avenida, zona 2, Obelisco', 2007);
Call sp_AgregarOficina(3021, 'Avenida Juan Chapin', 2007);
Call sp_AgregarOficina(3022, '5a Avenida, zona 3, Huehuetenango', 2008);
Call sp_AgregarOficina(3023, '1a Calle, Barrio el Centro, Puerto Barrios', 2009);
Call sp_AgregarOficina(3024, '2a Avenida, zona 1, El Estor', 2009);
Call sp_AgregarOficina(3025, '4a Calle, Barrio San Juan, Livingston', 2009);
Call sp_AgregarOficina(3026, '6a Avenidad, zona 3, Jalapa', 2010);
Call sp_AgregarOficina(3027, '1a Calle, Barrio el Centro, San Pedro Pinula', 2010);
Call sp_AgregarOficina(3028, '2a Avenida, Zona 2, Mataquescuintla', 2010);
Call sp_AgregarOficina(3029, '3a Calle, Barrio el Centro, Jutiapa', 2011);
Call sp_AgregarOficina(3030, '1a Avenida, zona 4, Comapa', 2011);
Call sp_AgregarOficina(3031, '2a Calle, zona 2, Asunción Mita', 2021);
Call sp_AgregarOficina(3032, '1a Avenida, Barrio el Centro, Sayaxché', 2012);
Call sp_AgregarOficina(3033, '2a Calle 4-13 zona 1, Petén', 2012);
Call sp_AgregarOficina(3034, '5a Avenida 7-09, zona 2, Petén', 2012);
Call sp_AgregarOficina(3035, '8a Calle 2-56, zona 3, Petén', 2012);
Call sp_AgregarOficina(3036, '7a Avenida 1-80, zona 3, Quetzaltenango', 2013);
Call sp_AgregarOficina(3037, '3a Calle 12-25, zona 6, Quetzaltenango', 2013);
Call sp_AgregarOficina(3038, '9a Avenida 8-40, zona 1, Quetzaltenango', 2013);
Call sp_AgregarOficina(3039, '3a Calle 3-56, zona 3, Santa Cruz del Quiché', 2014);
Call sp_AgregarOficina(3040, '7a Avenida 1-34, zona2', 2014);
Call sp_AgregarOficina(3041, '8a Calle 3-45, zona 1, Uspantán', 2014);
Call sp_AgregarOficina(3042, '1ra Calle 6-22, zona 2, Santa Cruz del Quiché', 2014);
Call sp_AgregarOficina(3043, '4ta Avenida 8-64, zona 1, Retalhuleu', 2015);
Call sp_AgregarOficina(3044, '3ra Calle 5-45, zona 1, Antigua Guatemala', 2016);
Call sp_AgregarOficina(3045, '3ra Avenida, 2-03, zona 2, San Marcos', 2017);
Call sp_AgregarOficina(3046, '1ra Calle 4-85, zona 1, Cuilapa', 2018);
Call sp_AgregarOficina(3047, '5ta Avenida 7-72, zona 1, Sololá', 2019);
Call sp_AgregarOficina(3048, '2da Avenida 6-25, zona 1, Mazatenango', 2020);
Call sp_AgregarOficina(3049, '6ta Calle 1-98, zona 2, Totonicapán', 2022);
Call sp_AgregarOficina(3050, '2da Avenida 5-42, zona 1, Zacapa', 2022);

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

Call sp_ListarOficinas();

-- ----- Buscar oficina -----

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

Call sp_BuscarOficina(3022);

-- ----- Editar Oficina -----

Delimiter $$
	Create procedure sp_EditarOficina ( in ofiID int,
										in direc varchar(256))
		Begin
			Update Oficinas O
				set O.direccion = direc
                where O.oficinaID = ofiID;
        End$$
Delimiter ;

/*Call sp_EditarOficina(3001, '5a Avenida 6-20, zona 1, Cobán');
Call sp_EditarOficina(3002, 'Calle del Comercio, Barrio San Pedro, Tactic');
Call sp_EditarOficina(3003, '3a Calle 2-35, zona 3, Chisec');
Call sp_EditarOficina(3004, '1a Avenida 1-30, zona 1, Salamá');
Call sp_EditarOficina(3005, 'Finca el Paraíso, km78 carretera a Cobán, Purulhá');
Call sp_EditarOficina(3006, '2a Calle 2-50, zona 2, San Miguel Chicaj');
Call sp_EditarOficina(3007, '6a Avenida 1-50, zona 1, Chimaltenango');
Call sp_EditarOficina(3008, '3a Calle 3-20, zona 2, San José Poaquil');
Call sp_EditarOficina(3009, '1a Calle 2-35, zona 3, Patzún');
Call sp_EditarOficina(3010, '4a Calle 4-20, zona 3, Jocotán');*/

-- ----- Eliminar Oficina -----

Delimiter $$
	Create procedure sp_EliminarOficina ( in ofiID int)
		Begin
			Delete from Oficinas
				where Oficinas.oficinaID = ofiID;
        End$$
Delimiter ;

-- ----- CRUD - Create - Read - Update - Delete -----
-- ----- Procedimientos almacenados para Telefonos -----
-- ----- Agregar Telefono -----

Delimiter $$
	Create procedure sp_AgregarTelefono ( in telID int,
										  in numTelefono varchar(15),
                                          in ofiID int)
		Begin
			Insert into Telefonos (telefonoID, numeroTelefono, oficinaID)
				values(telID, numTelefono, ofiID);
        End$$
Delimiter ;

Call sp_AgregarTelefono(4001, '5155-8495', 3050);
Call sp_AgregarTelefono(4002, '2521-9214', 3049);
Call sp_AgregarTelefono(4003, '8541-9591', 3048);
Call sp_AgregarTelefono(4004, '9638-2023', 3047);
Call sp_AgregarTelefono(4005, '8912-2041', 3046);
Call sp_AgregarTelefono(4006, '9843-3526', 3045);
Call sp_AgregarTelefono(4007, '5643-9320', 3044);
Call sp_AgregarTelefono(4008, '6348-6926', 3043);
Call sp_AgregarTelefono(4009, '9334-6105', 3042);
Call sp_AgregarTelefono(4010, '8918-6280', 3041);
Call sp_AgregarTelefono(4011, '0218-6208', 3040);
Call sp_AgregarTelefono(4012, '8428-6289', 3039);
Call sp_AgregarTelefono(4013, '8020-9218', 3038);
Call sp_AgregarTelefono(4014, '2002-9208', 3037);
Call sp_AgregarTelefono(4015, '9269-7152', 3036);
Call sp_AgregarTelefono(4016, '9831-7132', 3035);
Call sp_AgregarTelefono(4017, '3242-0550', 3034);
Call sp_AgregarTelefono(4018, '2152-0530', 3033);
Call sp_AgregarTelefono(4019, '8421-0460', 3032);
Call sp_AgregarTelefono(4020, '2814-7820', 3031);
Call sp_AgregarTelefono(4021, '1545-5621', 3030);
Call sp_AgregarTelefono(4022, '8221-5300', 3029);
Call sp_AgregarTelefono(4023, '6562-8959', 3028);
Call sp_AgregarTelefono(4024, '9230-5110', 3027);
Call sp_AgregarTelefono(4025, '9884-5157', 3026);
Call sp_AgregarTelefono(4026, '1512-0221', 3025);
Call sp_AgregarTelefono(4027, '1587-1515', 3024);
Call sp_AgregarTelefono(4028, '1414-6205', 3023);
Call sp_AgregarTelefono(4029, '1212-9502', 3022);
Call sp_AgregarTelefono(4030, '1331-1215', 3021);
Call sp_AgregarTelefono(4031, '1551-3310', 3020);
Call sp_AgregarTelefono(4032, '3622-3358', 3019);
Call sp_AgregarTelefono(4033, '6291-3004', 3018);
Call sp_AgregarTelefono(4034, '1724-8723', 3017);
Call sp_AgregarTelefono(4035, '8871-9620', 3016);
Call sp_AgregarTelefono(4036, '9821-9821', 3015);
Call sp_AgregarTelefono(4037, '1721-2085', 3014);
Call sp_AgregarTelefono(4038, '3626-2065', 3013);
Call sp_AgregarTelefono(4039, '1700-7820', 3012);
Call sp_AgregarTelefono(4040, '8250-1232', 3011);
Call sp_AgregarTelefono(4041, '2055-2324', 3010);
Call sp_AgregarTelefono(4042, '2366-3251', 3009);
Call sp_AgregarTelefono(4043, '1520-4561', 3008);
Call sp_AgregarTelefono(4044, '8266-4802', 3007);
Call sp_AgregarTelefono(4045, '9318-9820', 3006);
Call sp_AgregarTelefono(4046, '9217-4514', 3005);
Call sp_AgregarTelefono(4047, '7412-3212', 3004);
Call sp_AgregarTelefono(4048, '6315-4582', 3003);
Call sp_AgregarTelefono(4049, '9248-2124', 3002);
Call sp_AgregarTelefono(4050, '9294-1502', 3001);

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

Call sp_ListarTelefonos();

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

Call sp_BuscarTelefono(4050);

-- ----- Editar Telefono -----

Delimiter $$
	Create procedure sp_EditarTelefono ( in telID int,
										 in numTelefono varchar(15))
		Begin
			Update Telefonos T
				set T.numeroTelefono = numTelefono
                where T.telefonoID = telID;
        End$$
Delimiter ;

/*Call sp_EditarTelefono(4001, '8795-1280');
Call sp_EditarTelefono(4002, '0218-8151');
Call sp_EditarTelefono(4003, '8452-2182');
Call sp_EditarTelefono(4004, '8131-5412');
Call sp_EditarTelefono(4005, '2021-2021');
Call sp_EditarTelefono(4006, '3254-0578');
Call sp_EditarTelefono(4007, '0251-8523');
Call sp_EditarTelefono(4008, '7525-9630');
Call sp_EditarTelefono(4009, '7410-8552');
Call sp_EditarTelefono(4010, '8520-9623');*/


-- ----- Eliminar Telefono ----- 

Delimiter $$
	Create procedure sp_EliminarTelefono ( in telID int)
		Begin
			Delete from Telefonos
				where Telefonos.telefonoID = telID;
        End$$
Delimiter ;

-- ----- CRUD - Create - Read - Update - Delete -----
-- Procedimientos alcenados para Departamento Empresa -----
-- ----- Agregar DepartamentoEmpresa -----

Delimiter $$
	Create procedure sp_AgregarDepartamentoEmpresa ( in depEmpID int,
													 in nomDepartamento varchar(30),
                                                     in ofiID int)
		Begin
			Insert into DepartamentoEmpresa (departamentoEmpresaID, nombreDepartamento, oficinaID)
				values(depEmpID, nomDepartamento, ofiID);
        End$$
Delimiter ;

Call sp_AgregarDepartamentoEmpresa(5001, 'Mecanica', 3001);
Call sp_AgregarDepartamentoEmpresa(5002, 'Electricidad', 3002);
Call sp_AgregarDepartamentoEmpresa(5003, 'Arquitectura', 3003);
Call sp_AgregarDepartamentoEmpresa(5004, 'Desarrollo de software', 3004);
Call sp_AgregarDepartamentoEmpresa(5005, 'Quimica', 3005);
Call sp_AgregarDepartamentoEmpresa(5006, 'Diseñadores', 3006);
Call sp_AgregarDepartamentoEmpresa(5007, 'Desarrollo web', 3007);
Call sp_AgregarDepartamentoEmpresa(5008, 'Seguridad', 3008);
Call sp_AgregarDepartamentoEmpresa(5009, 'Enfermeria', 3009);
Call sp_AgregarDepartamentoEmpresa(5010, 'Abogados y notarios', 3010);
Call sp_AgregarDepartamentoEmpresa(5011, 'Publicidad', 3011);
Call sp_AgregarDepartamentoEmpresa(5012, 'Programacion', 3012);
Call sp_AgregarDepartamentoEmpresa(5013, 'Finanzas', 3013);
Call sp_AgregarDepartamentoEmpresa(5014, 'Proyectos', 3014);
Call sp_AgregarDepartamentoEmpresa(5015, 'Informatica', 3015);
Call sp_AgregarDepartamentoEmpresa(5016, 'Inspeccion calidad', 3016);
Call sp_AgregarDepartamentoEmpresa(5017, 'Inspeccion de produccion', 3017);
Call sp_AgregarDepartamentoEmpresa(5018, 'Recepcion', 3018);
Call sp_AgregarDepartamentoEmpresa(5019, 'Mantenimiento', 3019);
Call sp_AgregarDepartamentoEmpresa(5020, 'Reparacion computadoras', 3020);
Call sp_AgregarDepartamentoEmpresa(5021, 'Tecnologia', 3021);
Call sp_AgregarDepartamentoEmpresa(5022, 'Asistencia social', 3022);
Call sp_AgregarDepartamentoEmpresa(5023, 'Recursos humanos', 3023);
Call sp_AgregarDepartamentoEmpresa(5024, 'Marketing', 3024);
Call sp_AgregarDepartamentoEmpresa(5025, 'Desarrollo de productos', 3025);
Call sp_AgregarDepartamentoEmpresa(5026, 'Ciberseguridad', 3026);
Call sp_AgregarDepartamentoEmpresa(5027, 'Industrial', 3027);
Call sp_AgregarDepartamentoEmpresa(5028, 'Psicologia', 3028);
Call sp_AgregarDepartamentoEmpresa(5029, 'Sistemas', 3029);
Call sp_AgregarDepartamentoEmpresa(5030, 'Investigacion', 3030);
Call sp_AgregarDepartamentoEmpresa(5031, 'Seguros', 3031);
Call sp_AgregarDepartamentoEmpresa(5032, 'Consultas', 3032);
Call sp_AgregarDepartamentoEmpresa(5033, 'Departamento inmobiliario', 3033);
Call sp_AgregarDepartamentoEmpresa(5034, 'Analisis de datos', 3034);
Call sp_AgregarDepartamentoEmpresa(5035, 'Ventas', 3035);
Call sp_AgregarDepartamentoEmpresa(5036, 'Logistica', 3036);
Call sp_AgregarDepartamentoEmpresa(5037, 'Recursos humanos', 3037);
Call sp_AgregarDepartamentoEmpresa(5038, 'Marketing estrategico', 3038);
Call sp_AgregarDepartamentoEmpresa(5039, 'Calidad de producto', 3039);
Call sp_AgregarDepartamentoEmpresa(5040, 'Mantenimiento', 3040);
Call sp_AgregarDepartamentoEmpresa(5041, 'Analisis de datos', 3041);
Call sp_AgregarDepartamentoEmpresa(5042, 'Analisis de marketing', 3042);
Call sp_AgregarDepartamentoEmpresa(5043, 'Analisis de sistemas', 3043);
Call sp_AgregarDepartamentoEmpresa(5044, 'Desarrollo organizacional', 3044);
Call sp_AgregarDepartamentoEmpresa(5045, 'Analisis administrativo', 3045);
Call sp_AgregarDepartamentoEmpresa(5046, 'Secretaria', 3046);
Call sp_AgregarDepartamentoEmpresa(5047, 'Recepcion', 3047);
Call sp_AgregarDepartamentoEmpresa(5048, 'Planta', 3048);
Call sp_AgregarDepartamentoEmpresa(5049, 'Operacion de maquinas', 3049);
Call sp_AgregarDepartamentoEmpresa(5050, 'Inspeccion de calidad', 3050);-- ----- Listar Departamento Empresas -----

Delimiter $$
	Create procedure sp_ListarDepartamentosEmpresas ()
		Begin
			Select
				DE.departamentoEmpresaID, 
                DE.nombreDepartamento, 
                DE.oficinaID
                from DepartamentoEmpresa DE;
		End$$
Delimiter ;

Call sp_ListarDepartamentosEmpresas();

-- ----- Buscar Deparartamento Empresa -----

Delimiter $$
	Create procedure sp_BuscarDepartamentoEmpresa ( in depEmpID int)
		Begin
			Select 
				DE.departamentoEmpresaID, 
                DE.nombreDepartamento, 
                DE.oficinaID
                from DepartamentoEmpresa DE
					where DE.departamentoEmpresaID = depEmpID;
        End$$
Delimiter ;

Call sp_BuscarDepartamentoEmpresa(5050);

-- ----- Editar Departamento Empresa -----

Delimiter $$
	Create procedure sp_EditarDepartamentoEmpresa ( in depEmpID int,
													in nomDepartamento varchar(30))
		Begin
			Update DepartamentoEmpresa DE
				set DE.nombreDepartamento = nomDepartamento
				where DE.departamentoEmpresaID = depEmpID;
        End$$
Delimiter ;

/*Call sp_EditarDepartamentoEmpresa(5010, 'Control de ingresos');
Call sp_EditarDepartamentoEmpresa(5011, 'Informacion de datos');
Call sp_EditarDepartamentoEmpresa(5012, 'Administracion general');
Call sp_EditarDepartamentoEmpresa(5013, 'Supervision de proyectos Av.');
Call sp_EditarDepartamentoEmpresa(5014, 'Operaciones y produccion');
Call sp_EditarDepartamentoEmpresa(5015, 'Creatividad y marketing');
Call sp_EditarDepartamentoEmpresa(5016, 'Contabilidad');
Call sp_EditarDepartamentoEmpresa(5017, 'Recursos humanos Av.');
Call sp_EditarDepartamentoEmpresa(5018, 'Distribucion de ventas');
Call sp_EditarDepartamentoEmpresa(5020, 'Compras');
*/
-- ----- Eliminar Departamento Empresa -----

Delimiter $$
	Create procedure sp_EliminarDepartamentoEmpresa ( in depEmpID int)
		Begin
			Delete from DepartamentoEmpresa 
				where DepartamentoEmpresa.departamentoEmpresaID = depEmpID;
        End$$
Delimiter ;

-- ----- CRUD - Create - Read - Update - Delete -----
-- ----- Procedimientos almacenados para Empleados -----
-- ----- Agregar Empleado -----

Delimiter $$
	Create procedure sp_AgregarEmpleado ( in emplID int,
										  in nom varchar(45),
                                          in fechDeNac date,
                                          in telPersonal varchar(15),
                                          in fechDeContr date,
                                          in tipEmplID int,
                                          in departEmpID int)
		Begin
			Insert into Empleados ( empleadoID, 
									nombre, 
                                    fechaDeNacimiento, 
									telefonoPersonal, 
                                    fechaDeContratacion, 
                                    tipoEmpleadoID, 
                                    departamentoEmpresaID)
				values(emplID, nom, fechDeNac, telPersonal, fechDeContr, tipEmplID, departEmpID);
        End$$

Delimiter ;

Call sp_AgregarEmpleado(6001, 'Marco Antonio Gonzalez Viera', '1987-06-21', '1523-1541', '2010-06-15', 1001, 5001);
Call sp_AgregarEmpleado(6002, 'Autumn Jane Morales Sosa', '1985-01-07', '8745-3652', '2012-03-08', 1002, 5002);
Call sp_AgregarEmpleado(6003, 'Hector Maximiliano Lugo Franco', '1979-09-03', '6193-1811', '2008-11-01', 1003, 5003);
Call sp_AgregarEmpleado(6004, 'Zoey Jade Espinoza Maldonado', '1988-12-08', '9831-5411', '2014-09-23', 1004, 5004);
Call sp_AgregarEmpleado(6005, 'Miguel Angel Flores Villareal', '1982-04-14', '3214-0231', '2018-05-07', 1005, 5005);
Call sp_AgregarEmpleado(6006, 'Sofia Valentina Mata Garcia', '1977-07-29', '9782-2183', '2009-02-17', 1006, 5027);
Call sp_AgregarEmpleado(6007, 'Damian Alexander Huerta Gonzalez', '1985-11-16', '1283-2142', '2015-12-11', 1007, 5006);
Call sp_AgregarEmpleado(6008, 'Maya Celeste Navarro Garcia', '1988-02-28', '1252-2252', '2020-01-10', 1008, 5003);
Call sp_AgregarEmpleado(6009, 'Alexis Eduardo Garcia Cruz', '1981-05-11', '9872-3182', '2011-08-03', 1009, 5007);
Call sp_AgregarEmpleado(6010, 'Camila Victoria Maldonado Saenz', '1983-09-23', '1475-7842', '2016-06-08', 1010, 5027);
Call sp_AgregarEmpleado(6011, 'Tomas Federico Pacheco', '1989-03-20', '3652-5655', '2013-01-25', 1011, 5011);
Call sp_AgregarEmpleado(6012, 'Kira Noemi Jimenez Peña', '1986-03-12', '9874-3255', '2017-11-02', 1012, 5009);
Call sp_AgregarEmpleado(6013, 'Andres Gustavo Rios Aguirre', '1978-12-26', '1020-0325', '2007-06-20', 1013, 5009);
Call sp_AgregarEmpleado(6014, 'Aurora Natalia Castro Diaz', '1987-07-14', '1258-4560', '2014-02-12', 1014, 5010);
Call sp_AgregarEmpleado(6015, 'Rodrigo Santiago Peralta Robles', '1981-11-08', '3202-5612', '2018-08-28', 1015, 5011);
Call sp_AgregarEmpleado(6016, 'Joe Olivia Rojas Paredes', '1984-06-02', '7854-5452', '2021-02-15', 1016, 5011);
Call sp_AgregarEmpleado(6017, 'Leandro Sebastian Paredes', '1983-03-11', '9863-9312', '2009-09-29', 1017, 5003);
Call sp_AgregarEmpleado(6018, 'Stephany Nicole Estrada Gonzalez', '1987-09-05', '9631-1236', '2016-03-22', 1018, 5012);
Call sp_AgregarEmpleado(6019, 'Ruby Ysabel Montes Valenzuela', '1986-02-25', '8796-1236', '2006-05-17', 1019, 5004);
Call sp_AgregarEmpleado(6020, 'Cristobal Leonel Vega Mora', '1986-10-10', '5469-4523', '2012-11-09', 1020, 5018);
Call sp_AgregarEmpleado(6021, 'Lila Grabiela Espinoza Miranda', '1980-05-27', '1215-8966', '2015-08-19', 1021, 5028);
Call sp_AgregarEmpleado(6022, 'Joaquin Samuel Vazquez ', '1989-01-09', '6544-6655', '2020-06-12', 1022, 5029);
Call sp_AgregarEmpleado(6023, 'Stella Amelia Aguilar Solano', '1982-08-01', '4533-3323', '2013-05-06', 1023, 5030);
Call sp_AgregarEmpleado(6024, 'Hector Andres Rojas Alba', '1982-12-20', '2311-1225', '2018-01-07', 1024, 5013);
Call sp_AgregarEmpleado(6025, 'Fiona Mae Davis Navarro', '1975-04-15', '7895-2318', '2005-08-22', 1025, 5013);
Call sp_AgregarEmpleado(6026, 'Nicolas Emiliano Guerrero Reyes', '1989-11-11', '1214-3214', '2017-01-08', 1026, 5031);
Call sp_AgregarEmpleado(6027, 'Maya Isabel Chavez Fernandez', '1983-02-07', '6582-2158', '2018-02-22', 1027, 5032);
Call sp_AgregarEmpleado(6028, 'Oscar Gabriel Barajas Luna', '1980-07-12', '3650-2108', '2020-05-11', 1028, 5014);
Call sp_AgregarEmpleado(6029, 'Amara Rose Padilla Castro', '1986-09-14', '8792-2305', '2019-09-14', 1029, 5034);
Call sp_AgregarEmpleado(6030, 'Ismael Davis Sosa', '1987-04-30', '1021-2482', '2016-08-05', 1030, 5033);
Call sp_AgregarEmpleado(6031, 'Isaac Benjamin Rosales Rivas', '1985-05-28', '7895-2122', '2021-01-18', 1031, 5026);
Call sp_AgregarEmpleado(6032, 'Blanca Sofia de la Cruz', '1980-12-26', '2186-2218', '2018-11-03', 1032, 5015);
Call sp_AgregarEmpleado(6033, 'Eduardo Manuel Gallegos', '1988-08-09', '1238-1235', '2022-02-10', 1033, 5001);
Call sp_AgregarEmpleado(6034, 'Brynn Olivia Anderson Solis', '1977-01-13', '8921-2182', '2017-04-01', 1034, 5019);
Call sp_AgregarEmpleado(6035, 'Gael Alejandro Mirando Pinto', '1987-10-22', '1479-3642', '2016-07-20', 1035, 5020);
Call sp_AgregarEmpleado(6036, 'Hazel Caroline Alvarado Cruz', '1984-06-02', '8231-2182', '2019-11-29', 1036, 5007);
Call sp_AgregarEmpleado(6037, 'Aria Elise Franco Vargas', '1981-09-17', '2012-3218', '2015-11-11', 1037, 5021);
Call sp_AgregarEmpleado(6038, 'Marco Aurelio Aguilar', '1987-03-18', '8752-2050', '2022-01-05', 1038, 5009);
Call sp_AgregarEmpleado(6039, 'Adrian Mario Rodriguez Peña', '1978-11-29', '8521-2182', '2018-06-17', 1039, 5022);
Call sp_AgregarEmpleado(6040, 'Jose Ricardo Gomez Varela', '1985-05-12', '2152-3311', '2019-08-23', 1040, 5016);
Call sp_AgregarEmpleado(6041, 'Ava Noelle Corazon', '1982-12-06', '0099-9000', '2019-08-30', 1041, 5017);
Call sp_AgregarEmpleado(6042, 'Ramon Antonio Jirafales', '1982-07-27', '7820-1123', '2021-02-07', 1042, 5023);
Call sp_AgregarEmpleado(6043, 'Annabelle Gabriela Suran', '1988-04-02', '1236-5699', '2016-04-30', 1043, 5023);
Call sp_AgregarEmpleado(6044, 'Felix Jose de la Cruz', '1989-09-07', '7895-1745', '2020-10-19', 1044, 5024);
Call sp_AgregarEmpleado(6045, 'Clara Jose Moran Carrillo', '1986-03-25', '7894-4562', '2015-11-13', 1045, 5024);
Call sp_AgregarEmpleado(6046, 'Lucas Alarcon Ramirez Arroyo', '1983-12-01', '9874-6554', '2018-08-16', 1046, 5024);
Call sp_AgregarEmpleado(6047, 'Celine Elizabeth Harvey Reyes', '1983-01-01', '3214-6547', '2016-09-05', 1047, 5013);
Call sp_AgregarEmpleado(6048, 'Maximiliano Franco de la Joya', '1982-08-11', '8527-9512', '2011-05-28', 1048, 5012);
Call sp_AgregarEmpleado(6049, 'Diego Ricardo Solis Sosa', '1980-07-01', '7539-8539', '2019-06-10', 1049, 5012);
Call sp_AgregarEmpleado(6050, 'Victor Alvarez Perez Sosa', '1982-12-22', '8978-4213', '2022-11-11', 1050, 5012);

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
                E.tipoEmpleadoID, 
                E.departamentoEmpresaID
                from Empleados E;
        End$$
Delimiter ;

Call sp_ListarEmpleados();

-- ----- Buscar Empleado -----

Delimiter $$
	Create procedure sp_BuscarEmpleado ( in emplID int)
		Begin
			Select
				E.empleadoID, 
                E.nombre, 
                E.fechaDeNacimiento, 
                E.edad, 
                E.telefonoPersonal, 
                E.fechaDeContratacion, 
                E.tipoEmpleadoID, 
                E.departamentoEmpresaID
                from Empleados E
					where E.empleadoID = emplID;
        End$$
Delimiter ;

call sp_BuscarEmpleado(6008);

-- ----- Editar Empleado -----

Delimiter $$
	Create procedure sp_EditarEmpleado ( in emplID int,
										 in nom varchar(45),
                                         fechDeNac date,
                                         telPersonal varchar(15),
                                         fechDeContr date)
		Begin
			Update Empleados E
				set E.nombre = nom,
					E.fechaDeNacimiento = fechDeNac,
                    E.telefonoPersonal = telPersonal,
                    E.fechaDeContratacion = fechDeContr
                    where E.empleadoID = emplID;
        End$$
Delimiter ;

Call sp_EditarEmpleado(6001, 'Marco Tulio Reyes', '1985-02-12', '8726-5296', '2015-11-11');
Call sp_EditarEmpleado(6002, 'Margara de la rosa Pirir', '1983-07-14', '7415-2030', '2012-12-12');
Call sp_EditarEmpleado(6003, 'Jose Lopez de Pineda', '1983-12-02', '7410-5202', '2011-10-11');
Call sp_EditarEmpleado(6004, 'Mario Rene Duarte Sosa', '1984-11-07', '7410-5204', '2009-02-22');
Call sp_EditarEmpleado(6005, 'Mario Recinos Suarez Sal', '1988-10-05', '9652-8520', '2011-08-09');
Call sp_EditarEmpleado(6006, 'Ana Elizabeth Gonzalez', '1980-01-11', '7860-7415', '2015-05-14');
Call sp_EditarEmpleado(6007, 'Daniel Jose Garcia Galino', '1986-03-08', '8520-7542', '2019-12-24');
Call sp_EditarEmpleado(6008, 'Gary Galindo Miranda', '1989-04-02', '9521-9601', '2015-10-01');
Call sp_EditarEmpleado(6009, 'Yojahan Stanley Garcia Palencia', '1985-06-05', '7852-7895', '2010-10-10');
Call sp_EditarEmpleado(6010, 'Rodrigo Chanquin Linux', '1984-11-11', '7410-2850', '2008-11-11');

-- ----- Funcion para calcular edad -----

Delimiter $$
	Create function fn_EdadEmpleados(fechaDeNac date)RETURNS int
		READS SQL DATA DETERMINISTIC
        Begin
            declare edad int;
            set edad = 2023 - year(fechaDeNac);
            return edad;
        End$$
Delimiter ;

-- ----- Editar Edades -----

Delimiter $$
	Create procedure sp_EditarEdad ( in emplID int)
		Begin
			Update Empleados E
				set E.edad = fn_EdadEmpleados(E.fechaDeNacimiento)
					where E.empleadoID = emplID;
        End$$
Delimiter ;

Call sp_EditarEdad(6001);
Call sp_EditarEdad(6002);
Call sp_EditarEdad(6003);
Call sp_EditarEdad(6004);
Call sp_EditarEdad(6005);
Call sp_EditarEdad(6006);
Call sp_EditarEdad(6007);
Call sp_EditarEdad(6008);
Call sp_EditarEdad(6009);
Call sp_EditarEdad(6010);
Call sp_EditarEdad(6011);
Call sp_EditarEdad(6012);
Call sp_EditarEdad(6013);
Call sp_EditarEdad(6014);
Call sp_EditarEdad(6015);
Call sp_EditarEdad(6016);
Call sp_EditarEdad(6017);
Call sp_EditarEdad(6018);
Call sp_EditarEdad(6019);
Call sp_EditarEdad(6020);
Call sp_EditarEdad(6021);
Call sp_EditarEdad(6022);
Call sp_EditarEdad(6023);
Call sp_EditarEdad(6024);
Call sp_EditarEdad(6025);
Call sp_EditarEdad(6026);
Call sp_EditarEdad(6027);
Call sp_EditarEdad(6028);
Call sp_EditarEdad(6029);
Call sp_EditarEdad(6030);
Call sp_EditarEdad(6031);
Call sp_EditarEdad(6032);
Call sp_EditarEdad(6033);
Call sp_EditarEdad(6034);
Call sp_EditarEdad(6035);
Call sp_EditarEdad(6036);
Call sp_EditarEdad(6037);
Call sp_EditarEdad(6038);
Call sp_EditarEdad(6039);
Call sp_EditarEdad(6040);
Call sp_EditarEdad(6041);
Call sp_EditarEdad(6042);
Call sp_EditarEdad(6043);
Call sp_EditarEdad(6044);
Call sp_EditarEdad(6045);
Call sp_EditarEdad(6046);
Call sp_EditarEdad(6047);
Call sp_EditarEdad(6048);
Call sp_EditarEdad(6049);
Call sp_EditarEdad(6050);

-- ----- Eliminar Empleado -----

Delimiter $$
	Create procedure sp_EliminarEmpleado ( in emplID int)
		Begin
			Delete from Empleados
				where Empleados.empleadoID = emplID;
        End$$
Delimiter ;

/*-- ----- Eliminar de Empleados -----

Call sp_EliminarEmpleado(6031);
Call sp_EliminarEmpleado(6033);
Call sp_EliminarEmpleado(6035);
Call sp_EliminarEmpleado(6036);
Call sp_EliminarEmpleado(6019);

-- ----- Eliminar Departamento Empresa -----

Call sp_EliminarDepartamentoEmpresa(5019);
Call sp_EliminarDepartamentoEmpresa(5043);
Call sp_EliminarDepartamentoEmpresa(5044);
Call sp_EliminarDepartamentoEmpresa(5046);
Call sp_EliminarDepartamentoEmpresa(5048);

-- ----- Eliminar Telefono -----

Call sp_EliminarTelefono(4003);
Call sp_EliminarTelefono(4005);
Call sp_EliminarTelefono(4007);
Call sp_EliminarTelefono(4008);
Call sp_EliminarTelefono(4032);

-- ----- Eliminar Oficina -----

Call sp_EliminarOficina(3019);
Call sp_EliminarOficina(3043);
Call sp_EliminarOficina(3044);
Call sp_EliminarOficina(3046);
Call sp_EliminarOficina(3048);

-- ----- Eliminar Departamento -----

Call sp_EliminarDepartamento(2007);
Call sp_EliminarDepartamento(2018);
Call sp_EliminarDepartamento(2020);
Call sp_EliminarDepartamento(2015);
Call sp_EliminarDepartamento(2016);

-- ----- Eliminar Tipo Empleado -----

Call sp_EliminarTipoEmpleado(1019);
Call sp_EliminarTipoEmpleado(1036);
Call sp_EliminarTipoEmpleado(1035);
Call sp_EliminarTipoEmpleado(1033);
Call sp_EliminarTipoEmpleado(1031);

-- ----- Eliminar Region -----

Call sp_EliminarRegion(101);
Call sp_EliminarRegion(105);
Call sp_EliminarRegion(108);
Call sp_EliminarRegion(107);
Call sp_EliminarRegion(102);*/

-- Funcion calcular el 2% anual -----

Delimiter $$
	Create function fn_Calcular2PorCiento(sueldo decimal(10,2))RETURNS decimal(10,2)
		READS SQL DATA DETERMINISTIC
        Begin
			declare sueldoAumentado decimal(10,2);
            set sueldoAumentado = sueldo * 1.02;
            return sueldoAumentado;
        End$$
Delimiter ;

-- ----- Funcion sumar sueldo y bonificacion -----

Delimiter $$
	Create function fn_SueldoTotal(sueldoBase decimal(10,2), bonificacion decimal(10,2), bonificacionEmpresa decimal(10,2))RETURNS decimal(10,2)
		READS SQL DATA DETERMINISTIC
		Begin
			declare resultado decimal(10,2);
            declare sueldoTotal decimal(10,2);
            set resultado = bonificacion + bonificacionEmpresa;
            set sueldoTotal = sueldoBase + resultado;
            return sueldoTotal;
        End$$
Delimiter ;

-- 1) Nombre y edad de los empleados.

Select E.empleadoID, E.nombre as Nombre_Del_Empleado, E.edad as Edad_Del_Empleado from Empleados E; 

-- 2) Salario de [categoría] si suponemos un aumento del 2% anual (calcular liquidación de empleado).

Select fn_Calcular2PorCiento(TE.sueldoBase) as Liquidacion_Empleado from TipoEmpleado TE;

-- 3)Fecha de contratación de cada empleado.

Select E.empleadoID as Empleado_ID, E.nombre as Nombre_Del_Empleado, E.fechaDeContratacion as Fecha_De_Contratacion
	from Empleados E;
    
-- 4) Edades de los empleados.

Select E.empleadoID as EmpleadoID, E.nombre as Nombre_Del_Empleado, E.edad as Edad_Del_Empleado
	from Empleados E;
    
-- 5) Número de empleados que hay para cada una de las edades.

Select Empleados.edad as Edades, count(*) as NumeroDeEdades from Empleados group by Empleados.edad;

-- 6) Edad media de los empleados por departamento.

Select departamento, avg(E.edad) as Promedio_Edad from Empleados E INNER JOIN  DepartamentoEmpresa DE
	on DE.departamentoEmpresaID = E.departamentoEmpresaID
		INNER JOIN Oficinas O on O.oficinaID = DE.oficinaID
			INNER JOIN Departamentos D on D.departamentoID = O.departamentoID group by departamento;

-- 7) Categorías profesionales que superan los 35.000 de salario.

Select TE.codigoTipoEmpleadoID as CodigoTipoEmpleado, TE.nombreTipoEmpleado as NombreTipoEmpleado, TE.sueldoBase as SueldoBase 
	from TipoEmpleado TE where TE.sueldoBase > 35000.00;

-- 8) Datos del empleado número X.

Select E.empleadoID, E.nombre, E.fechaDeNacimiento, E.edad, E.telefonoPersonal, E.fechaDeContratacion, TE.nombreTipoEmpleado as TipoEmpleado, 
	DE.nombreDepartamento as NombreDepartamento from Empleados E INNER JOIN TipoEmpleado TE
		on TE.codigoTipoEmpleadoID = E.tipoEmpleadoID
			INNER JOIN DepartamentoEmpresa DE on DE.departamentoEmpresaID = E.departamentoEmpresaID;

-- 9) Empleado del departamento X.

Select E.empleadoID as CodigoEmpleado, E.nombre as NombreEmpleado, D.departamento as Departamento from Empleados E INNER JOIN DepartamentoEmpresa DE
	on DE.departamentoEmpresaID = E.departamentoEmpresaID
		INNER JOIN Oficinas O on O.oficinaID = DE.oficinaID
			INNER JOIN Departamentos D on D.departamentoID = O.departamentoID 
				where D.departamento = 'Guatemala';

-- 10) Empleados cuya contratación se produjo en el año X.

Select E.empleadoID as CodigoEmpleado, E.nombre as NombreEmpleado, E.fechaDeContratacion as FechaDeContratacion 
	from Empleados E where E.fechaDeContratacion like '%2011%';
    
-- 11) Empleados que no sean jefe de sección de la categoría X.

Select E.nombre, DE.nombreDepartamento, if(TE.nombreTipoEmpleado =
	TE.nombreTipoEmpleado like '% Comun', 'Ordinario', 'Normal') as Rango from Empleados E
		INNER JOIN DepartamentoEmpresa DE on DE.departamentoEmpresaID = E.departamentoEmpresaID
			INNER JOIN TipoEmpleado TE on TE.codigoTipoEmpleadoID = E.tipoEmpleadoID
				where TE.sueldoBase <= 49000.00 and DE.nombreDepartamento = 'Programacion'
				order by DE.nombreDepartamento, Rango desc;   

-- 12) Empleados contratados entre los años X y X.

Select E.empleadoID as CodigoEmpleado, E.nombre as NombreEmpleado, E.fechaDeContratacion as FechaDeContratacion 
	from Empleados E where E.fechaDeContratacion between '2011-01-01' and '2015-12-31';

-- 13) Categorías que tienen un salario inferior a 35.000.

Select TE.codigoTipoEmpleadoID as TipoEmpleadoID, TE.nombreTipoEmpleado as NombreTipoCategoria, TE.sueldoBase as SueldoInferior
	from TipoEmpleado TE where TE.sueldoBase < 35000.00;

-- categorías cuyo salario es superior a 40.000.

Select TE.codigoTipoEmpleadoID as TipoEmpleadoID, TE.nombreTipoEmpleado as NombreTipoCategoria, TE.sueldoBase as SueldoSuperior
	from TipoEmpleado TE where TE.sueldoBase > 40000.00;

-- 14) Empleados cuya categoría es director o jefe de sección

Select E.nombre, DE.nombreDepartamento, if(TE.nombreTipoEmpleado =
	TE.nombreTipoEmpleado like '% Jefe de seccion', 'Director', 'Jefe de seccion') as Rango from Empleados E
		INNER JOIN DepartamentoEmpresa DE on DE.departamentoEmpresaID = E.departamentoEmpresaID
			INNER JOIN TipoEmpleado TE on TE.codigoTipoEmpleadoID = E.tipoEmpleadoID
				where TE.sueldoBase >= 50000.00
				order by DE.nombreDepartamento, Rango desc;   
 

-- 15) Empleados de nombre Jose.

Select E.empleadoID as CodigoEmpleado, E.nombre as Nombre from Empleados E
	where E.nombre like '%Jose%';
    
-- 16) Empleados que pertenecen a la categoría de administrativo y que tienen una edad mayor de 35 años.

Select E.empleadoID, E.nombre, TE.nombreTipoEmpleado from Empleados E INNER JOIN TipoEmpleado TE
	on TE.codigoTipoEmpleadoID = E.tipoEmpleadoID
		where TE.nombreTipoEmpleado like '%administrativo%' and E.edad > 35;
        
-- 17) Empleados que no pertenecen al departamento X.

Select E.empleadoID, E.nombre, D.departamento from Empleados E INNER JOIN DepartamentoEmpresa DE
	on DE.departamentoEmpresaID = E.departamentoEmpresaID
		INNER JOIN Oficinas O on O.oficinaID = DE.oficinaID
			INNER JOIN Departamentos D on D.departamentoID = O.departamentoID
				where D.departamento != 'Petén';
                
-- 18) Nombre y edad de los empleados ordenados de menor a mayor.

Select E.empleadoID, E.nombre, E.edad from Empleados E order by edad asc;

-- 19) Nombre y edad de los empleados ordenados por nombre de forma descendente.

Select E.empleadoID, E.nombre, E.edad from Empleados E order by edad desc;

-- 20) Nombre del empleado y de la categoría en la que trabaja.

Select E.empleadoID, E.nombre, TE.nombreTipoEmpleado from Empleados E INNER JOIN TipoEmpleado TE
	on TE.codigoTipoEmpleadoID = E.tipoEmpleadoID;
        
-- 21) Código y teléfonos de los departamentos de las oficinas de la region 'Centro'.

Select D.departamentoID, D.departamento, T.numeroTelefono, O.direccion from Telefonos T INNER JOIN Oficinas O
	on O.oficinaID = T.oficinaID 
		INNER JOIN Departamentos D on D.departamentoID = O.departamentoID
			INNER JOIN Regiones R on R.regionID = D.regionID
				where R.nombreRegion = 'Central';
                
-- 22) Nombre del empleado y departamento en la que trabaja.

Select E.empleadoID, E.nombre, DE.nombreDepartamento from Empleados E INNER JOIN DepartamentoEmpresa DE
	on DE.departamentoEmpresaID = E.departamentoEmpresaID;

-- 23) Sueldo de cada empleado y su bonificación. 

Select E.empleadoID, E.nombre, TE.sueldoBase, TE.bonificacion + TE.bonificacionEmpresa as SumaBonificaciones, 
	TE.sueldoBase + TE.bonificacion + TE.bonificacionEmpresa as SueldoTotal from Empleados E INNER JOIN TipoEmpleado TE
		on TE.codigoTipoEmpleadoID = E.tipoEmpleadoID;

-- 24) Nombre de los empleados y de sus jefes de sección.

Select E.nombre, DE.nombreDepartamento, if(TE.nombreTipoEmpleado =
	TE.nombreTipoEmpleado like '% Jefe', 'Jefe de seccion', 'Jefe') as Rango from Empleados E
		INNER JOIN DepartamentoEmpresa DE on DE.departamentoEmpresaID = E.departamentoEmpresaID
			INNER JOIN TipoEmpleado TE on TE.codigoTipoEmpleadoID = E.tipoEmpleadoID
				where TE.sueldoBase >= 50000.00
				order by DE.nombreDepartamento, Rango desc;

			
-- 25) Suma del sueldo de los empleados, sin la bonificacion.

Select sum(TE.sueldoBase) as TotalSuma from TipoEmpleado TE;

-- 26) Promedio del sueldo, sin contar bonificacion.

Select avg(TE.sueldoBase) as Promedio from TipoEmpleado TE;

-- 27) Salarios máximo y mínimo de los empleados, incluyendo bonificación.

Select (select max(fn_SueldoTotal(TE.sueldoBase,TE.bonificacion,TE.bonificacionEmpresa))) as SalarioMaximo, 
	(select min(fn_SueldoTotal(TE.sueldoBase,TE.bonificacion,TE.bonificacionEmpresa))) as SalarioMinimo
		from Empleados E INNER JOIN TipoEmpleado TE 
			on TE.codigoTipoEmpleadoID = E.tipoEmpleadoID;
            
-- 28) Número de empleados que superan los 40 años.

Select count(E.edad) as Cantidad_Empleados_De_Mas_De_40_años from Empleados E
	where E.edad >= 40;

-- 29) Número de edades diferentes que tienen los empleados.

Select count(distinct E.edad) as Cantidad from Empleados E ;

-- 30) Suma de los sueldos por departamento de los empleados, sin contar bonificación, de cada oficina.

Select D.departamento, sum(TE.sueldoBase) as SumaPorDepartamento from Empleados E INNER JOIN TipoEmpleado TE
	on TE.codigoTipoEmpleadoID = E.tipoEmpleadoID
		INNER JOIN DepartamentoEmpresa DE on DE.departamentoEmpresaID = E.departamentoEmpresaID
			INNER JOIN Oficinas O on O.oficinaID = DE.oficinaID
				INNER JOIN Departamentos D on D.departamentoID = O.departamentoID group by departamento;
