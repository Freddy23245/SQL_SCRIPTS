----1.1.7 --"Subconsultas (En la cláusula WHERE)"
----1.1.7.1 Con operadores básicos de comparación
--1)Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
			use tienda

			select nombre as Producto from producto
			where codigo_fabricante in (select codigo from fabricante where nombre='Lenovo')




--2)Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro
--del fabricante Lenovo. (Sin utilizar INNER JOIN).
									
									SELECT nombre as Producto,precio FROM producto
									WHERE precio=(SELECT MAX(P.precio) FROM producto P INNER JOIN fabricante F
													ON P.codigo_fabricante=F.codigo
													WHERE F.nombre='Lenovo')

												
--3)Lista el nombre del producto más caro del fabricante Lenovo.
			
			select nombre as Producto from producto
			where precio=(select MAX(p.precio) from fabricante f
			inner join producto p on p.codigo_fabricante=f.codigo
			where f.nombre='Lenovo')

--4)Lista el nombre del producto más barato del fabricante Hewlett-Packard.

					select nombre as [Producto Barato] from producto
					where precio=(select MIN(p.precio) from fabricante f 
									inner join producto p on p.codigo_fabricante=f.codigo
									where f.nombre='Hewlett-Packard')

									select p.nombre,p.precio,f.nombre,codigo_fabricante from fabricante f 
									inner join producto p on p.codigo_fabricante=f.codigo
									where f.nombre='Hewlett-Packard'

--5)Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro 
--del fabricante Lenovo.

							select nombre as Producto,precio as Precio, codigo_fabricante from producto
							where precio>=(select MAX(p.precio) from fabricante f 
											inner join producto p on p.codigo_fabricante=f.codigo
											where f.nombre='Lenovo')

					

--6)Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.

						select nombre as Producto,codigo_fabricante,precio from producto
						where precio >=(select AVG(p.precio) from fabricante f inner join		
										producto p on f.codigo=p.codigo_fabricante
										WHERE f.nombre='Asus') and codigo_fabricante=1


----1.1.7.2 Subconsultas con ALL y ANY
											


--1)Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni TOP.

						
						select  * from producto p1
						where precio>=all(select precio from producto p2)
						order by precio 

--2)Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.
							
							select * from producto
							where  precio <=all(select precio from producto)

--3)Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).
					
					select * from fabricante
					where codigo = any( select codigo_fabricante from producto)

--4)Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).

						select nombre as Fabricante from fabricante
						where codigo <>all(select codigo_fabricante from producto)

----1.1.7.3 Subconsultas con IN y NOT IN


--1)Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).

			select nombre from fabricante
			where codigo in (select codigo_fabricante from producto)

--2)Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).

			select nombre from fabricante
			where codigo not in (select codigo_fabricante from producto)

----1.1.7.4 Subconsultas con EXISTS y NOT EXISTS
--1)Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).
		
		select nombre from fabricante f
		where  exists(select codigo_fabricante from producto p
						where p.codigo_fabricante=f.codigo )

--2)Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).
							
							select nombre from fabricante f
							where not exists(select * from producto p
												where f.codigo=p.codigo_fabricante)
				
----1.1.7.5 Subconsultas correlacionadas
--1)Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.
				
				select f.nombre,MAX(p.precio)as [Producto mas caro],COUNT(codigo_fabricante) from fabricante f
				inner join producto p
				on p.codigo_fabricante=f.codigo
				group by p.codigo_fabricante,f.nombre



--2)Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos 
--los productos de su mismo fabricante.
							
							select * from(
									select codigo_fabricante,AVG(precio)as media from producto p
									group by codigo_fabricante) as t
												inner join producto p1
												on p1.codigo_fabricante=t.codigo_fabricante
												where p1.precio>t.media
							

--3)Lista el nombre del producto más caro del fabricante Lenovo.

			select nombre from producto
			where precio=(select MAX(p.precio) from fabricante f
							inner join producto p
							on f.codigo=p.codigo_fabricante
							where f.nombre='Lenovo')

----1.1.8 Subconsultas (En la cláusula HAVING)
--1)Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que 
--el fabricante Lenovo.

select f.nombre,COUNT(p.codigo) from fabricante f 
inner join producto p on p.codigo_fabricante=f.codigo
group by f.codigo,f.nombre
having COUNT(p.codigo) >=  (select COUNT(p.codigo) from fabricante f inner join
			producto p on f.codigo=p.codigo_fabricante
			where f.nombre='Lenovo')





