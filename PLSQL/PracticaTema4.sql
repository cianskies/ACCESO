--1.Simple, los telefonos que puede tener cada alumno son un array de 9 numeros.
CREATE OR REPLACE TYPE VTELEFONOS AS VARRAY(2) OF NUMBER(9);
/
--2.La nota es un numero
CREATE OR REPLACE TYPE NOTA AS OBJECT(
	NOTA NUMBER(4,2)
);
/
--3.La direccion del alumno es un tipo
CREATE OR REPLACE TYPE DIRECCION AS OBJECT(
	CALLE VARCHAR2(50),
	POBLACION VARCHAR2(50),
	CODPOSTAL NUMBER(5)
);
/

--4.Todas las notas que tiene un alumno en cada asignatura
CREATE OR REPLACE TYPE NOTASASIGNATURA AS OBJECT(
	DNI VARCHAR2(10),
	CODIGO_ASIG NUMBER(4),
	NOTA1EV NOTA,
	NOTA2EV NOTA,
	NOTA3EV NOTA,
	NOTAFJUN NOTA,
	NOTASEPT NOTA
	--definir funciones--
 );
 
--5.Hay un array donde recibe todas las notas, se puede obtener con una funcion
CREATE OR REPLACE TYPE VNOTASASIGNATURA AS VARRAY(5) OF NOTA;
/
--6.tabla de notas y asignaturas para guardar todas las asignaturas que puede tener un alumno
 CREATE OR REPLACE TYPE TNOTAS AS TABLE OF NOTASASIGNATURA;
/
--7.Crear el tipo alumno
CREATE OR REPLACE TYPE ALUMNO AS OBJECT(
	DNI VARCHAR2(10),
	NOMBRE VARCHAR2(50),
	DIREC DIRECCION,
	TELF VTELEFONOS,
	FECHA_NAC DATE,
	ID_CURSO NUMBER(4),
	CALIFICACIONES TNOTAS
);
/

--8.La asignatura como objeto
CREATE OR REPLACE TYPE ASIGNATURA AS OBJECT(
	COD_ASIG NUMBER(4),
	NOMBRE VARCHAR2(80),
	TIPO CHAR(1)
);
/

--9.Curso
CREATE OR REPLACE TYPE CURSO AS OBJECT(
	ID_CURSO NUMBER(4),
	DESCRIPCION VARCHAR2(60),
	NIVEL VARCHAR2(30),
	TURNO CHAR(1)
);
/
--1--
CREATE OR REPLACE TYPE TASIGNATURAS AS TABLE OF ASIGNATURA;
/
--2--
CREATE OR REPLACE TYPE TCURSOS AS TABLE OF CURSO;
/
--3--
CREATE OR REPLACE TYPE TALUMNOS AS TABLE OF ALUMNO;
/

---------------------------
---------------------------
---DECLARACIONES-----------

DECLARE
	--Hay que empezar la casa por el tejado, primero hacer los cursos y
	--las asignaturas, las inicializamos aqui y los alumnos en el begin.
	CURSO1 CURSO:=CURSO(1,"Primer curso","Basico",0);
	CURSO2 CURSO:=CURSO(2,"Segundo curso","Basico",1);
	CURSO3 CURSO:=CURSO(3,"Tercer curso","Intermedio",1);
	CURSO4 CURSO:=CURSO(4,"Cuarto curso","Avanzado",0);
	/*---*/
	ASIG1 ASIGNATURA:=ASIGNATURA(0001,"Lengua",1);
	ASIG1 ASIGNATURA:=ASIGNATURA(0001,"Lengua",1);
	ASIG1 ASIGNATURA:=ASIGNATURA(0001,"Lengua",1);
	ASIG1 ASIGNATURA:=ASIGNATURA(0001,"Lengua",1);
	ASIG1 ASIGNATURA:=ASIGNATURA(0001,"Lengua",1);
	ASIG1 ASIGNATURA:=ASIGNATURA(0001,"Lengua",1);
	/*---*/
	LUIS ALUMNO,
	JOSE ALUMNO,
	MARIA ALUMNO,
	CELIA ALUMNO,
	JORGE ALUMNO,
	MANUEL ALUMNO,
	LUCIA ALUMNO
BEGIN

END;
/