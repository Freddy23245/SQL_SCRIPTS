DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda 
USE tienda;

CREATE TABLE fabricante (
  codigo INT identity(1,1) PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);
go
CREATE TABLE producto (
  codigo INT identity(1,1) PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio decimal(12,2),
  codigo_fabricante INT 
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES( 'Asus');
INSERT INTO fabricante VALUES( 'Lenovo');
INSERT INTO fabricante VALUES( 'Hewlett-Packard');
INSERT INTO fabricante VALUES( 'Samsung');
INSERT INTO fabricante VALUES( 'Seagate');
INSERT INTO fabricante VALUES( 'Crucial');
INSERT INTO fabricante VALUES( 'Gigabyte');
INSERT INTO fabricante VALUES( 'Huawei');
INSERT INTO fabricante VALUES( 'Xiaomi');

INSERT INTO producto VALUES( 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES( 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES( 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES( 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES( 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES( 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES( 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES( 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES( 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES( 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES( 'Impresora HP Laserjet Pro M26nw', 180, 3);


---------------------------------BASES DE DATOS------------------------------------

--1.1.3 Consultas sobre una tabla
--1)Lista el nombre de todos los productos que hay en la tabla producto.

		SELECT * FRoM producto


--2)Lista los nombres y los precios de todos los productos de la tabla producto.

		select nombre,precio from producto

--3)Lista todas las columnas de la tabla producto.

		select codigo,nombre,precio,codigo_fabricante from producto

--4)Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).

		select nombre,precio as Euros,precio as USD from producto

--5)Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.
			
			select nombre,precio as Euros,precio as USD from producto

--6)Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.
			
			select UPPER(nombre) as nombre,precio from producto

--7)Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.

		select LOWER(nombre)as Nombre,precio from producto

--8)Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas
--los dos primeros caracteres del nombre del fabricante.

	select nombre,UPPER(LEFT(nombre,2))as Mayusculas from fabricante

--9)Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
              
			  select nombre,ROUND(precio,1)as Precio from producto


--10)Lista los nombres y los precios de todos los productos de la tabla producto, truncando
--el valor del precio para mostrarlo sin ninguna cifra decimal.

		select nombre,CAST(precio as int)as Precio from producto

--11)Lista el código de los fabricantes que tienen productos en la tabla producto.
			
			select codigo as Fabricante from fabricante 
			where codigo in (select codigo_fabricante from producto)
--12)Lista el código de los fabricantes que tienen productos en la tabla producto, 
--eliminando los códigos que aparecen repetidos.
				
				select distinct codigo_fabricante from producto

--13)Lista los nombres de los fabricantes ordenados de forma ascendente.
				
				select nombre from fabricante
				order by nombre
					
--14)Lista los nombres de los fabricantes ordenados de forma descendente.
				select nombre from fabricante
				order by nombre desc
					
--15)Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente 
--y en segundo lugar por el precio de forma descendente.

						select nombre,precio from producto
						order by nombre asc , precio desc

--16)Devuelve una lista con las 5 primeras filas de la tabla fabricante.
	
		select top 5 * from fabricante

--17)Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante.
--La cuarta fila también se debe incluir en la respuesta.
			
				select * from fabricante
				where codigo between 3 and 4
			
--18)Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)

			select top 1 nombre,precio as PRecio from producto
				order by precio 
				

--19)Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
					
					select top 1 nombre,precio as PRecio from producto 
				order by precio desc

--20)Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.

					select nombre from producto
					where codigo_fabricante=2

--21)Lista el nombre de los productos que tienen un precio menor o igual a 120€.

				select nombre from producto
				where precio<=120

--22)Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
				
				select nombre from producto
				where precio>=400

--23)Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.

					select nombre,precio from producto
				where precio !> 400 

--24)Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
				select * from producto
				where precio between 80 and 300
--25)Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
					
					select * from producto
					where precio between 60 and 200

--26)Lista todos los productos que tengan un precio mayor que 200€ y que el código de fabricante sea igual a 6.
					
					select * from producto
					where codigo_fabricante=6 and precio>200

--27)Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
				
				select * from producto
				where codigo_fabricante=1 or codigo_fabricante=3 or codigo_fabricante=5
				
--28)Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.

						select * from producto
				where codigo_fabricante in (1 ,3 ,5)

--29)Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). 
--Cree un alias para la columna que contiene el precio que se llame céntimos.

			select nombre,precio,(precio*100 )as Centimos from producto

--30)Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.

				select nombre from fabricante
				where nombre like 'S%'

--31)Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
					
					select nombre from fabricante
				where nombre like '%e'

--32)Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
					select nombre from fabricante
				where nombre like '%w%'
--33)Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
				select nombre from fabricante
				where len(nombre)=4
--34)Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.

						select  * from producto 
						where nombre like '%Portatil%'

--35)Devuelve una lista con el nombre de todos los productos que contienen 
--la cadena Monitor en el nombre y tienen un precio inferior a 215 €.

					select * from producto
					where nombre like'%Monitor%' and precio<215

--36)Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. 
--Ordene el resultado en primer lugar por el precio (en orden descendente) 
--y en segundo lugar por el nombre (en orden ascendente).

			select * from producto
			where precio>=180
			order by precio desc,nombre asc