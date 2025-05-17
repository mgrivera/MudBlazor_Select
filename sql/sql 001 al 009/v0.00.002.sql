/*    
	  Viernes, 26 de Abril de 2.024  -   v0.00.002.sql 
	  
	  Agregamos tres columnas a la tabla Empresas: Email y Telefonos (1 y 2) 
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
ALTER TABLE dbo.Empresa ADD
	Email nvarchar(50) NULL,
	Telefono1 nvarchar(25) NULL,
	Telefono2 nvarchar(25) NULL
GO
ALTER TABLE dbo.Empresa SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.002', GetDate()) 