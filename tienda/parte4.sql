--1.1.6 Consultas resumen
--1)Calcula el número total de productos que hay en la tabla productos.
			select COUNT(*) from producto

--2)Calcula el número total de fabricantes que hay en la tabla fabricante.
					
						select COUNT(*) from fabricante

--3)Calcula el número de valores distintos de código de fabricante aparecen en la tabla productos.
					
					select distinct count(*) as Valores,codigo_fabricante from producto
					group by codigo_fabricante
				
--4)Calcula la media del precio de todos los productos.

		select AVG(precio) from producto

--5)Calcula el precio más barato de todos los productos.

			select MIN(precio) from producto

--6)Calcula el precio más caro de todos los productos.
			
			select MAX(precio) from producto

--7)Lista el nombre y el precio del producto más barato.
			
			select nombre,precio from producto
			where precio=(select MIN(precio) from producto)
			

--8)Lista el nombre y el precio del producto más caro.

				select nombre,precio from producto
				where precio=(select MAX(precio) from producto)

--9)Calcula la suma de los precios de todos los productos.

				select SUM(precio) from producto
			
--10)Calcula el número de productos que tiene el fabricante Asus.

			select COUNT(*)as [Cantidad De Productos],fab.nombre as Fabricante from producto prod inner join
			fabricante fab on prod.codigo_fabricante=fab.codigo
				where fab.nombre='Asus'
			group by codigo_fabricante,fab.nombre
			
		


			select* from fabricante
			select * from producto


--11)Calcula la media del precio de todos los productos del fabricante Asus.
			
			select AVG(precio) as media from producto prod
			inner join fabricante fab
			on prod.codigo_fabricante=fab.codigo
			where fab.nombre='Asus'
			
			
--12)Calcula el precio más barato de todos los productos del fabricante Asus.
					
					select fab.nombre,precio from producto prod
					inner join fabricante fab
					on prod.codigo_fabricante=fab.codigo
					where fab.nombre='Asus' and prod.precio=(select MIN(prod2.precio) from producto prod2 
															inner join fabricante fab2 
															on prod2.codigo_fabricante=fab2.codigo
																where fab2.nombre='Asus'
																	group by prod2.codigo_fabricante	
															)
															


																

--13)Calcula el precio más caro de todos los productos del fabricante Asus.
				
									
					select fab.nombre,precio from producto prod
					inner join fabricante fab
					on prod.codigo_fabricante=fab.codigo
					where fab.nombre='Asus' and prod.precio=(select MAX(prod2.precio) from producto prod2 
															inner join fabricante fab2 
															on prod2.codigo_fabricante=fab2.codigo
																where fab2.nombre='Asus'
																	group by prod2.codigo_fabricante	
															)

--14)Calcula la suma de todos los productos del fabricante Asus.
							
							select SUM(prod.precio) as [Suma de Precios de Productos ASUS] from producto prod
							inner join fabricante fab
							on prod.codigo_fabricante=fab.codigo
							where fab.nombre='Asus'
					

--15)Muestra el precio máximo, precio mínimo, precio medio y el número total de productos
--que tiene el fabricante Crucial.
								
									select MAX(prod.precio)as Maximo,MIN(prod.precio)as Minimo,AVG(prod.precio)as Promedio,COUNT(*)as Cantidad  from producto prod
							inner join fabricante fab
							on prod.codigo_fabricante=fab.codigo
							where fab.nombre='Crucial'


--16)Muestra el número total de productos que tiene cada uno de los fabricantes.
--El listado también debe incluir los fabricantes que no tienen ningún producto. 
--El resultado mostrará dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene. 
--Ordene el resultado descendentemente por el número de productos.
								
								select fab.nombre ,COUNT(prod.codigo_fabricante)as Cantidad from fabricante fab 
								left join producto prod 
								on prod.codigo_fabricante=fab.codigo
								group by prod.codigo_fabricante,fab.nombre
								order by Cantidad desc
					

--17)Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes.
--El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.
	


select fab.nombre, MAX(prod.precio)as Maximo,MIN(prod.precio)as Minimo,AVG(prod.precio)as Promedio from producto prod
							inner join fabricante fab
							on prod.codigo_fabricante=fab.codigo
							group by prod.codigo_fabricante,fab.nombre



--18)Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes
--que tienen un precio medio superior a 200€. No es necesario mostrar el nombre del fabricante, con el código
--del fabricante es suficiente.

select * from 
(

select fab.nombre, MAX(prod.precio)as Maximo,MIN(prod.precio)as Minimo,AVG(prod.precio)as Promedio from producto prod
							inner join fabricante fab
							on prod.codigo_fabricante=fab.codigo
							group by prod.codigo_fabricante,fab.nombre

)as t
where Promedio>200

--19)Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio
--y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. 
--Es necesario mostrar el nombre del fabricante.

				select * from 
(

select fab.nombre, MAX(prod.precio)as Maximo,MIN(prod.precio)as Minimo,AVG(prod.precio)as Promedio,COUNT(codigo_fabricante)as Cantidad from producto prod
							inner join fabricante fab
							on prod.codigo_fabricante=fab.codigo
							group by prod.codigo_fabricante,fab.nombre

)as t
where Promedio>200


--20)Calcula el número de productos que tienen un precio mayor o igual a 180€.

			select COUNT(*)as Cantidad from producto
			where precio>=180

--21)Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.
						
						select fab.nombre,COUNT(codigo_fabricante)as Cantidad from producto prod inner join
						fabricante fab on prod.codigo_fabricante=fab.codigo
						where prod.precio>=180
						group by codigo_fabricante,fab.nombre

--22)Lista el precio medio los productos de cada fabricante, mostrando solamente el código del fabricante.
								
								select fab.codigo,fab.nombre,AVG(prod.precio)as Media from producto prod
								inner join fabricante fab
								on prod.codigo_fabricante=fab.codigo
								group by codigo_fabricante,fab.nombre,fab.codigo
										
--23)Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.
							
							select fab.nombre,AVG(prod.precio)as Media from producto prod inner join
							fabricante fab on prod.codigo_fabricante=fab.codigo
							group by prod.codigo_fabricante,fab.nombre


--24)Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.

					select fab.nombre from fabricante fab
					inner join producto prod
					on fab.codigo=prod.codigo_fabricante
					group by prod.codigo_fabricante,fab.nombre
					having avg(prod.precio)>=150

--25)Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.

			select * from 
			(
			
			select fab.nombre,COUNT(codigo_fabricante)as Cantidad from fabricante fab 
			inner join producto prod
			on fab.codigo=prod.codigo_fabricante
			group by prod.codigo_fabricante,fab.nombre
			)as T
			where Cantidad>=2

--26)Devuelve un listado con los nombres de los fabricantes y el número de productos
--que tiene cada uno con un precio superior o igual a 220 €. 
--No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.
--Ejemplo del resultado esperado:

--nombre	total
--Lenovo	2
--Asus	    1
--Crucial	1


					select fab.nombre,COUNT(codigo_fabricante)as Cantidad from fabricante fab 
					inner join producto prod 
					on fab.codigo=prod.codigo_fabricante
					where prod.precio>220
					group by prod.codigo_fabricante,fab.nombre
					order by Cantidad desc







--27)Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno 
--con un precio superior o igual a 220 €. El listado debe mostrar el nombre de todos los fabricantes,
--es decir, si hay algún fabricante que no tiene productos con un precio superior o igual a 220€ deberá aparecer
--en el listado con un valor igual a 0 en el número de productos.
--Ejemplo del resultado esperado:

--nombre	total
--Lenovo	2
--Crucial	1
--Asus	1
--Huawei	0
--Samsung	0
--Gigabyte	0
--Hewlett-Packard	0
--Xiaomi	0


					select fab.nombre,COUNT(codigo_fabricante) as Total from fabricante fab 
					left join (select * from producto 
								where precio>220)as prod
								on fab.codigo=prod.codigo_fabricante
								group by prod.codigo_fabricante,fab.nombre
								order by Total desc
								
--28)Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus productos
--es superior a 1000 €.
					select fab.nombre,SUM(prod.precio) as Suma from fabricante fab 
					inner join producto prod
					on fab.codigo=prod.codigo_fabricante
					group by prod.codigo_fabricante,fab.nombre
					having SUM(prod.precio)>1000



--29)Devuelve un listado con el nombre del producto más caro que tiene cada fabricante. 
--El resultado debe tener tres columnas: nombre del producto, precio y nombre del fabricante. 
--El resultado tiene que estar ordenado alfabéticamente de menor a mayor por el nombre del fabricante.

		

	select f.nombre,p.precio,p.nombre from fabricante f,producto p
	where f.codigo=p.codigo_fabricante
	and	p.precio=(select MAX(p.precio) from producto p
					where p.codigo_fabricante=f.codigo)
		order by p.nombre desc