--1.1.4 Consultas multitabla (Composición interna)
--Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.

--1)Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos
--de la base de datos.
	select prod.nombre,prod.precio,fab.nombre from producto prod 
	inner join fabricante fab on prod.codigo_fabricante=fab.codigo

--2)Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos 
--los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
				
					select prod.nombre,prod.precio,fab.nombre from producto prod 
					inner join fabricante fab on prod.codigo_fabricante=fab.codigo
					order by fab.nombre
		
--3)Devuelve una lista con el código del producto, nombre del producto, código del fabricante
--y nombre del fabricante, de todos los productos de la base de datos.
		select prod.*,fab.* from producto prod
		inner join fabricante fab on prod.codigo_fabricante=fab.codigo

--4)Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
				select top 1  prod.nombre,prod.precio,fab.nombre from producto prod
		inner join fabricante fab on prod.codigo_fabricante=fab.codigo
				order by prod.precio asc


--5)Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
						
				select top 1  prod.nombre,prod.precio,fab.nombre from producto prod
		inner join fabricante fab on prod.codigo_fabricante=fab.codigo
				order by prod.precio desc

--6)Devuelve una lista de todos los productos del fabricante Lenovo.
						
						select prod.* from producto prod inner join
						fabricante fab on prod.codigo_fabricante=fab.codigo
						where fab.nombre='Lenovo'
					

--7)Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.

					select prod.* from producto prod inner join
						fabricante fab on prod.codigo_fabricante=fab.codigo
						where fab.nombre='Crucial' and prod.precio>200
					

--8)Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate.
--Sin utilizar el operador IN.
					
					select prod.*,fab.nombre from producto prod 
					inner join fabricante fab
					on prod.codigo_fabricante=fab.codigo
					where fab.nombre='Asus' OR fab.nombre='Hewlett-Packardy' OR fab.nombre='Seagate'

				
--9)Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate.
--Utilizando el operador IN.
								
					select prod.*,fab.nombre from producto prod 
					inner join fabricante fab
					on prod.codigo_fabricante=fab.codigo
					where fab.nombre in ( 'Asus', 'Hewlett-Packardy',' Seagate')

--10)Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes
--cuyo nombre termine por la vocal e.
					
					select prod.*,fab.nombre as Fabricante from producto prod 
					inner join fabricante fab
					on prod.codigo_fabricante=fab.codigo
					where fab.nombre like '%e'


--11)Devuelve un listado con el nombre y el precio de todos los productos
--cuyo nombre de fabricante contenga el carácter w en su nombre.
						select prod.*,fab.nombre as Fabricante from producto prod
						inner join fabricante fab on prod.codigo_fabricante=fab.codigo
						where fab.nombre like '%W%'

--12)Devuelve un listado con el nombre de producto, precio y nombre de fabricante,
--de todos los productos que tengan un precio mayor o igual a 180€. 
--Ordene el resultado en primer lugar por el precio (en orden descendente)
--y en segundo lugar por el nombre (en orden ascendente)

				select prod.*,fab.nombre from producto prod
				inner join fabricante fab on prod.codigo_fabricante=fab.codigo
				where prod.precio>=180
				order by precio desc,prod.nombre asc
				


--13)Devuelve un listado con el código y el nombre de fabricante, solamente de aquellos fabricantes 
--que tienen productos asociados en la base de datos

		select * from fabricante fab
		where  codigo  in (select codigo_fabricante from producto prod
							where 
							 fab.codigo=prod.codigo_fabricante	)

		select * from producto