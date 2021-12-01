--1.5.4 Consultas sobre una tabla
--1)Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos.
--El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.

							SELECT apellido1,apellido2,nombre FROM persona
							WHERE tipo='alumno'
							ORDER BY apellido1,apellido2,nombre



--2)Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.

					SELECT nombre,apellido1,apellido2 FROM persona
					WHERE tipo='alumno' and telefono is null

--3)Devuelve el listado de los alumnos que nacieron en 1999.

							select nombre,apellido1,apellido2,fecha_nacimiento from persona
							where YEAR(fecha_nacimiento)=1999 and tipo='alumno'

--4)Devuelve el listado de profesores que no han dado de alta su número de teléfono en la base de datos 
--y además su nif termina en K.
							
							SELECT * FROM persona
							WHERE tipo='profesor' and nif LIKE '%K'


--5)Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, 
--en el tercer curso del grado que tiene el identificador 7.

					SELECT * FROM asignatura
					WHERE cuatrimestre=1 AND id_grado=7

--1.5.5 Consultas multitabla (Composición interna)
--1)Devuelve un listado con los datos de todas las alumnas que se han matriculado alguna vez en el Grado 
--en Ingeniería Informática (Plan 2015).

							SELECT DISTINCT P.nombre,G.nombre,P.sexo,P.tipo FROM persona P



							INNER JOIN  alumno_se_matricula_asignatura AM
							ON AM.id_alumno=P.id
							INNER JOIN asignatura A
							ON AM.id_asignatura=A.id
							INNER JOIN grado G
							ON G.id=A.id_grado
							WHERE G.nombre='Grado en Ingeniería Informática (Plan 2015)' and P.sexo='M'

						

--2)Devuelve un listado con todas las asignaturas ofertadas en el Grado en Ingeniería Informática (Plan 2015).

							SELECT DISTINCT A.nombre,G.nombre FROM asignatura A
							INNER JOIN grado G
							ON G.id=A.id_grado
							WHERE G.nombre='Grado en Ingeniería Informática (Plan 2015)'

--3)Devuelve un listado de los profesores junto con el nombre del departamento al que están vinculados.
--El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento.
--El resultado estará ordenado alfabéticamente de menor a mayor por los apellidos y el nombre.

								SELECT P.apellido1,P.apellido2,P.nombre,D.nombre AS Departamento FROM persona P
								INNER JOIN profesor PP
								ON PP.id_profesor=P.id
								INNER JOIN departamento D
								ON D.id=PP.id_departamento
								
--4)Devuelve un listado con el nombre de las asignaturas,
--año de inicio y año de fin del curso escolar del alumno con nif 26902806M.

									SELECT A.nombre,CE.anyo_inicio,CE.anyo_fin,P.nif FROM asignatura A
									INNER JOIN alumno_se_matricula_asignatura AM
									ON AM.id_asignatura=A.id
									INNER JOIN curso_escolar CE
									ON CE.id=AM.id_curso_escolar
									INNER JOIN persona P
									ON P.id=AM.id_alumno
									WHERE P.nif='26902806M'

--5)Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten
--alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).

							SELECT D.nombre,P.id_profesor,A.nombre FROM departamento D
							INNER JOIN profesor P
							ON D.id=P.id_departamento
							inner join asignatura A
							ON A.id_profesor=P.id_profesor
							WHERE A.nombre='Grado en Ingeniería Informática (Plan 2015)'

--6)Devuelve un listado con todos los alumnos que se han matriculado
--en alguna asignatura durante el curso escolar 2018/2019.

						SELECT P.nombre,CE.anyo_inicio FROM persona P
						INNER JOIN alumno_se_matricula_asignatura AM
						ON AM.id_alumno=P.id
						INNER JOIN curso_escolar CE
						ON CE.id=AM.id_curso_escolar
						WHERE YEAR(anyo_inicio) BETWEEN 2018 AND 2019


--1.5.6 Consultas multitabla (Composición externa)
--Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

--1)Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados.
--El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado. 
--El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor.
--El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.

							SELECT D.nombre,P.apellido1,P.apellido2,P.nombre FROM persona P
							LEFT JOIN profesor PP
							ON P.id=PP.id_profesor
							LEFT JOIN departamento D
							ON D.id=PP.id_departamento



--2)Devuelve un listado con los profesores que no están asociados a un departamento.

						SELECT P.nombre,P.apellido1,P.apellido2,P.tipo,PP.id_profesor FROM persona P
						LEFT JOIN profesor PP
						ON PP.id_profesor=P.id
						LEFT JOIN departamento D
						ON D.id=PP.id_departamento
						WHERE PP.id_departamento IS NULL AND P.tipo='PROFESOR'


--3)Devuelve un listado con los departamentos que no tienen profesores asociados.

					SELECT D.nombre FROM departamento D
					LEFT JOIN profesor P
					ON P.id_departamento=D.id
					WHERE P.id_profesor IS NULL

--4)Devuelve un listado con los profesores que no imparten ninguna asignatura.

				SELECT P.nombre,P.tipo,A.nombre FROM persona P
				LEFT JOIN profesor PP
				ON PP.id_profesor=P.id
				LEFT JOIN asignatura A
				ON A.id_profesor=PP.id_profesor
				WHERE A.id_profesor IS NULL AND P.tipo = 'PROFESOR'
--5)Devuelve un listado con las asignaturas que no tienen un profesor asignado.

								SELECT A.nombre,A.id_profesor FROM asignatura A
								LEFT JOIN profesor PP
								ON PP.id_profesor=A.id_profesor
								LEFT JOIN persona P
								ON P.id=PP.id_profesor
								WHERE A.id_profesor IS NULL

--6)Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya
--impartido en ningún curso escolar. El resultado debe mostrar el nombre del departamento 
--y el nombre de la asignatura que no se haya impartido nunca.

				SELECT D.nombre AS Departamento,A.nombre AS Asignatura,A.id_profesor FROM departamento D
				LEFT JOIN profesor P
				ON P.id_departamento=D.id
				LEFT JOIN asignatura A
				ON A.id_profesor=P.id_profesor
				WHERE A.id_profesor IS NULL

			


--1.5.7 Consultas resumen
--1)Devuelve el número total de alumnas que hay.

				SELECT COUNT(*) FROM persona
				WHERE tipo='ALUMNO' AND sexo='M'

--2)Calcula cuántos alumnos nacieron en 1999.
	
					SELECT COUNT(*) FROM persona
					WHERE tipo='ALUMNO' AND YEAR(fecha_nacimiento)=1999

--3)Calcula cuántos profesores hay en cada departamento.
--El resultado sólo debe mostrar dos columnas, 
--una con el nombre del departamento y otra con el número de profesores que hay en ese departamento.
--El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor
--por el número de profesores.

						SELECT D.nombre AS Departamento,COUNT(P.id_profesor)AS Profesores FROM departamento D
						INNER JOIN profesor P
						ON P.id_departamento=D.id
						GROUP BY D.nombre

--4)Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos.
--Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. 
--Estos departamentos también tienen que aparecer en el listado.

							SELECT D.nombre AS Departamento,COUNT(P.id_profesor)AS Profesores FROM departamento D
						left JOIN profesor P
						ON P.id_departamento=D.id
						GROUP BY D.nombre

--5)Devuelve un listado con el nombre de todos los grados existentes en la base de datos 
--y el número de asignaturas que tiene cada uno.
--Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas.
--Estos grados también tienen que aparecer en el listado. 
--El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.

										
								SELECT G.nombre AS Grado,COUNT(A.id_grado)AS [Cantidad De Asignaturas] FROM grado G
								LEFT JOIN asignatura A
								ON G.id=A.id_grado
								GROUP BY G.nombre
								ORDER BY [Cantidad De Asignaturas] DESC


--6)Devuelve un listado con el nombre de todos los grados existentes en la base de datos
--y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.

								SELECT G.nombre AS Grado,COUNT(A.id_grado)AS [Cantidad De Asignaturas]
								FROM grado G LEFT JOIN asignatura A
								ON G.id=A.id_grado
								GROUP BY G.nombre
								HAVING COUNT(A.id_grado)>40
								ORDER BY [Cantidad De Asignaturas] DESC


--7)Devuelve un listado que muestre el nombre de los grados 
--y la suma del número total de créditos que hay para cada tipo de asignatura.
--El resultado debe tener tres columnas:
--nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo. 
--Ordene el resultado de mayor a menor por el número total de crédidos.

							SELECT G.nombre,A.tipo,SUM(A.creditos)AS SUMA FROM grado G
							INNER JOIN asignatura A
							ON	A.id_grado=G.id
							GROUP BY G.nombre,A.tipo
							ORDER BY SUMA DESC

--8)Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura 
--en cada uno de los cursos escolares.
--El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra 
--con el número de alumnos matriculados.

						SELECT YEAR(CE.anyo_inicio) AS [Año De Inicio],COUNT(AM.id_alumno) AS [Cantidad De Alumnos] FROM persona P
						INNER JOIN alumno_se_matricula_asignatura AM
						ON AM.id_alumno=P.id
						INNER JOIN curso_escolar CE
						ON CE.id=AM.id_curso_escolar
						GROUP BY CE.anyo_inicio

--9)Devuelve un listado con el número de asignaturas que imparte cada profesor.
--El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura.
--El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. 
--El resultado estará ordenado de mayor a menor por el número de asignaturas.

						SELECT PP.id_profesor,P.nombre,P.tipo,COUNT(A.id)AS CANTIDAD_ASIGNATURAS FROM persona P
						LEFT JOIN profesor PP
						ON P.id=PP.id_profesor
						LEFT JOIN asignatura A
						ON A.id_profesor=PP.id_profesor
						WHERE PP.id_profesor IS NOT NULL
						GROUP BY PP.id_profesor,P.nombre,P.tipo
						ORDER BY CANTIDAD_ASIGNATURAS DESC
				
--1.5.8 Subconsultas
--1)Devuelve todos los datos del alumno más joven.

				SELECT * FROM persona
				WHERE fecha_nacimiento=(SELECT MIN(fecha_nacimiento) FROM persona
										WHERE tipo='ALUMNO')

--2)Devuelve un listado con los profesores que no están asociados a un departamento.

					SELECT * FROM profesor 
					WHERE id_profesor NOT IN (SELECT  P.id_profesor,P.id_departamento FROM profesor P
												LEFT JOIN departamento D
												ON P.id_departamento=D.id)

--3)Devuelve un listado con los departamentos que no tienen profesores asociados.

					SELECT * FROM departamento D
					WHERE NOT EXISTS(SELECT * FROM profesor P
										WHERE D.id=P.id_departamento )

--4)Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.
						
						SELECT * FROM profesor
						WHERE id_profesor IN (SELECT P.id_profesor FROM profesor P
											LEFT JOIN departamento D
											ON D.id=P.id_departamento
											LEFT JOIN asignatura A
											ON A.id_profesor=P.id_profesor
											WHERE P.id_departamento IS NOT NULL AND A.id_profesor IS NULL)

--5)Devuelve un listado con las asignaturas que no tienen un profesor asignado.

						SELECT * FROM asignatura A
						WHERE NOT EXISTS(SELECT id_profesor FROM profesor P WHERE A.id_profesor=P.id_profesor)
								

--6)Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar

							SELECT * FROM departamento
							WHERE id IN(		SELECT DISTINCT D.id AS DEP FROM departamento D
				LEFT JOIN profesor P
				ON P.id_departamento=D.id
				LEFT JOIN asignatura A
				ON A.id_profesor=P.id_profesor
				WHERE A.id_profesor IS NULL)

		



						