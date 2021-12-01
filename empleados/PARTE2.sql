--1.2.4 Consultas multitabla (Composición interna)
--Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.

--1)Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
					SELECT E.nombre,E.apellido1,E.apellido2,D.nombre AS DEPARTAMENTO FROM empleado E
					INNER JOIN departamento D
					ON E.codigo_departamento=D.codigo


--2)Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
--Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético)
--y en segundo lugar por los apellidos y el nombre de los empleados.
						
						SELECT E.nombre,E.apellido1,E.apellido2,D.nombre AS DEPARTAMENTO FROM empleado E
						INNER JOIN departamento D
						ON E.codigo_departamento=D.codigo
						ORDER BY D.nombre ASC,E.apellido1,E.apellido2,E.nombre
					

--3)Devuelve un listado con el código y el nombre del departamento,
--solamente de aquellos departamentos que tienen empleados.
								
								SELECT D.codigo,D.nombre FROM empleado E
								INNER JOIN departamento D
								ON E.codigo_departamento=D.codigo
								WHERE E.codigo_departamento IS NOT NULL

								SELECT * FROM departamento
								SELECT * FROM empleado


--4)Devuelve un listado con el código, el nombre del departamento y el valor del presupuesto actual del que dispone, 
--solamente de aquellos departamentos que tienen empleados. 
--El valor del presupuesto actual lo puede calcular restando al valor del presupuesto inicial (columna presupuesto) 
--el valor de los gastos que ha generado (columna gastos).

							SELECT DISTINCT D.codigo,D.nombre,presupuesto,(presupuesto-gastos)AS [PRESUPUESTO ACTUAL] FROM departamento D
							INNER JOIN empleado E ON D.codigo=E.codigo_departamento
							WHERE E.codigo_departamento IS NOT NULL
							ORDER BY nombre DESC
							


--5)Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.

						SELECT D.nombre FROM empleado E
						INNER JOIN departamento D
						ON E.codigo_departamento=D.codigo
						WHERE E.nif='38382980M'


--6)Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.

				SELECT D.nombre FROM departamento D
				INNER JOIN empleado E
				ON D.codigo=E.codigo_departamento
				WHERE E.nombre='Pepe' AND apellido1='Ruiz' AND apellido2='Santana'


--7)Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D.
--Ordena el resultado alfabéticamente.
									
						SELECT E.* FROM empleado E 
						INNER JOIN departamento D
						ON E.codigo_departamento=D.codigo
						WHERE D.nombre='I+D'
						ORDER BY E.nombre ASC

--8)Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas,
--Contabilidad o I+D. Ordena el resultado alfabéticamente.
						
						SELECT E.* FROM empleado E
						INNER JOIN departamento D
						ON E.codigo_departamento=D.codigo
						WHERE D.nombre IN ('Contabilidad','I+D','Sistemas')
						ORDER BY E.nombre ASC

--9)Devuelve una lista con el nombre de los empleados que tienen los departamentos
--que no tienen un presupuesto entre 100000 y 200000 euros.

						SELECT E.nombre AS EMPLEADO,D.nombre AS DEPARTAMENTO,D.presupuesto AS PRESUPUESTO FROM empleado E
						INNER JOIN departamento D
						ON E.codigo_departamento=D.codigo
						WHERE D.presupuesto NOT BETWEEN 100000 AND 200000

--10)Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL.
--Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.

					SELECT D.nombre AS DEPARTAMENTO FROM empleado E
					INNER JOIN departamento D
					ON E.codigo_departamento=D.codigo
					WHERE E.apellido2 IS NULL

--1.2.5 Consultas multitabla (Composición externa)
--Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

--1)Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan.
--Este listado también debe incluir los empleados que no tienen ningún departamento asociado.

					SELECT E.nombre AS Empleado,D.nombre AS Departamento FROM empleado E
					LEFT JOIN  departamento D
					ON E.codigo_departamento=D.codigo


--2)Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.

						SELECT E.nombre AS Empleado,D.nombre AS Departamento FROM empleado E
					LEFT JOIN  departamento D
					ON E.codigo_departamento=D.codigo
					WHERE E.codigo_departamento IS NULL

--3)Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.
					
					SELECT D.nombre FROM empleado E
					RIGHT JOIN departamento D
					ON E.codigo_departamento=D.codigo
					WHERE E.codigo_departamento IS NULL

--4)Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan.
--El listado debe incluir los empleados que no tienen ningún departamento asociado y los departamentos
--que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.

				SELECT E.nombre,D.nombre FROM empleado E
				FULL JOIN departamento D
				ON D.codigo=E.codigo_departamento
				WHERE E.codigo_departamento IS NULL OR E.codigo_departamento IS NOT NULL
				ORDER BY D.nombre ASC


--5)Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos
--que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.

					SELECT E.nombre AS Empleado,D.nombre as Departamento FROM empleado E
					FULL JOIN departamento D
					ON E.codigo_departamento=D.codigo
					ORDER BY D.nombre 

--1.2.6 Consultas resumen
--1)Calcula la suma del presupuesto de todos los departamentos.

				select SUM(presupuesto) as [Total De Presupuesto] from departamento

--2)Calcula la media del presupuesto de todos los departamentos.

				SELECT AVG(presupuesto) AS Media FROM departamento 

--3)Calcula el valor mínimo del presupuesto de todos los departamentos.
				
				SELECT MIN(presupuesto) FROM departamento

--4)Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con menor presupuesto.
						
						SELECT nombre,presupuesto FROM departamento
						WHERE presupuesto=(SELECT MIN(presupuesto) FROM departamento)
						

--5)Calcula el valor máximo del presupuesto de todos los departamentos.

					SELECT MAX(presupuesto)AS [Presupuesto Maximo] FROM departamento

--6)Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con mayor presupuesto.

					SELECT nombre,presupuesto FROM departamento
					WHERE presupuesto=(SELECT MAX(presupuesto) FROM departamento)

--7)Calcula el número total de empleados que hay en la tabla empleado.

				SELECT COUNT(*)AS [Cantidad De Empleados] FROM empleado

--8)Calcula el número de empleados que no tienen NULL en su segundo apellido.

					SELECT COUNT(*)AS [Cantidad De Empleados] FROM empleado
					WHERE  apellido2 IS NULL

--9)Calcula el número de empleados que hay en cada departamento. Tienes que devolver dos columnas,
--una con el nombre del departamento y otra con el número de empleados que tiene asignados.

						SELECT D.nombre,COUNT(codigo_departamento)AS [Cantidad De Empleados] FROM empleado E 
						INNER JOIN departamento D
						ON E.codigo_departamento=D.codigo
						GROUP BY D.nombre,E.codigo_departamento


--10)Calcula el nombre de los departamentos que tienen más de 2 empleados. El resultado debe tener dos columnas,
--una con el nombre del departamento y otra con el número de empleados que tiene asignados.
							
							SELECT * FROM (
						SELECT D.nombre,COUNT(codigo_departamento)AS [Cantidad De Empleados] FROM empleado E 
						INNER JOIN departamento D
						ON E.codigo_departamento=D.codigo
							GROUP BY D.nombre,E.codigo_departamento
						)AS T
						WHERE [Cantidad De Empleados]>=2 
					

--11)Calcula el número de empleados que trabajan en cada uno de los departamentos. 
--El resultado de esta consulta también tiene que incluir aquellos departamentos
--que no tienen ningún empleado asociado

							SELECT D.nombre,COUNT(codigo_departamento)AS [Cantidad De Empleados] FROM departamento D
							LEFT JOIN empleado E
							ON D.codigo=E.codigo_departamento
							GROUP BY D.nombre,E.codigo_departamento
							GO

--12)Calcula el número de empleados que trabajan en cada unos de los departamentos
--que tienen un presupuesto mayor a 200000 euros.

					SELECT COUNT(E.codigo_departamento)AS [Cantidad De Empleados] FROM empleado E
					INNER JOIN departamento D
					ON E.codigo_departamento=D.codigo
					WHERE D.presupuesto>200000

--1.2.7 Subconsultas
--1.2.7.1 Con operadores básicos de comparación
--1)Devuelve un listado con todos los empleados que tiene el departamento de Sistemas. (Sin utilizar INNER JOIN).
						
						SELECT * FROM empleado
						WHERE codigo_departamento=(SELECT codigo FROM departamento
														WHERE nombre='Sistemas')

--2)Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada.

							SELECT nombre,presupuesto FROM departamento
							WHERE presupuesto=(SELECT MAX(presupuesto) FROM departamento)

--3)Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada.

							SELECT nombre,presupuesto FROM departamento
							WHERE presupuesto=(SELECT MIN(presupuesto) FROM departamento)

--			1.2.7.2 Subconsultas con ALL y ANY
--1)Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada.
--Sin hacer uso de MAX, ORDER BY ni LIMIT.

						SELECT nombre FROM departamento
						WHERE presupuesto>=ALL(SELECT presupuesto FROM departamento)

--2)Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada.
--Sin hacer uso de MIN, ORDER BY ni LIMIT.

					SELECT nombre FROM departamento
					WHERE presupuesto<=ALL(SELECT presupuesto FROM departamento)


--3)Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando ALL o ANY).

						SELECT nombre FROM departamento
						WHERE codigo= ANY(SELECT codigo_departamento FROM empleado)

--4)Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando ALL o ANY).
						
						SELECT nombre FROM departamento
						WHERE codigo  <> ALL (SELECT codigo_departamento FROM empleado)

--1.2.7.3 Subconsultas con IN y NOT IN
--1)Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando IN o NOT IN).
			
			SELECT nombre FROM departamento
			WHERE codigo IN (SELECT codigo_departamento FROM empleado)


--2)Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando IN o NOT IN).
						
						SELECT nombre FROM departamento
						WHERE codigo not in (SELECT DISTINCT codigo_departamento FROM empleado where codigo_departamento is not null)

--1.2.7.4 Subconsultas con EXISTS y NOT EXISTS
--1)Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando EXISTS o NOT EXISTS).

						SELECT nombre FROM departamento D
						WHERE EXISTS(SELECT codigo_departamento FROM empleado E
										WHERE D.codigo=E.codigo_departamento)

--2)Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando EXISTS o NOT EXISTS).

							SELECT nombre FROM departamento D
							WHERE NOT EXISTS(SELECT codigo_departamento FROM empleado E
											WHERE D.codigo=E.codigo_departamento)