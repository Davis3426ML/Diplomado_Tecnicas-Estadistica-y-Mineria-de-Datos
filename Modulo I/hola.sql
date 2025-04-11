/** Para esta ocasion veremos nuestro primeros caso de programacion en SQL de las cuales las conoceremos como "Triggers" **/
			Use Base_Inventario;
            
# ========================================= Trigger ============================================== #
            
				/** ----------------- Inciso a) ----------------- **/
	Desc Ordenes;		# Vemos todas la columnas de nuestra tabla ordenes #
    
    Select * From Ordenes		# Especialmente en un registro #
		Where NUM_Orden = 1002;
    
                /** ----------------- Inciso b) ----------------- **/
	Alter Table Ordenes			# Insertamos una nueva columnas en Ordenes #
		Add Column Total Decimal(12,2);
       
	Alter Table Ordenes			# Eliminar la columna anterior #
		Drop Column Total;

				/** ----------------- Inciso c) ----------------- **/
	Select Sum(precio_total) As 'Pago del sujeto 1002' From Articulos 
		Where NUM_orden = 1002;			# vemos la cantidad que suma los articulos comprados por el #
    
                /** ----------------- Inciso d) ----------------- **/
	Delimiter //  
		Create Trigger Ordenes_Actual_Total After Insert on Articulos For Each Row
				Begin
					Update Ordenes Set Total = ( Select Sum(precio_total) From Articulos 
													Where NUM_orden = New.NUM_orden );
                End;
			  //
    
    Delimiter ;		# restablecemos el delimitador clasico #
    
    Drop Trigger Ordenes_Actual_Total;			# De esta forma podemos eliminar el trigger #
    
				/** ----------------- Inciso e) ----------------- **/
    Select * From Articulos		# Observamos la cantidad que se sumara antes de #
		Where NUM_Orden = 1002;					# la ingresar el nuesvo registro en Articulos #
    
                /** ----------------- Inciso f) ----------------- **/
	Insert Into Articulos 
		Values (3, 1002, 4, 'HSK', 2, 1920);

				/** ----------------- Inciso g) ----------------- **/
    Select * From Ordenes		# Checamos si hay algun cambio  #
		Where NUM_Orden = 1002;