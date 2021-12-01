--1.4.4 Consultas sobre una tabla
--1)Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
						SELECT CODIGO_OFICINA,REGION FROM OFICINA


--2)Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
					
					SELECT REGION,TELEFONO FROM OFICINA
					

--3)Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
									
									SELECT * FROM EMPLEADO
									WHERE CODIGO_JEFE=7

--4)Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.


								SELECT NOMBRE,APELLIDO1,APELLIDO2,EMAIL FROM EMPLEADO
								WHERE codigo_jefe IS NULL

--5)Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
										
							SELECT * FROM empleado
							WHERE puesto <> 'Representante Ventas'


--6)Devuelve un listado con el nombre de los todos los clientes españoles.
				
				SELECT * FROM cliente 
				WHERE pais='Spain'

--7)Devuelve un listado con los distintos estados por los que puede pasar un pedido.
						
						SELECT DISTINCT estado FROM pedido

--8)Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008.
--Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
----------Utilizando la función YEAR de MySQL.
			SELECT DISTINCT C.codigo_cliente,C.nombre_cliente,P.* FROM cliente C
			INNER JOIN pago P
			ON C.codigo_cliente=P.codigo_cliente
			WHERE YEAR(P.fecha_pago)=2008
----------Utilizando la función DATE_FORMAT de MySQL.

---------Sin utilizar ninguna de las funciones anteriores.
--9)Devuelve un listado con el código de pedido, código de cliente,
--fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.

					SELECT P.codigo_pedido,C.codigo_cliente,P.fecha_esperada,P.fecha_entrega FROM cliente C
					INNER JOIN pedido P
					ON C.codigo_cliente=P.codigo_cliente
					WHERE fecha_entrega>fecha_esperada

					SELECT * FROM pedido 

--10)Devuelve un listado con el código de pedido, código de cliente,
--fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al 
--menos dos días antes de la fecha esperada.
----------Utilizando la función ADDDATE de MySQL.
		
			SELECT C.codigo_cliente,P.fecha_esperada,P.fecha_entrega  FROM cliente C
			INNER JOIN pedido P
			ON P.codigo_cliente=C.codigo_cliente
			group by P.codigo_cliente,C.codigo_cliente,P.fecha_esperada,P.fecha_entrega 
			having DATEDIFF(DAY,P.fecha_esperada,P.fecha_entrega)=-2
		

	
	SELECT C.codigo_cliente,P.fecha_esperada,P.fecha_entrega  FROM cliente C
			INNER JOIN pedido P
			ON P.codigo_cliente=C.codigo_cliente
			
			group by P.codigo_cliente,C.codigo_cliente,P.fecha_esperada,P.fecha_entrega 
			having DATEadd(DAY,-2,P.fecha_entrega)=-2

	

----------Utilizando la función DATEDIFF de MySQL.
----------¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?
--11)Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

						SELECT * FROM pedido
						WHERE estado='Rechazado' AND YEAR(fecha_pedido)=2009

--12)Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
								
								SELECT * FROM pedido
								WHERE estado='Entregado' AND MONTH(fecha_pedido)=01

--13)Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal.
--Ordene el resultado de mayor a menor.

							SELECT  * FROM pago
							WHERE YEAR(fecha_pago)=2008 AND forma_pago='PayPal'
							ORDER BY total DESC

--14)Devuelve un listado con todas las formas de pago que aparecen en la tabla pago.
---Tenga en cuenta que no deben aparecer formas de pago repetidas.
								
								SELECT DISTINCT forma_pago FROM pago
								

--15)Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales 
--y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta,
--mostrando en primer lugar los de mayor precio.

								SELECT * FROM producto
								WHERE gama='Ornamentales' AND cantidad_en_stock>100
								ORDER BY precio_venta DESC


--16)Devuelve un listado con todos los clientes que sean de la ciudad de Madrid 
--y cuyo representante de ventas tenga el código de empleado 11 o 30.

							SELECT nombre_cliente,ciudad,codigo_empleado_rep_ventas FROM cliente
							WHERE ciudad='Madrid' AND codigo_empleado_rep_ventas IN (11,30)

---------------------------1.4.5 Consultas multitabla (Composición interna)
----Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

--1)Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
								
								SELECT C.nombre_cliente AS CLIENTE, E.nombre AS REPRESENTANTE FROM cliente C
								INNER JOIN empleado E
								ON C.codigo_empleado_rep_ventas=E.codigo_empleado


--2)Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.

								SELECT C.nombre_cliente AS CLIENTE,E.nombre AS REPRESENTANTE FROM pago P
								INNER JOIN cliente C
								ON P.codigo_cliente=C.codigo_cliente
								INNER JOIN empleado E
								ON C.codigo_empleado_rep_ventas=E.codigo_empleado

--3)Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre
--de sus representantes de ventas.
								
								SELECT C.codigo_cliente,C.nombre_cliente AS CLIENTE,E.nombre AS REPRESENTANTE FROM cliente C
								LEFT JOIN pago P
								ON C.codigo_cliente=P.codigo_cliente INNER JOIN
								empleado E ON C.codigo_empleado_rep_ventas=E.codigo_empleado
								WHERE P.codigo_cliente IS NULL



--4)Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
--junto con la ciudad de la oficina a la que pertenece el representante.

					SELECT C.nombre_cliente,E.nombre,O.ciudad FROM  cliente C
					INNER JOIN pago P
					ON C.codigo_cliente=P.codigo_cliente
					INNER JOIN empleado E
					ON C.codigo_empleado_rep_ventas=E.codigo_empleado
					INNER JOIN oficina O
					ON O.codigo_oficina=E.codigo_oficina

--5)Devuelve el nombre de los clientes que no hayan hecho pagos 
--y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

						SELECT C.nombre_cliente,E.nombre,O.ciudad FROM  cliente C
					LEFT JOIN pago P
					ON C.codigo_cliente=P.codigo_cliente
					INNER JOIN empleado E
					ON C.codigo_empleado_rep_ventas=E.codigo_empleado
					INNER JOIN oficina O
					ON O.codigo_oficina=E.codigo_oficina
					WHERE P.codigo_cliente IS NULL

--6)Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
						
						SELECT O.linea_direccion1,O.linea_direccion2 FROM oficina O
						INNER JOIN empleado E
						ON O.codigo_oficina=E.codigo_oficina
						INNER JOIN cliente C
						ON C.codigo_empleado_rep_ventas=E.codigo_empleado
						WHERE C.ciudad='Fuenlabrada'


						SELECT * FROM oficina
						
--7)Devuelve el nombre de los clientes y el nombre de sus representantes 
--junto con la ciudad de la oficina a la que pertenece el representante.

							SELECT C.nombre_cliente AS EMPLEADO,E.nombre AS REPRESENTANTE,O.ciudad AS CIUDAD_DE_OFICINA FROM cliente C
							INNER JOIN empleado E
							ON C.codigo_empleado_rep_ventas=E.codigo_empleado
							INNER JOIN  oficina O
							ON E.codigo_oficina=O.codigo_oficina

--8)Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

						
							SELECT nombre as empleado,codigo_jefe,nombre as jefe FROM empleado
							

--9)Devuelve un listado que muestre el nombre de cada empleados, 
--el nombre de su jefe y el nombre del jefe de sus jefe.
				--FALTAAAAAA
--10)Devuelve el nombre de los clientes a los que no
--se les ha entregado a tiempo un pedido.

				SELECT C.nombre_cliente FROM pedido P INNER JOIN
				cliente C ON C.codigo_cliente=P.codigo_cliente
				WHERE P.estado='Pendiente'

--11)Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

							SELECT DISTINCT C.nombre_cliente,GP.gama FROM cliente C
							INNER JOIN pedido P
							ON C.codigo_cliente=P.codigo_cliente
							INNER JOIN detalle_pedido DP
							ON P.codigo_pedido=DP.codigo_pedido
							INNER JOIN producto PP
							ON DP.codigo_producto=PP.codigo_producto
							INNER JOIN gama_producto GP
							ON PP.gama=GP.gama
							

-----------------------------1.4.6 Consultas multitabla (Composición externa)
----Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.

--1)Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

					SELECT C.nombre_cliente,C.apellido_contacto FROM cliente C
					LEFT JOIN pago P
					ON P.codigo_cliente=C.codigo_cliente
					WHERE P.codigo_cliente IS NULL

--2)Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
									
							SELECT C.nombre_cliente FROM cliente C
							LEFT JOIN pedido P
							ON P.codigo_cliente=C.codigo_cliente
							WHERE P.codigo_cliente IS NULL

--3)Devuelve un listado que muestre los clientes que no han realizado ningún pago 
--y los que no han realizado ningún pedido.

							SELECT  C.nombre_cliente AS[Clientes que no realizaron pagos],PP.fecha_pago,P.codigo_cliente AS PEDIDOS,PP.codigo_cliente AS PAGOS FROM cliente C
							LEFT JOIN pedido P
							ON C.codigo_cliente=P.codigo_cliente
							LEFT JOIN pago PP
							ON PP.codigo_cliente=C.codigo_cliente
							WHERE P.codigo_cliente IS NULL AND PP.codigo_cliente IS NULL


							



--4)Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
								
								SELECT O.codigo_oficina AS OFICINA,E.codigo_oficina AS EMPLEADO FROM oficina O
								inner JOIN empleado E
								ON  O.codigo_oficina=E.codigo_oficina
								WHERE E.codigo_oficina IS NULL

--5)Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

				SELECT E.nombre,c.* FROM empleado E
				LEFT JOIN cliente C
				ON C.codigo_empleado_rep_ventas=E.codigo_empleado
				WHERE C.codigo_empleado_rep_ventas IS NULL


--6)Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado
--junto con los datos de la oficina donde trabajan.
								
				SELECT E.nombre,O.* FROM empleado E
				LEFT JOIN cliente C
				ON C.codigo_empleado_rep_ventas=E.codigo_empleado
				INNER JOIN oficina O 
				ON O.codigo_oficina=E.codigo_oficina
				WHERE C.codigo_empleado_rep_ventas IS NULL


--7)Devuelve un listado que muestre los empleados que no tienen una oficina asociada
--y los que no tienen un cliente asociado.
						
						SELECT CONCAT(E.nombre ,' ', E.apellido1) AS Empleado,C.codigo_empleado_rep_ventas,O.codigo_oficina FROM empleado E
						LEFT JOIN oficina O
						ON E.codigo_oficina=O.codigo_oficina
						LEFT JOIN cliente C
						ON C.codigo_empleado_rep_ventas=E.codigo_empleado
						WHERE C.codigo_empleado_rep_ventas IS NULL and E.codigo_oficina IS NULL

				
--8)Devuelve un listado de los productos que nunca han aparecido en un pedido.

					SELECT  DISTINCT P.nombre FROM producto P
					LEFT JOIN detalle_pedido DP
					ON DP.codigo_producto=P.codigo_producto
					LEFT JOIN pedido PP 
					ON PP.codigo_pedido=DP.codigo_pedido
					WHERE DP.codigo_producto IS NULL

				

--9)Devuelve un listado de los productos que nunca han aparecido en un pedido. 
--El resultado debe mostrar el nombre, la descripción y la imagen del producto.

					SELECT  P.nombre,P.descripcion,GP.imagen FROM producto P
					LEFT JOIN detalle_pedido DP
					ON DP.codigo_producto=P.codigo_producto
					LEFT JOIN pedido PP 
					ON PP.codigo_pedido=DP.codigo_pedido
					INNER JOIN gama_producto GP
					ON GP.gama=P.gama
					WHERE DP.codigo_producto IS NULL

					SELECT * FROM gama_producto

--10)Devuelve las oficinas donde no trabajan ninguno de los empleados 
--que hayan sido los representantes de ventas de algún cliente que haya realizado la compra 
--de algún producto de la gama Frutales.


							select distinct o.codigo_oficina as [Sin EMp],e.puesto,c.nombre_cliente,gp.gama from oficina o
							left join empleado e
							on e.codigo_oficina=o.codigo_oficina
							left join cliente c
							on e.codigo_empleado=c.codigo_empleado_rep_ventas
							left join pedido p 
							on c.codigo_cliente=p.codigo_cliente
							left join detalle_pedido dp
							on p.codigo_pedido=dp.codigo_pedido
							left join producto pp
							on pp.codigo_producto=dp.codigo_producto
							left join gama_producto gp
							on gp.gama=pp.gama
							where e.puesto<>'Representante Ventas' and gp.gama='Frutales'


						

--11)Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

								select  c.nombre_cliente,p.codigo_cliente as [Pago del Cliente],pp.codigo_cliente as [pedido del cliente],pp.codigo_pedido as [Numero de Pedido] from cliente c
								left join pago p
								on p.codigo_cliente=c.codigo_cliente
								inner join pedido pp
								on pp.codigo_cliente=c.codigo_cliente
								where p.codigo_cliente is null and pp.codigo_cliente is not null



--12)Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.

												SELECT E.nombre,C.codigo_empleado_rep_ventas,E.codigo_jefe FROM empleado E
												LEFT JOIN cliente C
												ON E.codigo_empleado=C.codigo_empleado_rep_ventas
												WHERE C.codigo_empleado_rep_ventas IS NULL AND E.codigo_jefe IS NULL



--1.4.7 Consultas resumen
--1)¿Cuántos empleados hay en la compañía?

					SELECT COUNT(*)AS [Cantidad De Empleados] FROM empleado

--2)¿Cuántos clientes tiene cada país?

						SELECT pais,COUNT(codigo_cliente)AS Cantidad FROM cliente
						GROUP BY pais



--3)¿Cuál fue el pago medio en 2009?
				
				SELECT AVG(total) FROM pago
				WHERE YEAR(fecha_pago)=2009


--4)¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.

											SELECT estado,COUNT(*)AS Cantidad FROM pedido P
											GROUP BY estado

--5)Calcula el precio de venta del producto más caro y más barato en una misma consulta.
						
						SELECT MAX(precio_venta)as Maximo,MIN(precio_venta)as Minimo FROM producto

--6)Calcula el número de clientes que tiene la empresa.

					SELECT COUNT(*)AS [Cantidad De Clientes] FROM cliente 


--7)¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

						SELECT COUNT(*)AS [Cantidad De Clientes en Madrid] FROM cliente
						WHERE ciudad='Madrid'

--8)¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?

					SELECT ciudad,COUNT(*)AS Cantidad FROM cliente
					WHERE ciudad LIKE 'M%'
					GROUP BY ciudad
--9)Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.

							SELECT E.nombre, E.puesto,COUNT(C.codigo_empleado_rep_ventas)AS CANTIDAD FROM empleado E
							INNER JOIN cliente C
							ON E.codigo_empleado=C.codigo_empleado_rep_ventas
							WHERE E.puesto='Representante ventas'
							GROUP BY E.nombre,E.puesto


--10)Calcula el número de clientes que no tiene asignado representante de ventas.

									SELECT COUNT(*)AS CANTIDAD FROM cliente
									WHERE codigo_empleado_rep_ventas IS NULL
									GROUP BY nombre_cliente

									SELECT * FROM cliente


--11)Calcula la fecha del primer y último pago realizado por cada uno de los clientes.
--El listado deberá mostrar el nombre y los apellidos de cada cliente.

					SELECT c.codigo_cliente,C.nombre_cliente,c.apellido_contacto,MIN(fecha_pago)as [Primer Pago],MAX(P.fecha_pago)as [Ultimo Pago],
					datediff(MONTH,MIN(fecha_pago),MAX(P.fecha_pago)) as [Distancia De Mes]
					FROM pago P
					INNER JOIN cliente C
					ON P.codigo_cliente=C.codigo_cliente
					

					GROUP BY C.nombre_cliente,c.codigo_cliente,c.apellido_contacto
					
				

--12)Calcula el número de productos diferentes que hay en cada uno de los pedidos.
								
								SELECT DISTINCT DP.codigo_producto,PP.nombre FROM pedido P
								INNER JOIN detalle_pedido DP
								ON DP.codigo_pedido=P.codigo_pedido
								INNER JOIN producto PP
								ON PP.codigo_producto=DP.codigo_producto
								GROUP BY DP.codigo_producto,PP.nombre
			
--13)Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.

					SELECT P.codigo_pedido AS Pedido, SUM(DP.cantidad)AS [Total De Productos] FROM pedido P
					INNER JOIN detalle_pedido DP
					ON P.codigo_pedido=DP.codigo_pedido
					GROUP BY P.codigo_pedido

					
--14)Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. 
--El listado deberá estar ordenado por el número total de unidades vendidas.

								SELECT TOP 20  P.nombre,SUM(DP.cantidad)AS CANTIDAD FROM detalle_pedido DP
								INNER JOIN producto P
								ON DP.codigo_producto=P.codigo_producto
								GROUP BY P.nombre
								ORDER BY CANTIDAD DESC

								SELECT * FROM detalle_pedido		
								
--15)La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, 
--el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por 
--el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible,
--y el total la suma de los dos campos anteriores.

SELECT SUM(cantidad * precio_unidad )as [Facturado SIN IVA] ,SUM(cantidad * precio_unidad)*1.21 as [Facturado CON IVA]  FROM detalle_pedido 
		
--16)La misma información que en la pregunta anterior, pero agrupada por código de producto.
						
						SELECT SUM(cantidad * precio_unidad )as [Facturado SIN IVA] ,SUM(cantidad * precio_unidad)*1.21 as [Facturado CON IVA]  FROM detalle_pedido 
							group by codigo_producto

--17)La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada
--por los códigos que empiecen por OR.

									SELECT SUM(cantidad * precio_unidad )as [Facturado SIN IVA] ,
									SUM(cantidad * precio_unidad)*1.21 as [Facturado CON IVA]  FROM detalle_pedido 
									where codigo_producto like 'OR%'
							group by codigo_producto

--18)Lista las ventas totales de los productos que hayan facturado más de 3000 euros. 
--Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
								
								SELECT * FROM
								(
								SELECT P.nombre,DP.cantidad,SUM(DP.cantidad*DP.precio_unidad)AS [Total Facturado],
								SUM(DP.cantidad*DP.precio_unidad)*1.21 AS [Total Facturado Con IVA] FROM detalle_pedido DP
								INNER JOIN  producto P
								ON DP.codigo_producto=P.codigo_producto
								GROUP BY P.nombre,DP.cantidad
								) AS T
								WHERE [Total Facturado]>3000

								ORDER BY [Total Facturado] DESC


--19)Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.

					SELECT YEAR(fecha_pago)AS Año,SUM(total)AS TOTAL FROM pago
					GROUP BY YEAR(fecha_pago)



-----------------------------------1.4.8 Subconsultas
------------------------1.4.8.1 Con operadores básicos de comparación
--1)Devuelve el nombre del cliente con mayor límite de crédito.
				
					SELECT nombre_cliente FROM cliente
					WHERE limite_credito=(SELECT  MAX(limite_credito) FROM CLIENTE)

--2)Devuelve el nombre del producto que tenga el precio de venta más caro.

							SELECT nombre FROM producto
							WHERE precio_venta=(SELECT MAX(precio_venta) FROM producto)

--3)Devuelve el nombre del producto del que se han vendido más unidades.
--(Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto
--a partir de los datos de la tabla detalle_pedido)

							

				SELECT TOP 1 nombre  FROM 
				(

		SELECT DP.codigo_producto, P.nombre ,SUM(cantidad) AS CANTIDAD FROM producto P
		INNER JOIN detalle_pedido DP
		ON P.codigo_producto=DP.codigo_producto
		GROUP BY P.nombre,DP.codigo_producto
			
				) AS T										
				ORDER BY CANTIDAD	DESC								


--4)Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).

									SELECT * FROM 
									(
										SELECT C.nombre_cliente AS NOMBRE_CLIENTE,C.limite_credito AS LIMITE,P.total AS MONTO FROM cliente C
										INNER JOIN pago P
										ON C.codigo_cliente=P.codigo_cliente
									
									) AS T
									WHERE LIMITE>MONTO
									


--5)Devuelve el producto que más unidades tiene en stock.
					
					SELECT * FROM producto
					WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) FROM producto )

					

--6)Devuelve el producto que menos unidades tiene en stock.

										SELECT * FROM producto
					WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM producto )

--7)Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.

												SELECT nombre,apellido1,email FROM empleado
												WHERE codigo_jefe=(SELECT codigo_jefe FROM empleado
																		WHERE nombre='Alberto' AND apellido1='Soria')

---------------------------------1.4.8.2 Subconsultas con ALL y ANY
--1)Devuelve el nombre del cliente con mayor límite de crédito.

							SELECT DISTINCT nombre_cliente,LIMITE_CREDITO FROM cliente,PAGO
							WHERE limite_credito =ANY(SELECT MAX(limite_credito) FROM cliente)

--2)Devuelve el nombre del producto que tenga el precio de venta más caro.
						SELECT * FROM producto
						WHERE precio_venta=ANY(SELECT MAX(PRECIO_VENTA) FROM PRODUCTO)
--3)Devuelve el producto que menos unidades tiene en stock

						SELECT * FROM producto
						WHERE cantidad_en_stock=(SELECT MIN(cantidad_en_stock) FROM producto)

------------------------------1.4.8.3 Subconsultas con IN y NOT IN
--1)Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.

				SELECT * FROM EMPLEADO
				WHERE CODIGO_EMPLEADO not IN(SELECT codigo_empleado_rep_ventas FROM CLIENTE
											where codigo_empleado_rep_ventas is not null)


											select e.nombre as Empleado,c.nombre_cliente as Cliente from empleado e
											left join cliente c
											on c.codigo_empleado_rep_ventas=e.codigo_empleado
											where c.codigo_empleado_rep_ventas is null

--2)Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
							
							select * from cliente c
							where codigo_cliente not in (select codigo_cliente from pago)


--3)Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.

									select * from cliente
									where codigo_cliente in(select codigo_cliente from pago)

--4)Devuelve un listado de los productos que nunca han aparecido en un pedido.
								
								select nombre from producto p
								where not exists (select distinct codigo_pedido from detalle_pedido dp
															where p.codigo_producto=dp.codigo_producto)

--5)Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante 
--de ventas de ningún cliente.

						SELECT * FROM empleado 
						WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente
															WHERE codigo_empleado_rep_ventas IS NOT NULL)


--6)Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas
--de algún cliente que haya realizado la compra de algún producto de la gama Frutales.

									select * from oficina
									where codigo_oficina NOT IN (select codigo_oficina from empleado E
																INNER JOIN cliente C
																ON C.codigo_empleado_rep_ventas=E.codigo_empleado
																INNER JOIN pedido P
																ON P.codigo_cliente=C.codigo_cliente
																INNER JOIN detalle_pedido DP
																ON DP.codigo_pedido=P.codigo_pedido
																INNER JOIN producto PP 
																ON PP.codigo_producto=DP.codigo_producto
																INNER JOIN gama_producto GP
																ON GP.gama=PP.gama
															where puesto<>'Representante Ventas' and GP.gama='Frutales' )

--7)Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
										
										SELECT * FROM cliente
										WHERE codigo_cliente IN (SELECT P.codigo_cliente FROM pedido P
																	LEFT JOIN pago PP
																	ON P.codigo_cliente=PP.codigo_cliente
																	WHERE P.codigo_cliente IS NOT NULL AND PP.codigo_cliente IS NULL)

------------------------------1.4.8.4 Subconsultas con EXISTS y NOT EXISTS
--1)Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

						select * from cliente c
						where not exists(select  * from pago p
											where p.codigo_cliente=c.codigo_cliente)

--2)Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.

						select * from cliente c
						where exists(select * from pago p
										where p.codigo_cliente=c.codigo_cliente)

--3)Devuelve un listado de los productos que nunca han aparecido en un pedido.
							
							select * from producto p
							where not exists(select * from detalle_pedido dp
												where dp.codigo_producto=p.codigo_producto)

--4)Devuelve un listado de los productos que han aparecido en un pedido alguna vez.

					select * from producto p
					where exists(select * from detalle_pedido dp
									where p.codigo_producto=dp.codigo_producto)

----------------------------1.4.8.5 Subconsultas correlacionadas
-------------------------------1.4.9 Consultas variadas
--1)Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado.
--Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.

						select c.nombre_cliente,COUNT(p.codigo_cliente)as Cantidad from cliente c
						left join pedido p
						on p.codigo_cliente=c.codigo_cliente
						group by c.nombre_cliente
						order by Cantidad desc

--2)Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos.
--Tenga en cuenta que pueden existir clientes que no han realizado ningún pago. S

				select * from (
				
				SELECT C.nombre_cliente,P.total AS Total FROM cliente C
				LEFT JOIN pago P
				ON C.codigo_cliente=P.codigo_cliente
				
				) AS T
					ORDER BY Total DESC

--3)Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.

					SELECT nombre_cliente FROM cliente
					WHERE codigo_cliente IN(SELECT DISTINCT C.codigo_cliente FROM cliente C
												INNER JOIN pedido P
												ON P.codigo_cliente=C.codigo_cliente
												WHERE YEAR(fecha_pedido)=2008)
												ORDER BY nombre_cliente ASC

--4)Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas
--y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.

						SELECT * FROM(
						SELECT C.nombre_cliente,E.nombre,E.apellido1,O.telefono FROM cliente C
						LEFT JOIN empleado E
						ON E.codigo_empleado=C.codigo_empleado_rep_ventas
						LEFT JOIN pago P
						ON P.codigo_cliente=C.codigo_cliente
						INNER JOIN oficina O
						ON O.codigo_oficina=E.codigo_oficina
						WHERE P.codigo_cliente IS NULL
						)AS T


						SELECT C.nombre_cliente,P.codigo_cliente AS PAGO FROM cliente C
						LEFT JOIN pago P
						ON P.codigo_cliente=C.codigo_cliente
						WHERE P.codigo_cliente IS NULL


--5)Devuelve el listado de clientes donde aparezca el nombre del cliente, 
--el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.

							SELECT * FROM (
							SELECT C.nombre_cliente AS Cliente,CONCAT(E.nombre ,' ' , E.apellido1)AS Empleado,O.ciudad AS [Ciudad De Oficina]  FROM cliente C
							INNER JOIN empleado E
							ON C.codigo_empleado_rep_ventas=E.codigo_empleado
							INNER JOIN oficina O
							ON O.codigo_oficina=E.codigo_oficina
							
							)AS T

--6)Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que 
--no sean representante de ventas de ningún cliente.

								SELECT * FROM empleado E
								LEFT JOIN cliente C
								ON E.codigo_empleado=C.codigo_empleado_rep_ventas
								WHERE C.codigo_empleado_rep_ventas IS NULL

--7)Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.

		SELECT * FROM 
		(
				SELECT O.ciudad AS [Ciudad De Oficina],COUNT(E.codigo_oficina)AS CANTIDAD_EMPLEADOS FROM oficina O
				INNER JOIN empleado E
				ON E.codigo_oficina=O.codigo_oficina
				GROUP BY O.ciudad
		
		
		)AS T
		ORDER BY CANTIDAD_EMPLEADOS DESC