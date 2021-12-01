


--1)Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos
--que tiene cada uno de ellos. El listado deber� mostrar tambi�n aquellos fabricantes
--que no tienen productos asociados.
			
			select fab.*,prod.* from fabricante fab
			left join producto prod on fab.codigo=prod.codigo_fabricante


--2)Devuelve un listado donde s�lo aparezcan aquellos fabricantes que no tienen ning�n producto asociado.
						
						select fab.*,prod.* from fabricante fab 
						left join producto prod on fab.codigo=prod.codigo_fabricante
						where prod.codigo_fabricante is null

--4)�Pueden existir productos que no est�n relacionados con un fabricante? Justifique su respuesta.