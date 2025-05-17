/*    
	  Jueves, 5 de Diciembre de 2.024  -   v0.00.030.sql 
	  
	  Riesgos: renombramos la columna Numero a Referencia
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
EXECUTE sp_rename N'dbo.Riesgos.Numero', N'Tmp_Referencia', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.Riesgos.Tmp_Referencia', N'Referencia', 'COLUMN' 
GO
ALTER TABLE dbo.Riesgos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.030', GetDate()) 

