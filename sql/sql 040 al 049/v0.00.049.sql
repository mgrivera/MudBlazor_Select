/*    
	  Martes, 29 de Abril de 2.025 - v0.00.049.sql 
	  
	  Hacemos los siguientes cambios: 
	  Riesgos: agregamos la columna Observaciones 
	  RiesgosDatosAviacion: agregamos las columnas: Serial y AeropuertoId 
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
ALTER TABLE dbo.Riesgos ADD
	Observaciones nvarchar(MAX) NULL
GO
ALTER TABLE dbo.Riesgos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Aeropuertos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RiesgosDatosAeronave ADD
	Serial nvarchar(20) NULL,
	AeropuertoId int NULL
GO
ALTER TABLE dbo.RiesgosDatosAeronave ADD CONSTRAINT
	FK_RiesgosDatosAeronave_Aeropuertos FOREIGN KEY
	(
	AeropuertoId
	) REFERENCES dbo.Aeropuertos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.RiesgosDatosAeronave SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.049', GetDate()) 

