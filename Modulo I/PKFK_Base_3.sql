/** ALgo que nos falta en nuestro database es el determinar las PK y FK, pero es de preferencia hacer al ultimo; ya que 
	se puede provocar errores al cargar los datos, con un establecimiento previo nuestro digrama ER en nuestro database 
    y mas un si tenemos un masivo carga de registro (asi tenemos un analisis mas preciso de la situacion de nuestro database)**/

/** Antes de empezar hay verificar "el total de registros" en cada uno de nuestro tablas **/
	Use Base_Inventario;
		Select count(*) From Articulos;      # DEBERÁ DEVOLVER 68 registros (1) #
		Select count(*) From Clientes;		 # DEBERÁ DEVOLVER 28 registros (1) #
		Select count(*) From Estados;        # DEBERÁ DEVOLVER 52 registros (1) #
		Select count(*) From Inventarios;    # DEBERÁ DEVOLVER 74 registros (1) #
		Select count(*) From Ordenes;        # DEBERÁ DEVOLVER 23 registros (1) #
		Select count(*) From Proveedores;    # DEBERÁ DEVOLVER 9 registros (1) #
        
/** ----------------------------------------- Primary Key ----------------------------------------------- **/
	/** Antes de crear las FK, empezamos las PK (Por definicion de las llaves) **/
    
    # Articulos #
/** En el caso de la relacion: "articulos" e "ordenes"; se puede notar que hay registros de mas que no conecta bien con "ordenes" como tabla padre **/
	Select * From Articulos
		Where NUM_orden Not In (Select NUM_orden From Ordenes);

/** ya que a la hora de establecer al PK, ambas tablas entraran en conflicto y por esta ocasion, hay que eliminarlo **/
	Delete From Articulos 
		Where NUM_orden Not In (Select NUM_orden From Ordenes);

/** Pasamos establecer nuestro PK de articulos **/
	Alter Table Articulos		# Alteramos nuestra tabla "Articulos" #
		Add Constraint Pk_Articulos		# Anadimos la restriccion llamada "Pk_Articulos" #
        Primary Key (NUM_articulo, NUM_orden);		# Indicamos las llave primaria de nuestra tabla por los campos #


    # Clientes #
	Alter Table Clientes
		Add Constraint Pk_Clientes
        Primary Key (NUM_cliente);
        

    # Estados #
	Alter Table Estados
		Add Constraint Pk_Estados
        Primary Key (Estado);
        
        
    # Inventario #
	Alter Table Inventarios
		Add Constraint Pk_Inventarios
        Primary Key (NUM_inventario, Codigo_proveedor);
        

    # Ordenes #
	Alter Table Ordenes
		Add Constraint Pk_Ordenes
        Primary Key (NUM_orden);
    
    
    # Proveedores #
	Alter Table Proveedores
		Add Constraint Pk_Proveedores
        Primary Key (Codigo_proveedor);


/** ----------------------------------------- Foreing Key ----------------------------------------------- **/
	/** Pasamos a crear nuestras FK que son diferentes que las PK al codificar **/
    
    # Articulos #
    Alter Table Articulos				# Alteramos nuestra tabla "Articulos" #
		Add Constraint Fk_Items1	# Anadimos la restriccion llamada "Fk_Items1" #
		Foreign Key (NUM_orden)		# Indicamos las llave Foranea de nuestra tabla por el campo #
			References Ordenes (NUM_orden);		# Indicamos de donde proviene la FK #
        
	Alter Table Articulos
		Add Constraint Fk_Items2
        Foreign Key (NUM_inventario, Codigo_proveedor)
			References Inventarios (NUM_inventario, Codigo_proveedor);


    # Clientes #
	Alter Table Clientes
		Add Constraint Fk_Clientes
        Foreign Key (Estado)
			References Estados(Estado);
        
        
    # Inventario #
	Alter Table Inventarios
		Add Constraint Fk_Inventarios
        Foreign Key (Codigo_proveedor)
			References Proveedores (Codigo_proveedor);
        

    # Ordenes #
	Alter Table Ordenes
		Add Constraint Fk_Ordenes
        Foreign Key (NUM_cliente)
			References Clientes (NUM_cliente);
            
   
/** ----------------------------------------- Lista PK y FK ----------------------------------------------- **/
	/** Con este comando podemos hacer una lista nuestras PK y FK de nuestro database **/

Select Table_Name As 'Nombre_Tablas', Constraint_Name As 'Nombre_Restriccion', Constraint_Type as 'Tipo_Restriccion'
	From INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		Where Table_Name IN ('Ordenes', 'Clientes','Proveedores', 'Inventarios', 'Articulos', 'Estados')
			Order By Table_Name;