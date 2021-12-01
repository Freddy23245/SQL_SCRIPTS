--------------------------------1.3.6 Consultas resumen
--1)Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.
							
							SELECT SUM(total) AS [CANTIDAD TOTAL] FROM pedido
						

--2)Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.

								SELECT AVG(total) FROM pedido

--3)Calcula el n�mero total de comerciales distintos que aparecen en la tabla pedido.
						SELECT  COUNT(DISTINCT id_comercial) FROM pedido
					
--4)Calcula el n�mero total de clientes que aparecen en la tabla cliente.
				SELECT COUNT(id) FROM cliente
--5)Calcula cu�l es la mayor cantidad que aparece en la tabla pedido.

				SELECT MAX(total) FROM pedido
			

--6)Calcula cu�l es la menor cantidad que aparece en la tabla pedido.
					
					SELECT MIN(total) FROM pedido

--7)Calcula cu�l es el valor m�ximo de categor�a para cada una de las ciudades que aparece en la tabla cliente.
							SELECT * FROM comercial
							SELECT * FROM pedido
							
							SELECT * FROM cliente

							SELECT ciudad,MAX(categor�a)AS [VALOR MAXIMO],COUNT(categor�a)AS CANTIDAD FROM cliente
							GROUP BY ciudad


--8)Calcula cu�l es el m�ximo valor de los pedidos realizados durante el mismo d�a para cada uno de los clientes.
--Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes cantidades el mismo d�a.
--Se pide que se calcule cu�l es el pedido de m�ximo valor para cada uno de los d�as en los que un cliente 
--ha realizado un pedido. Muestra el identificador del cliente, nombre, apellidos, la fecha y el valor de la cantidad.

			

				SELECT  C.nombre AS [Nombre Del Cliente],CONCAT(C.apellido1 , ' ' , C.apellido2)AS Apellidos,
					fecha AS [Fecha De Pedido],
						MAX(total)AS [Cantidad],COUNT(*)AS [Cantidad De Pedido En El Dia] FROM cliente C
				INNER JOIN pedido P
				ON C.id=P.id_cliente
				GROUP BY  c.nombre,P.fecha,C.apellido1,C.apellido2,id_cliente
				
			

--9)Calcula cu�l es el m�ximo valor de los pedidos realizados durante el mismo d�a para cada uno de los clientes, 
--teniendo en cuenta que s�lo queremos mostrar aquellos pedidos que superen la cantidad de 2000 �.

								SELECT C.nombre,P.fecha,MAX(total)AS [Valor Maximo] FROM  cliente C
								INNER JOIN pedido P
								ON C.id=P.id_cliente
								WHERE P.total>2000
								GROUP BY C.nombre,P.fecha

--10)Calcula el m�ximo valor de los pedidos realizados para cada uno de los comerciales durante la fecha 2016-08-17.
--Muestra el identificador del comercial, nombre, apellidos y total.

						SELECT C.id,C.nombre,C.apellido1,MAX(P.total) AS [Total],P.fecha FROM comercial C
						INNER JOIN pedido P
						ON C.id=P.id_comercial
						WHERE P.fecha ='2016-08-17'
						GROUP BY C.nombre,C.apellido1,C.id,P.fecha


--11)Devuelve un listado con el identificador de cliente, nombre y apellidos y 
--el n�mero total de pedidos que ha realizado cada uno de clientes. Tenga en cuenta que pueden existir clientes
--que no han realizado ning�n pedido. Estos clientes tambi�n deben aparecer en el listado indicando que el n�mero 
--de pedidos realizados es 0.

						SELECT C.id AS [Codigo de Cliente],CONCAT(C.apellido1 ,' ', C.apellido2)AS [Apellidos],COUNT(P.id_cliente)AS [Cantidad De Pedido] FROM cliente C
						LEFT JOIN pedido P
						ON P.id_cliente=C.id
						GROUP BY C.id,C.apellido1,C.apellido2


--12)Devuelve un listado con el identificador de cliente, nombre y apellidos y el n�mero total de pedidos
--que ha realizado cada uno de clientes durante el a�o 2017.
						SELECT C.id AS [Codigo De Cliente],C.nombre AS[Nombres De Clientes],CONCAT(C.apellido1 ,' ', C.apellido2)AS Apellidos,COUNT(P.id_cliente)AS [Cantidad De Pedidos] FROM cliente C
						INNER JOIN pedido P
						ON C.id=P.id_cliente
						WHERE YEAR(P.fecha)='2017'
						GROUP BY C.id,C.nombre,C.apellido1,C.apellido2

--13)Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido 
--y el valor de la m�xima cantidad del pedido realizado por cada uno de los clientes. 
--El resultado debe mostrar aquellos clientes que no han realizado ning�n pedido indicando que la m�xima 
--cantidad de sus pedidos realizados es 0. Puede hacer uso de la funci�n IFNULL.
			

			SELECT C.id ,C.apellido1 AS [Apellidos],COUNT(P.id_cliente)AS [Cantidad De Pedido] FROM cliente C
						LEFT JOIN pedido P
						ON P.id_cliente=C.id
						GROUP BY C.id,C.apellido1,C.apellido2


						SELECT C.nombre,P.id_cliente,P.total FROM pedido P
						RIGHT JOIN cliente C
						ON P.id_cliente=C.id

--14)Devuelve cu�l ha sido el pedido de m�ximo valor que se ha realizado cada a�o.
						
	
								SELECT YEAR(fecha)AS A�o,MAX(total)AS [Monto Maximo] FROM pedido
								GROUP BY YEAR(fecha)
					


--15)Devuelve el n�mero total de pedidos que se han realizado cada a�o.

						SELECT YEAR(fecha) AS A�o,MIN(total)AS [Monto Minimo] FROM pedido
						GROUP BY YEAR(fecha)

---------------------------------------1.3.7 Subconsultas
-------------------------1.3.7.1 Con operadores b�sicos de comparaci�n
--1)Devuelve un listado con todos los pedidos que ha realizado Adela Salas D�az. (Sin utilizar INNER JOIN).
									
									SELECT * FROM pedido
									WHERE id_cliente=(SELECT id FROM cliente
														WHERE nombre='Adela' AND apellido1='Salas' AND apellido2='Diaz')
						
--2)Devuelve el n�mero de pedidos en los que ha participado el comercial Daniel S�ez Vega. (Sin utilizar INNER JOIN)

						SELECT COUNT(*)AS [Cantidad De Pedidos] FROM pedido
						WHERE id_comercial=(SELECT id FROM cliente
											WHERE nombre='Daniel' AND apellido1='S�enz' AND apellido2='Vega')

--3)Devuelve los datos del cliente que realiz� el pedido m�s caro en el a�o 2019. (Sin utilizar INNER JOIN)
							
							SELECT * FROM cliente
							WHERE id=(SELECT id_cliente FROM pedido
										WHERE total=(SELECT MAX(total) FROM pedido
													 WHERE YEAR(fecha)=2019)
									  )
										

--4)Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana.

							SELECT top 1 fecha, MIN(total)AS [Pedido Menor] FROM pedido
							
							WHERE id_cliente=(SELECT id FROM cliente
											WHERE nombre='Pepe' AND apellido1='Ruiz' AND apellido2='Santana')
											GROUP BY fecha 
											order by [Pedido Menor] ASC 
								



										
--5)Devuelve un listado con los datos de los clientes y los pedidos, 
--de todos los clientes que han realizado un pedido durante el a�o 2017 con un valor mayor o igual al
--valor medio de los pedidos realizados durante ese mismo a�o.

					
							SELECT C.nombre,fecha,P.total ,(SELECT AVG(total) FROM pedido)AS Media FROM pedido P
							INNER JOIN cliente C ON P.id_cliente=C.id
							WHERE YEAR(fecha)=2017
							GROUP BY C.nombre,P.total,fecha
							HAVING total>=(SELECT AVG(total) FROM pedido)



----------------------------------1.3.7.2 Subconsultas con ALL y ANY
--1)Devuelve el pedido m�s caro que existe en la tabla pedido si hacer uso de MAX, ORDER BY ni LIMIT.
										
							select total from pedido
							where total=any(select MAX(total) from pedido)



--2)Devuelve un listado de los clientes que no han realizado ning�n pedido. (Utilizando ANY o ALL).

								SELECT * FROM cliente
								WHERE id<>ALL(SELECT DISTINCT id_cliente FROM pedido)

--3)Devuelve un listado de los comerciales que no han realizado ning�n pedido. (Utilizando ANY o ALL).

								SELECT * FROM comercial
								WHERE id<>ALL(SELECT DISTINCT id_comercial FROM pedido)

--------------------------------1.3.7.3 Subconsultas con IN y NOT IN
--1)Devuelve un listado de los clientes que no han realizado ning�n pedido. (Utilizando IN o NOT IN).

						SELECT * FROM cliente
						WHERE id NOT IN(SELECT id_cliente FROM pedido)

--2)Devuelve un listado de los comerciales que no han realizado ning�n pedido. (Utilizando IN o NOT IN).
							
							SELECT * FROM comercial
							WHERE id NOT IN(SELECT id_comercial FROM pedido)

---------------------------1.3.7.4 Subconsultas con EXISTS y NOT EXISTS
--1)Devuelve un listado de los clientes que no han realizado ning�n pedido. (Utilizando EXISTS o NOT EXISTS).
								
								SELECT * FROM cliente C
								WHERE  NOT EXISTS(SELECT id_cliente FROM pedido P
													WHERE C.id=P.id_cliente)

--2)Devuelve un listado de los comerciales que no han realizado ning�n pedido. (Utilizando EXISTS o NOT EXISTS).

								SELECT * FROM comercial C
								WHERE NOT EXISTS(SELECT * FROM pedido P
													WHERE C.id=P.id_comercial)
