/** Este es una prueba de mis conocimiento adquiridos en el modulo "Diseno de base de datos" **/

				/** ----------------- Mi DataBase y Su Uso ----------------- **/
	Drop Database If Exists MendietaDavid_Final;
    
    Create Database If Not Exists MendietaDavid_Final;
    
    Use MendietaDavid_Final;
                 
                /** ----------------- Mi Entidad y su Respaldo  ----------------- **/
	Drop Table If Exists Hospital;
    Drop Table If Exists Hospital_Backup;
    
    Create Table Hospital(
		Id Int, especialidad Varchar(20), calle_num Int(4),  delegación Char(15), 
		CP Char(5), telefono1 Char(18), telefono2 Char(18), pagina_web Char (50), 
        especialidades Varchar(40), antigüedad Int(3), convenio_asegurado Int(7), 
        total_cuartos Smallint, total_suits Smallint 
	);
    
	Alter Table Hospital
		Add Constraint PK_1
        Primary Key (Id);
	
    Create Table If Not Exists Hospital_Backup Like Hospital;
        
                /** ----------------- Mis Procedimientos Almacenados  ----------------- **/
	Drop Procedure If Exists InsertarHospital;
    Drop Procedure If Exists ActualizarHospital;
    Drop Procedure If Exists BorrarHospital;
        
    Delimiter //
    
		Create Procedure InsertarHospital ( P_Id Int, P_especialidad Varchar(20), P_calle_num Int(4), P_delegación Char(15), 
										   P_CP Char(5), P_telefono1 Char(18), P_telefono2 Char(18), P_pagina_web Char(50), 
										   P_especialidades Varchar(40), P_antigüedad Int(3), P_convenio_asegurado Int(7), 
										   P_total_cuartos Smallint, P_total_suits Smallint )
			Begin
				Insert Into Hospital_Backup Values (P_Id, P_especialidad, P_calle_num, P_delegación, P_CP, P_telefono1,
													 P_telefono2, P_pagina_web, P_especialidades, P_antigüedad, 
                                                     P_convenio_asegurado, P_total_cuartos, P_total_suits);
            End;
    
			  //
	Delimiter ;
              
	Delimiter //
    
		Create Procedure ActualizarHospital ( P_Id Int, P_especialidad Varchar(20), P_calle_num Int(4), P_delegación Char(15), 
										   P_CP Char(5), P_telefono1 Char(18), P_telefono2 Char(18), P_pagina_web Char(50), 
										   P_especialidades Varchar(40), P_antigüedad Int(3), P_convenio_asegurado Int(7), 
										   P_total_cuartos Smallint, P_total_suits Smallint )
			Begin
				Update Hospital_Backup Set 
					especialidad = P_especialidad, calle_num = P_calle_num, delegación = P_delegación, CP = P_CP, 
                    telefono1 = P_telefono1, telefono2 = P_telefono2, pagina_web = P_pagina_web, especialidades = P_especialidades,
					antigüedad = P_antigüedad, convenio_asegurado = P_convenio_asegurado, total_cuartos = P_total_cuartos,
					total_suits = P_total_suits
						Where Id = P_Id;
            End;
    
			  //
	Delimiter ;
              
	Delimiter //
    
		Create Procedure BorrarHospital (P_Id Int)
			Begin
				Delete From Hospital_Backup
					Where Id = P_Id;
            End;

			  //
	Delimiter ; 



                /** ----------------- Mis triggers  ----------------- **/
	Drop Trigger If Exists Inserta_BI_Hospital;
    Drop Trigger If Exists Actualiza_BU_Hospital;
    Drop Trigger If Exists Borra_BD_Hospital;
	
/** ------------------------------------------------------ Parte 1 ------------------------------------------------**/
    Delimiter //
    
    Create Trigger Inserta_BI_Hospital Before Insert On Hospital For Each Row 
		Begin
			Call InsertarHospital (New.Id, New.especialidad, New.calle_num, New.delegación, New.CP, New.telefono1,
									New.telefono2, New.pagina_web, New.especialidades, New.antigüedad, 
									New.convenio_asegurado, New.total_cuartos, New.total_suits);
		End;
    
			  //
	Delimiter ;
    
    Insert Into Hospital (Id, especialidad, calle_num,  delegación, CP, telefono1, telefono2, pagina_web, 
						  especialidades, antigüedad, convenio_asegurado, total_cuartos, total_suits)
		Value (3, 'Psiquiatria', 344, 'Naucalpan', '53760', '5545814944', '5545814944', 'www.hospital.com.mx', 'Exp, Acn', 27, 3172311, 34, 12);
	Select * From Hospital;
    Select * From Hospital_Backup;

/** ------------------------------------------------------ Parte 2 ------------------------------------------------**/
	Delimiter //
    
    Create Trigger Actualiza_BU_Hospital Before Update On Hospital For Each Row 
		Begin
			Call ActualizarHospital (New.Id, New.especialidad, New.calle_num, New.delegación, New.CP, New.telefono1,
									New.telefono2, New.pagina_web, New.especialidades, New.antigüedad, 
									New.convenio_asegurado, New.total_cuartos, New.total_suits);
		End;
    
			  //
	Delimiter ;
    
    
    Update Hospital set telefono2 = '5642676427', antigüedad = 14, convenio_asegurado = 3251289
		Where Id = 3;
    Select * From Hospital;
    Select * From Hospital_Backup;
    
/** ------------------------------------------------------ Parte 3 ------------------------------------------------**/
	Delimiter //
    
    Create Trigger Borra_BD_Hospital After Delete On Hospital For Each Row 
		Begin
			Call BorrarHospital(old.Id);
		End;
    
			  //
	Delimiter ;
    
    Delete From Hospital
		Where Id = 3;
	Select * From Hospital;
    Select * From Hospital_Backup;