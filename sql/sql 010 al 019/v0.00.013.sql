/*    
	  Domingo, 23 de Junio de 2.024  -   v0.00.0013.sql 
	  
	  Agregamos la columna CompaniaNosotros a la tabla Empresa 
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
ALTER TABLE dbo.Companias SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_Empresa
	(
	Id nvarchar(10) NOT NULL,
	Nombre nvarchar(70) NOT NULL,
	Abreviatura nvarchar(15) NOT NULL,
	CompaniaNosotros nvarchar(10) NULL,
	Direccion1 nvarchar(50) NULL,
	Direccion2 nvarchar(50) NULL,
	Direccion3 nvarchar(50) NULL,
	Direccion4 nvarchar(50) NULL,
	Direccion5 nvarchar(50) NULL,
	Email nvarchar(50) NULL,
	Telefono1 nvarchar(25) NULL,
	Telefono2 nvarchar(25) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Empresa SET (LOCK_ESCALATION = TABLE)
GO
IF EXISTS(SELECT * FROM dbo.Empresa)
	 EXEC('INSERT INTO dbo.Tmp_Empresa (Id, Nombre, Abreviatura, Direccion1, Direccion2, Direccion3, Direccion4, Direccion5, Email, Telefono1, Telefono2)
		SELECT Id, Nombre, Abreviatura, Direccion1, Direccion2, Direccion3, Direccion4, Direccion5, Email, Telefono1, Telefono2 FROM dbo.Empresa WITH (HOLDLOCK TABLOCKX)')
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Empresa
GO
ALTER TABLE dbo.Cuotas
	DROP CONSTRAINT FK_Cuotas_Empresa
GO
ALTER TABLE dbo.CiaSeleccionada
	DROP CONSTRAINT FK_CiaSeleccionada_Empresa
GO
DROP TABLE dbo.Empresa
GO
EXECUTE sp_rename N'dbo.Tmp_Empresa', N'Empresa', 'OBJECT' 
GO
ALTER TABLE dbo.Empresa ADD CONSTRAINT
	PK_Empresa PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Empresa ADD CONSTRAINT
	FK_Empresa_Companias FOREIGN KEY
	(
	CompaniaNosotros
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.CiaSeleccionada ADD CONSTRAINT
	FK_CiaSeleccionada_Empresa FOREIGN KEY
	(
	CiaSeleccionada
	) REFERENCES dbo.Empresa
	(
	Id
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.CiaSeleccionada SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Cuotas ADD CONSTRAINT
	FK_Cuotas_Empresa FOREIGN KEY
	(
	Cia
	) REFERENCES dbo.Empresa
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Cuotas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Empresa FOREIGN KEY
	(
	Cia
	) REFERENCES dbo.Empresa
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Riesgos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.013', GetDate()) 
