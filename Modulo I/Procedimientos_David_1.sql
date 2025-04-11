/** Los procedimientos e funciones almacenados son contrucciones de comandos con el objetivo de ser eficientes o poco 
			laboriosos al extraer, actualizar, utilizar y examinar la informacion (o crearla) en nuestro database. **/
            
/** Vamos a ver algunos ejemplos pero con otros. **/

				/** ----------------- Ejercicio #1 ----------------- **/
	Drop Database If Exists David_Tareas;			# Eliminamos una base de datos con un nombre en especifico #
    
    Create Database If Not Exists David_Tareas;		# creamos nueva base de datos con un nombre en especifico #
    
    Use David_Tareas;		# Usamos la nueva base de datos #
    
    
    Drop Table If Exists Mobiliarios;			# Eliminamos una Tabla con un nombre en especifico #
    
    Create Table If Not Exists Mobiliarios		# creamos una Tabla con un nombre en especifico #
		(ID_Articulo int, descripcion char(50), existencia int);
        
                /** ----------------- Ejercicio #2 ----------------- **/
	Drop Procedure If Exists Inserta_Mobiliario;			
    
    Delimiter //
		Create Procedure Inserta_Mobiliario ( P_id int, P_descripcion char(50), P_existencia int )
			Begin
				Insert Into Mobiliarios Values (P_id, P_descripcion, P_existencia);
            End;
			  //
	Delimiter ;
    
    
    Call Inserta_Mobiliario (1, 'descripcion1', 10);		# Utilizamos nuestro procedimiento almacenado #
    
    Select * From Mobiliarios;		# Vemos si aplico nuestro registro anterior #
	
	Delete From Mobiliarios
		Where ID_Articulos = 1;
        
                /** ----------------- Ejercicio #3 ----------------- **/
	Drop Procedure If Exists Actualiza_Mobiliario;
    
    Delimiter // 
		Create Procedure Actualiza_Mobiliario ( P_id int, P_descripcion char(50), P_existencia int )
			Begin
				Update Mobiliarios Set descripcion = P_descripcion, existencia = P_existencia
					Where ID_Articulo = P_id;
            End;
			  //
	Delimiter ;
    

    Call Actualiza_Mobiliario (1, 'producto medico', 7);
    
    Select * From Mobiliarios;
    
    Call Inserta_Mobiliario (1, 'descripcion1', 10);
    
                /** ----------------- Ejercicio #4 ----------------- **/
	Drop Procedure If Exists Selecciona_Mobiliario;
    
    Delimiter //
		Create Procedure Selecciona_Mobiliario ( P_id int )
			Begin
				Select * From Mobiliarios
					Where ID_Articulo = P_id;
            End;
			  //
	Delimiter ;
	
    
    Call Selecciona_Mobiliario (1);
                
                /** ----------------- Ejercicio #5 ----------------- **/
	Drop Procedure If Exists Borrar_Mobiliario;
    
    Delimiter //
		Create Procedure Borrar_Mobiliario ( P_id int )
			Begin
				Delete From Mobiliarios
					Where ID_Articulo = P_id;
            End;
			  //
	Delimiter ;
	
    
    Call Borrar_Mobiliario (1);
    
    Select * From Mobiliarios;
