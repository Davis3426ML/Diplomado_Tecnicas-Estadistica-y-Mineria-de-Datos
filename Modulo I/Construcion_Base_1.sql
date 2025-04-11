/** Comunmente cuando se desea crear un database; checamos y eliminados la database con el mismo nombre (por practica)**/
	Drop Database If Exists Base_Inventario;
    
/** De esta forma Creamos una database **/
	Create Database Base_Inventario;
    
/** Recordemos colocar esta sentencia al manipular un database en especifico **/
	Use Base_Inventario;
    
/** Deacuerdo a la actividad; vamos a crear 6 Entidades (con su atributos) para empezar con nuestra database **/
	Create Table Estados(
		Estado Char(2),
        nombre_estado Char(15)
	);
    
    Create Table Clientes(
		NUM_cliente Int, nombre Char(15), apellidos Char(15), compania Char(20), direccion1 Char (20), 
        direccion2 Char (20), ciudad Char(15), estado Char(2), CP Char(5), telefono Char(18)
	);
    
    Create Table Inventarios(
		NUM_inventario Smallint, Codigo_proveedor Char(3), descripcion Char(15), 
        precio_unitario Decimal(6,2), unidad Char(4), descripcion_unidad Char(15)
	);
    
    Create Table Proveedores(
		Codigo_proveedor Char(3),
        nombre_proveedor Char(20)
	);
    
    Create Table Ordenes(
		NUM_orden Int, fecha_orden Date, NUM_cliente Int, instrucciones Char(40), disponible Char(1), 
        num_pedido Char(10), fecha_envio Date, peso_envio Decimal(6,2), cargo_envio Decimal(8,2), fecha_pago Date
	);
    
    Create Table Articulos(
		NUM_articulo Smallint, NUM_orden Int, NUM_inventario Smallint, 
        Codigo_proveedor Char(3), cantidad Smallint, precio_total Decimal(8,2)
	);
