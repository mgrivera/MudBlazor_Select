/*    
	  Martes, 24 de Diciembre de 2.024  -   v0.00.036.sql 
	  
	  Siniestros: agregamos la tabla de coberturas. 
	  También la de Documentos. 
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
ALTER TABLE dbo.Monedas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Companias SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Siniestros SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Documentos
	(
	Id int NOT NULL IDENTITY (1, 1),
	Origen nvarchar(10) NOT NULL,
	EntidadId int NOT NULL,
	CompaniaId nvarchar(10) NOT NULL,
	Fecha date NOT NULL,
	Tipo nvarchar(10) NOT NULL,
	Numero nvarchar(25) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Documentos ADD CONSTRAINT
	PK_Documentos PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Documentos ADD CONSTRAINT
	FK_Documentos_Siniestros FOREIGN KEY
	(
	EntidadId
	) REFERENCES dbo.Siniestros
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.Documentos ADD CONSTRAINT
	FK_Documentos_Companias FOREIGN KEY
	(
	CompaniaId
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Documentos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.SiniestrosCoberturas
	(
	Id int NOT NULL IDENTITY (1, 1),
	SiniestroId int NOT NULL,
	CoberturaId nvarchar(10) NOT NULL,
	MonedaId nvarchar(10) NOT NULL,
	Monto money NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.SiniestrosCoberturas ADD CONSTRAINT
	PK_SiniestrosCoberturas PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.SiniestrosCoberturas ADD CONSTRAINT
	FK_SiniestrosCoberturas_Coberturas FOREIGN KEY
	(
	CoberturaId
	) REFERENCES dbo.Coberturas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.SiniestrosCoberturas ADD CONSTRAINT
	FK_SiniestrosCoberturas_Monedas FOREIGN KEY
	(
	MonedaId
	) REFERENCES dbo.Monedas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.SiniestrosCoberturas ADD CONSTRAINT
	FK_SiniestrosCoberturas_Siniestros FOREIGN KEY
	(
	SiniestroId
	) REFERENCES dbo.Siniestros
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.SiniestrosCoberturas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.036', GetDate()) 

