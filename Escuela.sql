Drop database if exists Escuela;

Create database Escuela;

Use Escuela;

Create table Estudiantes(
	codigoEstudiante int not null auto_increment,
    nombreEstudiante varchar(50) not null,
    apellidoEstudiante varchar(50) not null,
    fechaNacimiento date not null,
    direccionEstudiante varchar(256) not null,
    telefonoEstudiante varchar(10) not null,
    correoEstudiante varchar(60) not null,
    primary key PK_codigoEstudiante (codigoEstudiante)
);

Create table Profesores(
	codigoProfesor int not null auto_increment,
    nombreProfesor varchar(50) not null,
    apellidoProfesor varchar(50) not null,
    fechaNacimiento date not null,
    direccionProfesor varchar(256) not null,
    telefonoProfesor varchar(10) not null,
    correoProfesor varchar(60) not null,
    asignatura varchar(60) not null,
    primary key PK_codigoProfesor (codigoProfesor)
);

Create table Cursos(
	codigoCurso int not null auto_increment,
    nombreCurso varchar(60) not null,
    descripcionCurso varchar(256) not null,
    horario time not null,
    codigoProfesor int not null,
    primary key PK_codigoCurso (codigoCurso),
    constraint FK_Cursos_Profesores foreign key (codigoProfesor)
		references Profesores (codigoProfesor) on delete cascade
);

Create table Asignaturas(
	codigoAsignatura int not null auto_increment,
    nombreAsignatura varchar(50) not null,
    descripcionAsignatura varchar(80) not null,
    primary key PK_codigoAsignatura (codigoAsignatura)
);

Create table Notas(
	codigoNota int not null auto_increment,
    codigoEstudiante int not null,
    codigoAsignatura int not null,
    codigoProfesor int not null,
    calificacion int not null,
    primary key PK_codigoNota (codigoNota),
    constraint FK_Notas_Estudiantes foreign key (codigoEstudiante)
		references Estudiantes(codigoEstudiante) on delete cascade,
	constraint FK_Notas_Asignaturas foreign key (codigoAsignatura) 
		references Asignaturas (codigoAsignatura) on delete cascade,
	constraint FK_Notas_Profesores foreign key (codigoProfesor) 
		references Profesores (codigoProfesor) on delete cascade
);

INSERT INTO Estudiantes (nombreEstudiante, apellidoEstudiante, fechaNacimiento, direccionEstudiante, telefonoEstudiante, correoEstudiante)
VALUES
    ('Juan', 'Perez', '2000-05-15', '123 Calle Principal', '1234567890', 'juan@example.com'),
    ('María', 'González', '2001-08-20', '456 Calle Secundaria', '9876543210', 'maria@example.com'),
    ('Luis', 'Martínez', '1999-03-08', '789 Avenida Principal', '5555555555', 'luis@example.com'),
    ('Sofía', 'Rodríguez', '2002-12-30', '321 Calle Secundaria', '9998887777', 'sofia@example.com'),
    ('Pedro', 'Sánchez', '1998-09-05', '555 Avenida Principal', '7777777777', 'pedro@example.com');

INSERT INTO Profesores (nombreProfesor, apellidoProfesor, fechaNacimiento, direccionProfesor, telefonoProfesor, correoProfesor, asignatura)
VALUES
    ('Carlos', 'Ramírez', '1985-03-10', '789 Avenida Principal', '5551112222', 'carlos@example.com', 'Matemáticas'),
    ('Ana', 'López', '1978-11-25', '456 Calle Secundaria', '7777777777', 'ana@example.com', 'Historia'),
    ('Luisa', 'García', '1980-06-15', '123 Calle Principal', '8888888888', 'luisa@example.com', 'Ciencias'),
    ('Javier', 'Fernández', '1987-09-02', '654 Avenida Secundaria', '9999999999', 'javier@example.com', 'Inglés'),
    ('Marta', 'Torres', '1975-04-18', '987 Calle Principal', '6666666666', 'marta@example.com', 'Física');

INSERT INTO Cursos (nombreCurso, descripcionCurso, horario, codigoProfesor)
VALUES
    ('Matemáticas 101', 'Curso introductorio de matemáticas', '08:00:00', 1),
    ('Historia del Mundo', 'Historia universal desde la antigüedad', '10:30:00', 2),
    ('Ciencias Naturales', 'Estudio de la naturaleza y el entorno', '14:15:00', 3),
    ('Inglés Avanzado', 'Clases de inglés avanzado', '16:45:00', 4),
    ('Física Moderna', 'Estudio de la física contemporánea', '12:00:00', 5);

INSERT INTO Asignaturas (nombreAsignatura, descripcionAsignatura)
VALUES
    ('Matemáticas', 'Curso de matemáticas avanzadas'),
    ('Historia', 'Historia universal desde la antigüedad'),
    ('Ciencias Naturales', 'Estudio de la naturaleza y el entorno'),
    ('Inglés', 'Clases de inglés avanzado'),
    ('Física', 'Estudio de la física moderna');

INSERT INTO Notas (codigoEstudiante, codigoAsignatura, codigoProfesor, calificacion)
VALUES
    (1, 1, 1, 90),
    (2, 2, 2, 85),
    (3, 3, 3, 92),
    (4, 4, 4, 88),
    (5, 5, 5, 95);