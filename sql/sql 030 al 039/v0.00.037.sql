/*    
	  Sabado, 11 de Enero de 2.025  -   v0.00.037.sql 
	  
	  Siniestros: agregamos la columna CoberturaId a la tabla 
	  SiniestrosCoberturas 
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
ALTER TABLE dbo.SiniestrosMovimientos
	DROP CONSTRAINT FK_SiniestrosMovimientos_Siniestros
GO
ALTER TABLE dbo.Siniestros SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.SiniestrosMovimientos
	DROP CONSTRAINT FK_SiniestrosMovimientos_Monedas
GO
ALTER TABLE dbo.Monedas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Coberturas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_SiniestrosMovimientos
	(
	Id int NOT NULL IDENTITY (1, 1),
	SiniestroId int NOT NULL,
	Fecha date NOT NULL,
	MonedaId nvarchar(10) NOT NULL,
	CoberturaId nvarchar(10) NULL,
	Tipo nvarchar(10) NOT NULL,
	Monto money NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_SiniestrosMovimientos SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_SiniestrosMovimientos ON
GO
IF EXISTS(SELECT * FROM dbo.SiniestrosMovimientos)
	 EXEC('INSERT INTO dbo.Tmp_SiniestrosMovimientos (Id, SiniestroId, Fecha, MonedaId, Tipo, Monto)
		SELECT Id, SiniestroId, Fecha, MonedaId, Tipo, Monto FROM dbo.SiniestrosMovimientos WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_SiniestrosMovimientos OFF
GO
DROP TABLE dbo.SiniestrosMovimientos
GO
EXECUTE sp_rename N'dbo.Tmp_SiniestrosMovimientos', N'SiniestrosMovimientos', 'OBJECT' 
GO
ALTER TABLE dbo.SiniestrosMovimientos ADD CONSTRAINT
	PK_SiniestrosMovimientos PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.SiniestrosMovimientos ADD CONSTRAINT
	FK_SiniestrosMovimientos_Monedas FOREIGN KEY
	(
	MonedaId
	) REFERENCES dbo.Monedas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.SiniestrosMovimientos ADD CONSTRAINT
	FK_SiniestrosMovimientos_Siniestros FOREIGN KEY
	(
	SiniestroId
	) REFERENCES dbo.Siniestros
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.SiniestrosMovimientos ADD CONSTRAINT
	FK_SiniestrosMovimientos_Coberturas FOREIGN KEY
	(
	CoberturaId
	) REFERENCES dbo.Coberturas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT


Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.037', GetDate()) 

