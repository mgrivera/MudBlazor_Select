/*    
	  Miércoles, 3 de Julio de 2.024  -   v0.00.018.sql 
	  
	  Agregamos la columna PrefijoNumeroRiesgo a la tabla Ramos 
*/

BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Ramos ADD
	PrefijoNumeroRiesgo nvarchar(5) NULL
GO
ALTER TABLE dbo.Ramos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.018', GetDate()) 

