--1.3.3 Consultas sobre una tabla
--1)Devuelve un listado con todos los pedidos que se han realizado.
--Los pedidos deben estar ordenados por la fecha de realización,
--mostrando en primer lugar los pedidos más recientes.

					SELECT * FROM pedido
					ORDER  BY fecha DESC



--2)Devuelve todos los datos de los dos pedidos de mayor valor.

						SELECT TOP 2 * FROM pedido
						ORDER BY total DESC

--3)Devuelve un listado con los identificadores de los clientes que han realizado algún pedido.
--Tenga en cuenta que no debe mostrar identificadores que estén repetidos.

								SELECT DISTINCT C.id,P.id_cliente FROM cliente C
								INNER JOIN pedido P
								ON P.id_cliente=C.id


--4)Devuelve un listado de todos los pedidos que se realizaron durante el año 2017,
--cuya cantidad total sea superior a 500€.

							SELECT * FROM pedido
							WHERE YEAR(fecha)=2017 AND total>500

--5)Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisión entre 0.05 y 0.11.

								SELECT * FROM comercial
								WHERE comisión>=0.5 OR comisión<= 0.11

--6)Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial.

										SELECT * FROM comercial
										WHERE comisión=(SELECT MAX(comisión) FROM comercial)

--7)Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo segundo apellido no es NULL.
--El listado deberá estar ordenado alfabéticamente por apellidos y nombre.

						SELECT nombre,apellido1,apellido2 FROM cliente
						WHERE apellido2 IS NOT NULL

--8)Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n y también 
--los nombres que empiezan por P. El listado deberá estar ordenado alfabéticamente.
						
						SELECT * FROM cliente
						WHERE nombre LIKE 'A%N'
						ORDER BY nombre ASC

--9)Devuelve un listado de los nombres de los clientes que no empiezan por A.
--El listado deberá estar ordenado alfabéticamente.

									SELECT * FROM cliente 
									WHERE nombre LIKE '[^A]%'

--10)Devuelve un listado con los nombres de los comerciales que terminan por el o o. 
--Tenga en cuenta que se deberán eliminar los nombres repetidos.

						SELECT * FROM comercial
						WHERE nombre LIKE '%O'

-------------------------1.3.4 Consultas multitabla (Composición interna)
------------------Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.

--1)Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido.
--El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.

											SELECT DISTINCT C.id,C.nombre,C.apellido1,C.apellido2 FROM cliente C
											INNER JOIN pedido P
											ON C.id=P.id_cliente
											ORDER BY nombre ASC



--2)Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente.
--El resultado debe mostrar todos los datos de los pedidos y del cliente.
--El listado debe mostrar los datos de los clientes ordenados alfabéticamente.

									SELECT P.*,C.* FROM pedido P
									INNER JOIN cliente C
									ON C.id=P.id_cliente
									ORDER BY C.nombre ASC 


--3)Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. 
--El resultado debe mostrar todos los datos de los pedidos y de los comerciales. 
--El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.
								
								SELECT C.*,P.* FROM comercial C
								INNER JOIN pedido P
								ON P.id_comercial=C.id
								

--4)Devuelve un listado que muestre todos los clientes,
--con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido.

								SELECT C.nombre AS CLIENTE,P.*,CC.nombre AS COMERCIAL FROM cliente C
								INNER JOIN pedido P
								ON C.id=P.id_cliente
								INNER JOIN comercial CC
								ON CC.id=P.id_comercial

--5)Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, 
--cuya cantidad esté entre 300 € y 1000 €.
											
									SELECT C.nombre AS CLIENTE,P.total FROM cliente C
									INNER JOIN pedido P
									ON C.id=P.id_cliente
									WHERE YEAR(P.fecha)=2017 AND (total BETWEEN 300 AND 1000)

--6)Devuelve el nombre y los apellidos de todos los comerciales que ha participado
--en algún pedido realizado por María Santana Moreno.

											SELECT C.nombre,C.apellido1,C.apellido2 FROM comercial C
											INNER JOIN pedido P
											ON C.id=P.id_comercial
											INNER JOIN cliente CC
											ON CC.ID=P.ID_CLIENTE
											WHERE CC.nombre='Maria' AND CC.apellido1='Santana' AND CC.apellido2='MORENO'



--7)Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.

									SELECT DISTINCT C.nombre AS Clientes,CC.* FROM cliente C
									INNER JOIN pedido P
									ON C.id=P.id_cliente
									INNER JOIN comercial CC
									ON P.id_comercial=CC.id
									WHERE CC.id=(SELECT id FROM comercial
													WHERE nombre='Daniel' AND apellido1='Sáez' AND apellido2='Vega' )


--1.3.5 Consultas multitabla (Composición externa)
--Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

--1)Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado.
--Este listado también debe incluir los clientes que no han realizado ningún pedido.
--El listado debe estar ordenado alfabéticamente por el primer apellido, 
--segundo apellido y nombre de los clientes.

								SELECT C.apellido1,C.apellido2,C.nombre,P.* FROM cliente C
								LEFT JOIN pedido P
								ON P.id_cliente=C.id
								ORDER BY C.apellido1,C.apellido2,C.nombre


--2)Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han realizado.
--Este listado también debe incluir los comerciales que no han realizado ningún pedido.
--El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los comerciales.

									SELECT C.nombre AS COMERCIAL,P.id_comercial AS PEDIDO FROM comercial C
									LEFT JOIN pedido P
									ON P.id_comercial=C.id

									ORDER BY C.apellido1,C.apellido2,C.nombre ASC


--3)Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.
									
									SELECT C.nombre,P.id_cliente FROM cliente C
									LEFT JOIN pedido P
									ON C.id=P.id_cliente
									WHERE P.id_cliente IS NULL



--4)Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.

							SELECT C.nombre,P.id_cliente FROM comercial C
									LEFT JOIN pedido P
									ON C.id=P.id_comercial
									WHERE P.id_comercial IS NULL


--5)Devuelve un listado con los clientes que no han realizado ningún pedido y 
--de los comerciales que no han participado en ningún pedido. 
--Ordene el listado alfabéticamente por los apellidos y el nombre.
--En en listado deberá diferenciar de algún modo los clientes y los comerciales.

									SELECT  CC.nombre AS Cliente, C.nombre AS Comercial, P.id_cliente,P.id_comercial FROM comercial C
									LEFT JOIN pedido P
									ON C.id=P.id_comercial
									FULL JOIN cliente CC
									ON CC.id=P.id_cliente
									WHERE P.id_comercial IS NULL AND P.id_cliente IS NULL


--6)¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? Justifique su respuesta.

--SI, SE PUEDE USAR YA QUE SI CAMBIAMOS EL ORDEN DE LAS CONSULTAS SE OBTENDRIA LOS MISMOS RESULTADOS