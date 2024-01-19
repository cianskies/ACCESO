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
 /
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
	-- Hay que empezar la casa por el tejado, primero hacer los cursos y
	-- las asignaturas, las inicializamos aquí y los alumnos en el BEGIN.
	CURSOS TCURSOS := TCURSOS(
		CURSO(1, 'Primer curso', 'Basico', '0'),
		CURSO(2, 'Segundo curso', 'Basico', '1'),
		CURSO(3, 'Tercer curso', 'Intermedio', '1'),
		CURSO(4, 'Cuarto curso', 'Avanzado', '0')
	);

	ASIGNATURAS TASIGNATURAS := TASIGNATURAS(
		ASIGNATURA(0001, 'Lengua', '1'),
		ASIGNATURA(0002, 'Mates', '1'),
		ASIGNATURA(0003, 'Ingles', '1'),
		ASIGNATURA(0004, 'Naturales', '2'),
		ASIGNATURA(0005, 'Sociales', '2'),
		ASIGNATURA(0006, 'Fisica', '2')
	);

	ALUMNOS TALUMNOS := TALUMNOS();

	LUIS ALUMNO := ALUMNO(
		'56195364Q',
		'Luis',
		DIRECCION('Calle Versalles', 'Mostoles', 28931),
		VTELEFONOS(641018078, 671779646),
		TO_DATE('01-FEB-2013', 'DD-MON-YYYY'),
		1,
		TNOTAS(
			NOTASASIGNATURA('56195364Q', 0001, NOTA(4), NOTA(5), NOTA(4), NOTA(6), NOTA(6)),
			NOTASASIGNATURA('56195364Q', 0003, NOTA(7), NOTA(7), NOTA(7), NOTA(0), NOTA(7)),
			NOTASASIGNATURA('56195364Q', 0004, NOTA(2), NOTA(3), NOTA(2), NOTA(4), NOTA(0))
		)
		);
	CARLOS ALUMNO:=	ALUMNO(
        '99998888D',
        'Carlos',
        DIRECCION('Gran Vía', 'Barcelona', 08001),
        VTELEFONOS(600700800, 900100200),
        TO_DATE('05-MAR-2017', 'DD-MON-YYYY'),
        4,
        TNOTAS(
            NOTASASIGNATURA('99998888D', 0002, NOTA(6), NOTA(7), NOTA(8), NOTA(7), NOTA(8)),
            NOTASASIGNATURA('99998888D', 0004, NOTA(9), NOTA(8), NOTA(9), NOTA(9), NOTA(8)),
            NOTASASIGNATURA('99998888D', 0006, NOTA(8), NOTA(9), NOTA(8), NOTA(7), NOTA(9))
        )
		);
	MARIA ALUMNO:= ALUMNO(
        '98765432B',
        'Maria',
        DIRECCION('Avenida de Mayo', 'Buenos Aires', 1002),
        VTELEFONOS(654321987, 678901234),
        TO_DATE('20-MAR-2015', 'DD-MON-YYYY'),
        3,
        TNOTAS(
            NOTASASIGNATURA('98765432B', 0001, NOTA(7), NOTA(8), NOTA(7), NOTA(9), NOTA(9)),
            NOTASASIGNATURA('98765432B', 0004, NOTA(9), NOTA(9), NOTA(8), NOTA(9), NOTA(8)),
            NOTASASIGNATURA('98765432B', 0006, NOTA(8), NOTA(8), NOTA(9), NOTA(9), NOTA(9))
        )
    );
	

BEGIN
	-- Insertar el alumno Luis en la tabla de alumnos.
	ALUMNOS.EXTEND;
	ALUMNOS(ALUMNOS.LAST) := LUIS;
	ALUMNOS.EXTEND;
	ALUMNOS(ALUMNOS.LAST) := CARLOS;
	ALUMNOS.EXTEND;
	ALUMNOS(ALUMNOS.LAST) := MARIA;
	
	 FOR i IN 1..ALUMNOS.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Alumno ' || i || ':');
        DBMS_OUTPUT.PUT_LINE('DNI: ' || ALUMNOS(i).DNI);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || ALUMNOS(i).NOMBRE);
        DBMS_OUTPUT.PUT_LINE('Dirección: ' || ALUMNOS(i).DIREC.CALLE || ', ' || ALUMNOS(i).DIREC.POBLACION || ', ' || ALUMNOS(i).DIREC.CODPOSTAL);
        DBMS_OUTPUT.PUT_LINE('Teléfonos: ' || ALUMNOS(i).TELF(1) || ', ' || ALUMNOS(i).TELF(2));
        DBMS_OUTPUT.PUT_LINE('Fecha de Nacimiento: ' || TO_CHAR(ALUMNOS(i).FECHA_NAC, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('ID de Curso: ' || ALUMNOS(i).ID_CURSO);

        -- Mostrar calificaciones
        FOR j IN 1..ALUMNOS(i).CALIFICACIONES.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE('Calificaciones para Asignatura ' || j || ':');
            DBMS_OUTPUT.PUT_LINE('DNI: ' || ALUMNOS(i).CALIFICACIONES(j).DNI);
            DBMS_OUTPUT.PUT_LINE('Código de Asignatura: ' || ALUMNOS(i).CALIFICACIONES(j).CODIGO_ASIG);
            DBMS_OUTPUT.PUT_LINE('Nota 1er Evaluación: ' || ALUMNOS(i).CALIFICACIONES(j).NOTA1EV.NOTA);
            DBMS_OUTPUT.PUT_LINE('Nota 2da Evaluación: ' || ALUMNOS(i).CALIFICACIONES(j).NOTA2EV.NOTA);
            DBMS_OUTPUT.PUT_LINE('Nota 3ra Evaluación: ' || ALUMNOS(i).CALIFICACIONES(j).NOTA3EV.NOTA);
            DBMS_OUTPUT.PUT_LINE('Nota Final Junio: ' || ALUMNOS(i).CALIFICACIONES(j).NOTAFJUN.NOTA);
            DBMS_OUTPUT.PUT_LINE('Nota Septiembre: ' || ALUMNOS(i).CALIFICACIONES(j).NOTASEPT.NOTA);
        END LOOP;

        DBMS_OUTPUT.PUT_LINE('------------------------------');
    END LOOP;
END;
/