/** Para la carga de datos es necesario el descargar y descomprimir el archivo .ZIP; 
	luego vamos aguardarla en la ruta de nuestra MYSQL que pueda leer la documentacion **/

/** Este comando nos indica en la ruta de nuestro "lectura_Documentos" **/
	Show Variables Like 'secure_file_priv';

/** Por Practica; guardamos nuestra ruta en comentarios **/
	/** 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\' (Para MYSQL acepta con "\\")**/
  
/** Antes de continuar; hay que verificar si nuestra database tiene (o no) las tablas en cuestion de este forma **/
    Show Full Tables From base_inventario;
    
/** Verificamos que los atributos este ne orden a como lo creamos en cada tabla **/
	Use Base_Inventario;
		Desc Articulos;
		Desc Clientes;
		Desc Estados;
		Desc Inventarios;
		Desc Ordenes;
		Desc Proveedores;
        
/** En caso de arruinar nuestra carga en una tabla, podemos borrarlas y volver a comenzar **/
		Delete From Articulos;
		Delete From Clientes;
		Delete From Estados;
		Delete From Inventarios;
		Delete From Ordenes;
		Delete From Proveedores;
        
/** ================================================================================================== **/
			/** Pasamos directamente a carga los datos de forma manual **/
            
	# Articulos #
Load Data Infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\articulos.txt'		# descargamos los datos por este ruta #
Into Table Articulos			# Indicamos que los haga en este tabla #
Fields Terminated By '|'		# Indicamos que esta separando cada campo #
Lines Terminated By '\n'		# Indicamos los registros tiene salto de linea #
(NUM_articulo, NUM_orden, NUM_inventario, Codigo_proveedor, cantidad, precio_total);  # de esta forma los datos son direccionados a los campos correspondiente #

Select Count(*) From Articulos;  # Checamos el numero de registros #


	# Clientes #
Load Data Infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\clientes.txt'
Into Table Clientes
Fields Terminated By '|'
Lines Terminated By '\n'
(NUM_cliente, nombre, apellidos, compania, direccion1, direccion2, ciudad, estado, CP, telefono);

Select Count(*) From Clientes;


	# Estados #
Load Data Infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\estados.txt'
Into Table Estados
Fields Terminated By '|'
Lines Terminated By '\n'
(Estado, nombre_estado);

Select Count(*) From Estados;


	# Inventarios #
Load Data Infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\inventarios.txt'
Into Table Inventarios
Fields Terminated By '|'
Lines Terminated By '\n'
(NUM_inventario, Codigo_proveedor, descripcion, precio_unitario, unidad, descripcion_unidad);

Select Count(*) From Inventarios;


	# Ordenes #
SET @@SESSION.sql_mode='ALLOW_INVALID_DATES';		# Permite insertar fechas inválidas en las columnas de tipo DATE, evitando errores si algunos registros #

Load Data Infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ordenes.txt'
Into Table Ordenes
Fields Terminated By '|' 
Lines Terminated By '\n' 
(NUM_orden, @fecha_orden, NUM_cliente, instrucciones, disponible, 		# el "@" indicamos que dicho campo se vuelva una variable y podamos manipular los datos (cambios de ultimo momento) #
	num_pedido, @fecha_envio, peso_envio, cargo_envio, @fecha_pago)
SET fecha_orden = STR_TO_DATE(@fecha_orden, '%d/%m/%Y'),
    fecha_envio = STR_TO_DATE(@fecha_envio, '%d/%m/%Y'),		# el SET se usa para indicar como manipular los datos de nuestra variables #
    fecha_pago = STR_TO_DATE(@fecha_pago, '%d/%m/%Y');

Select Count(*) From Ordenes;


	# Proveedores #
Load Data Infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\proveedores.txt'
Into Table Proveedores
Fields Terminated By '|'
Lines Terminated By '\n'
(Codigo_proveedor, nombre_proveedor);

Select Count(*) From Proveedores;