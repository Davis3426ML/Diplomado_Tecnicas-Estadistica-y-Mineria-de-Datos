/** En esta parte veremos el uso de las sentencias "Join" e "Outer" por medio de las por medio de 
		la Sintaxis ANSI que nos dara una apertura mas amplia para las extracion de datos  **/
			Use Base_Inventario;
            
# ========================================= Ejercicio JOIN ============================================== #
            
				/** ----------------- Ejercicio #1 ----------------- **/
	Select C.NUM_cliente, compania, NUM_orden From (Clientes As C) Join (Ordenes As O)
		On C.NUM_cliente = O.NUM_cliente;
    
                /** ----------------- Ejercicio #2 ----------------- **/
	Select C.NUM_cliente, compania, NUM_orden, fecha_orden From (Clientes As C) Join (Ordenes As O)
		On C.NUM_cliente = O.NUM_cliente
			Order By fecha_orden desc;
        
                /** ----------------- Ejercicio #3 ----------------- **/
	Select nombre_proveedor, NUM_inventario, descripcion, unidad, precio_unitario 
		From (Inventarios As I) Join (Proveedores As P)
			On I.Codigo_proveedor = P.Codigo_proveedor;
                
                /** ----------------- Ejercicio #4 ----------------- **/
	Select NUM_articulo, NUM_orden, descripcion From (Articulos As A) Join (Inventarios As I)
		On (A.NUM_inventario = I.NUM_inventario) And (A.Codigo_proveedor = I.Codigo_proveedor)
			Where NUM_orden = 1004;
                
                /** ----------------- Ejercicio #5 ----------------- **/
	Select nombre, apellidos, direccion1, ciudad, nombre_estado From (Estados As E) Join (Clientes As C)
		Using(estado)
			Where nombre_estado like 'A%'
				Order By ciudad Desc;

                /** ----------------- Ejercicio #6 ----------------- **/
	Select nombre, apellidos, O.NUM_orden, A.NUM_articulo 
		From (Clientes As C) Join (Ordenes As O)
		Using (NUM_cliente) Join (Articulos As A) 
        Using (NUM_Orden)
			Where NUM_orden = 1007;
                
                /** ----------------- Ejercicio #7 ----------------- **/
	Select O.NUM_orden, NUM_articulo, NUM_Inventario, P.Codigo_proveedor, nombre_proveedor
		From (Ordenes As O) Join (Articulos As A)
		On O.NUM_orden = A.NUM_orden
        Join (Proveedores As P)
        On P.Codigo_proveedor = A.Codigo_proveedor
			Order By NUM_orden, NUM_articulo;

                /** ----------------- Ejercicio #8 ----------------- **/
	Select nombre_estado, count(NUM_cliente) As 'Total_Clientes'
		From (Estados As E) Join (Clientes As C)
		On E.estado = C.estado
			Group By nombre_estado;						# ???????? #
                
                /** ----------------- Ejercicio #9 ----------------- **/
	Select nombre_estado, count(NUM_cliente) As 'Total_Clientes'
		From (Estados As E) Join (Clientes As C)
		On E.estado = C.estado
			Group By nombre_estado
				Having Total_Clientes > 2
					Order By nombre_estado Desc;
                
                /** ----------------- Ejercicio #10 ----------------- **/
	Select fecha_orden, Avg(precio_total) As 'Promedio_Costos'
		From (Ordenes As O) Join (Articulos As A) 
		Using (NUM_orden)
			Group By fecha_orden
				Order By Promedio_Costos Desc;
				
# ========================================= Ejercicio OUTER ============================================== #
                Use Base_Inventario;
                /** ----------------- Ejercicio #11 ----------------- **/
	Select A.NUM_orden, I.* From (Inventarios As I) Left Outer Join (Articulos As A)
		On (I.NUM_inventario = A.NUM_inventario) And (I.Codigo_proveedor = A.Codigo_proveedor)
			Order By A.NUM_orden;
                
                /** ----------------- Ejercicio #12 ----------------- **/
	Select A.NUM_orden, P.* From (Articulos As A) Right Outer Join (Proveedores As P)
		Using (Codigo_proveedor);
        
				/** ----------------- Ejercicio #13 ----------------- **/
	Select nombre, apellidos, O.NUM_orden, fecha_orden 
		From  (Clientes As C) Left Outer Join (Ordenes As O)
		On (C.NUM_cliente = O.NUM_cliente);
     
                /** ----------------- Ejercicio #14 ----------------- **/
	Select nombre_estado, apellidos, telefono 
		From (Clientes As C) Right Outer Join (Estados As E)
        Using (estado)
			Order By nombre_estado;
            
            