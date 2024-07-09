/*Edwar René Chamalé González
Quinto perito en computacion Jornada: vespertina
IN5BV
Fecha: 16/02/2023 Hora: 14:15:00pm*/
Drop database if exists DBEjemploFunciones2022222;
Create database DBEjemploFunciones2022222;

Use DBEjemploFunciones2022222;

Create table Datos(
	codigoDato int not null auto_increment,
    num1 int not null,
    num2 int not null,
    suma int,
    resta int,
    multiplicacion int,
    division int,
    primary key PK_codigoDato (codigoDato)
);

-- ----- Agregar -----

Delimiter $$
	Create procedure sp_AgregarDato ( in n1 int, in n2 int)
		Begin
			Insert into Datos(num1, num2)
				values(n1, n2);
        End$$
Delimiter ;

call sp_AgregarDato(3,5);

-- ----- Listar -----

Delimiter $$
	Create procedure sp_ListarDatos ()
		Begin 
			Select 
				D.codigoDato, 
                D.num1, 
                D.num2, 
                D.suma, 
                D.resta, 
                D.multiplicacion, 
                D.division
                from Datos D;
        End$$
Delimiter ;

call sp_ListarDatos();

Select D.num1 + D.num2 as Resultado from Datos D;

-- ----- Funcion de suma -----

Delimiter $$
	Create function fn_Sumatoria (valor1  int, valor2 int) RETURNS int
		READS SQL DATA DETERMINISTIC
        Begin
			declare result int;
            set result = valor1 + valor2;
            return result;
        End$$
Delimiter ;

select fn_Sumatoria(3,5) as Sumatoria;

-- ----- Editar dato -----

Delimiter $$
	Create procedure sp_SumarDato ( in codDato int)
    Begin
		update Datos D
			set D.suma = fn_Sumatoria(D.num1, D.num2)
			where D.codigoDato = codDato;
	End$$
Delimiter ;

call sp_SumarDato(1);
call sp_ListarDatos();

-- ----- Funcion Resta -----
Delimiter $$
	Create function fn_Resta(valor1 int, valor2 int) RETURNS int
		READS SQL DATA DETERMINISTIC
        Begin
			declare result int;
            set result = valor1 - valor2;
            return result;
        End$$
Delimiter ;

-- ----- Editar resta -----

Delimiter $$
	Create procedure sp_EditarResta ( in codDato int)
		Begin
			Update Datos D
				set D.resta = fn_Resta(D.num1, D.num2)
                where codigoDato = codDato;
        End$$
Delimiter ;

call sp_EditarResta(1);
call sp_ListarDatos();

-- ----- Funcion multiplicacion -----

Delimiter $$
	Create function fn_Multiplicacion(valor1 int, valor2 int)RETURNS int
		READS SQL DATA DETERMINISTIC
        Begin 
			declare result int;
            set result = valor1 * valor2;
            return result;
        End$$
Delimiter ;

-- ----- Editar multiplicacion -----

Delimiter $$
	Create procedure sp_EditarMultiplicacion ( in codDato int)
		Begin
			Update Datos D
				set D.multiplicacion = fn_Multiplicacion(D.num1, D.num2)
                where codigoDato = codDato;
        End$$
Delimiter ;

-- ----- Funcion DIV y MOD -----

Delimiter $$
	Create function fn_DivMod(valor1 int, valor2 int)RETURNS varchar(150)
		READS SQL DATA DETERMINISTIC
        Begin
			declare cociente int;
            declare residuo int;
            declare mensaje varchar(150);
            set cociente = valor1 div valor2;
            set residuo = valor1 % valor2;
            set mensaje = concat('El cociente es: ', cociente, ' El residuo es: ', residuo);
            return mensaje;
        End$$
Delimiter ;
call sp_EditarMultiplicacion(1);
    
call sp_ListarDatos();

-- ----- resultado raiz 2 -----

Delimiter $$
	Create function fn_Raiz1(a int, b int, c int)RETURNS decimal
		READS SQL DATA DETERMINISTIC
		Begin
			return (-b+sqrt((b*b)-(4*a*c)))/(2*a);
        End$$
Delimiter ;

-- ----- resultado raiz -----

Delimiter $$
	Create function fn_Raiz2(a int, b int, c int)RETURNS decimal
		READS SQL DATA DETERMINISTIC
		Begin
			declare resultado decimal;
            declare numerador decimal;
            declare denominador decimal;
            set numerador = -b - sqrt((b*b)-(4*a*c));
            set denominador = 2*a;
            set resultado = numerador / denominador;
            return resultado;
        End$$
Delimiter ;

select fn_Raiz1(3,5,2) as Raiz_1;
select fn_Raiz2(3,5,2) as Raiz_2;

Delimiter $$
	Create function fn_RaizDecimales(a int, b int, c int)RETURNS double(10,5)
		READS SQL DATA DETERMINISTIC
		Begin
			/*declare resultado double(10,5);
            declare numerador double(10,5);
            declare denominador double(10,5);
            set numerador = -b - sqrt((b*b)-(4*a*c));
            set denominador = 2*a;
            set resultado = numerador / denominador;*/
            return (-b+sqrt((b*b)-(4*a*c)))/(2*a);
        End$$
Delimiter ;

select fn_RaizDecimales(3,5,2) as Raiz_Decimales;


Delimiter $$
	Create function fn_MayorDeDos(valor1 int, valor2 int)RETURNS int
		READS SQL DATA DETERMINISTIC
        Begin	
			if (valor1 > valor2) then
				return valor1;
			end if;
            if (valor2 > valor1) then
				return valor2;
			end if;
            if (valor1 = valor2) then
				return valor1;
			end if;
        End$$
Delimiter ;

select fn_MayorDeDos(12,12) as Resultado;
select fn_MayorDeDos(51,51) as Mayor;