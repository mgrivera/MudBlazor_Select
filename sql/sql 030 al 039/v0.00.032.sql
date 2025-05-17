/*    
	  Jueves, 5 de Diciembre de 2.024  -   v0.00.032.sql 
	  
	  Riesgos: Inicializamos la nueva columna Numero con el valor del Id 
	  Además, ponemosj la columna como Not Null 
*/


Update Riesgos Set Numero = Id 
Alter Table Riesgos Alter Column Numero int Not Null 


Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.032', GetDate()) 

