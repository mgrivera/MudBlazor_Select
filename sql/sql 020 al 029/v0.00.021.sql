/*    
	  Viernes, 19 de Julio de 2.024  -   v0.00.021.sql 
	  
	  Agregamos la columna SumaAseguradaUnidad a la tabla RiesgosCoberturas 
	  Agregamos las columnas: Engine, EngineType and Operation a la tabla Aeronaves 
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
ALTER TABLE dbo.RiesgosCoberturas
	DROP CONSTRAINT FK_RiesgosCoberturas_Riesgos
GO
ALTER TABLE dbo.Riesgos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RiesgosCoberturas
	DROP CONSTRAINT FK_RiesgosCoberturas_Monedas
GO
ALTER TABLE dbo.Monedas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RiesgosCoberturas
	DROP CONSTRAINT FK_RiesgosCoberturas_Coberturas
GO
ALTER TABLE dbo.Coberturas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_RiesgosCoberturas
	(
	Id int NOT NULL IDENTITY (1, 1),
	RiesgoId int NOT NULL,
	CoberturaId nvarchar(10) NOT NULL,
	MonedaId nvarchar(10) NOT NULL,
	Cantidad smallint NULL,
	SumaAseguradaUnidad money NULL,
	SumaAsegurada money NOT NULL,
	Limite money NULL,
	Tasa decimal(10, 6) NULL,
	Prima money NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_RiesgosCoberturas SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_RiesgosCoberturas ON
GO
IF EXISTS(SELECT * FROM dbo.RiesgosCoberturas)
	 EXEC('INSERT INTO dbo.Tmp_RiesgosCoberturas (Id, RiesgoId, CoberturaId, MonedaId, Cantidad, SumaAsegurada, Limite, Tasa, Prima)
		SELECT Id, RiesgoId, CoberturaId, MonedaId, Cantidad, SumaAsegurada, Limite, Tasa, Prima FROM dbo.RiesgosCoberturas WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_RiesgosCoberturas OFF
GO
DROP TABLE dbo.RiesgosCoberturas
GO
EXECUTE sp_rename N'dbo.Tmp_RiesgosCoberturas', N'RiesgosCoberturas', 'OBJECT' 
GO
ALTER TABLE dbo.RiesgosCoberturas ADD CONSTRAINT
	PK_RiesgosCoberturas PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.RiesgosCoberturas ADD CONSTRAINT
	FK_RiesgosCoberturas_Coberturas FOREIGN KEY
	(
	CoberturaId
	) REFERENCES dbo.Coberturas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.RiesgosCoberturas ADD CONSTRAINT
	FK_RiesgosCoberturas_Monedas FOREIGN KEY
	(
	MonedaId
	) REFERENCES dbo.Monedas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.RiesgosCoberturas ADD CONSTRAINT
	FK_RiesgosCoberturas_Riesgos FOREIGN KEY
	(
	RiesgoId
	) REFERENCES dbo.Riesgos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
COMMIT


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
ALTER TABLE dbo.RiesgosDatosAeronave ADD
	Engine nvarchar(16) NULL,
	EngineType nvarchar(16) NULL,
	Operation nvarchar(16) NULL
GO
ALTER TABLE dbo.RiesgosDatosAeronave SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.021', GetDate()) 

