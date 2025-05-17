/*    
	  Viernes, 09 de Mayo de 2.025 - v0.00.051.sql 
	  
	  Agregamos las tablas que corresponden al registro de planes de cobertura: 
	  PlanesCobertura y PlanesCobertura_Coberturas 
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
ALTER TABLE dbo.Coberturas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Ramos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Monedas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.PlanesCobertura_Coberturas
	(
	Id int NOT NULL IDENTITY (1, 1),
	PlanId int NOT NULL,
	MonedaId nvarchar(10) NULL,
	CoberturaId nvarchar(10) NOT NULL,
	SumaAsegurada money NULL,
	Tasa decimal(10, 6) NULL,
	Prima money NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.PlanesCobertura_Coberturas ADD CONSTRAINT
	PK_PlanesCobertura_Coberturas PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.PlanesCobertura_Coberturas ADD CONSTRAINT
	FK_PlanesCobertura_Coberturas_Monedas FOREIGN KEY
	(
	MonedaId
	) REFERENCES dbo.Monedas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PlanesCobertura_Coberturas ADD CONSTRAINT
	FK_PlanesCobertura_Coberturas_Coberturas FOREIGN KEY
	(
	CoberturaId
	) REFERENCES dbo.Coberturas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PlanesCobertura_Coberturas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.PlanesCobertura
	(
	Id int NOT NULL IDENTITY (1, 1),
	Nombre nvarchar(50) NOT NULL,
	MonedaId nvarchar(10) NOT NULL,
	RamoId nvarchar(10) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.PlanesCobertura ADD CONSTRAINT
	PK_PlanesCobertura PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.PlanesCobertura ADD CONSTRAINT
	FK_PlanesCobertura_Ramos FOREIGN KEY
	(
	RamoId
	) REFERENCES dbo.Ramos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PlanesCobertura ADD CONSTRAINT
	FK_PlanesCobertura_Monedas FOREIGN KEY
	(
	MonedaId
	) REFERENCES dbo.Monedas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PlanesCobertura SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
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
ALTER TABLE dbo.PlanesCobertura SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.PlanesCobertura_Coberturas ADD CONSTRAINT
	FK_PlanesCobertura_Coberturas_PlanesCobertura FOREIGN KEY
	(
	PlanId
	) REFERENCES dbo.PlanesCobertura
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.PlanesCobertura_Coberturas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.051', GetDate()) 

