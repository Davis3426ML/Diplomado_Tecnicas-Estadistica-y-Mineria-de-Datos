/** Vamos a realizar una serie de actividades que nos ayudara a la manipulacion y 
						extraccion de datos de nuestro database (Por medio de unos ejercicios) **/
			Use Base_Inventario;
				/** ----------------- Ejercicio #1 ----------------- **/
	Insert Into Estados
		Values ('MX', 'Edo. México');
        
	Select * From Estados
		Where Estado = 'MX';
                
                /** ----------------- Ejercicio #2 ----------------- **/
	Insert Into Clientes
		Values (129, 'David', 'Mendieta', 'UNAM', 'Alcanfores San Juan', NULL, 'México', 'MX', '53150', '55-56231643');

	Select * From Clientes
		Where NUM_cliente = 129;
        
                /** ----------------- Ejercicio #3 ----------------- **/
	Select * From Inventarios				# Hay registros con precios de 45.00 #
		Where precio_unitario = 45;
        
	Update Inventarios Set precio_unitario = 40
        Where NUM_inventario In (108,204);			# actualizamos con 40.00 de los 2 registros #
	
	Select * From Inventarios				# Corroboramos los registros #
		Where precio_unitario = 40;
                
                /** ----------------- Ejercicio #4 ----------------- **/
	COMMIT WORK;	/** Esta sentencia grabara definitivamente los cambios que acabas 
									de aplicar a tus tablas (Conocida como transaccion)**/
    
    BEGIN WORK;		/** Empezamos una nueva transaccion **/
                
                /** ----------------- Ejercicio #5 ----------------- **/
	Delete From Clientes
		Where NUM_cliente = 129;
                
                /** ----------------- Ejercicio #6 ----------------- **/
	Select NUM_cliente, nombre, apellidos From Clientes  # Visualizamo 3 columnas de clientes #
                
                /** ----------------- Ejercicio #7 ----------------- **/
	ROLLBACK WORK;		# esta sentencia deshace las operaciones realizadas a partir del último "COMMIT WORK" #
                
                /** ----------------- Ejercicio #8 ----------------- **/
	Select NUM_cliente, nombre, apellidos From Clientes;  # Visualizamo 3 columnas de clientes #
                
                /** ----------------- Ejercicio #9 ----------------- **/
	Select NUM_orden, Sum(precio_total) AS 'Precio_Grupal' FROM Articulos
		GROUP By NUM_orden;
                
                /** ----------------- Ejercicio #10 ----------------- **/
	Select NUM_orden, Sum(precio_total) AS 'Precio_Grupal' FROM Articulos
		GROUP By NUM_orden
			Having Sum(precio_total) > 250;
                