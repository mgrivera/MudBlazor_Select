/*    
	  Jueves, 21 de Noviembre de 2.024  -   v0.00.029.sql 
	  
	  Agregamos la nueva tabla RiesgosProrrata
	  También agregamos la columna TipoEndoso a la tabla Riesgos 
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
ALTER TABLE dbo.Riesgos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.RiesgosProrrata
	(
	Id int NOT NULL IDENTITY (1, 1),
	RiesgoId int NOT NULL,
	CompaniaId nvarchar(10) NOT NULL,
	Nosotros bit NOT NULL,
	MonedaId nvarchar(10) NOT NULL,
	PrimaAnterior money NOT NULL,
	OrdenPorcAnterior decimal(5, 2) NOT NULL,
	PrimaBrutaAnterior money NOT NULL,
	Prima money NOT NULL,
	OrdenPorc decimal(5, 2) NOT NULL,
	PrimaBruta money NOT NULL,
	DiasRiesgo smallint NOT NULL,
	DiasOrden smallint NOT NULL,
	PrimaProrrata money NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.RiesgosProrrata ADD CONSTRAINT
	PK_RiesgosProrrata PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.RiesgosProrrata ADD CONSTRAINT
	FK_RiesgosProrrata_Riesgos FOREIGN KEY
	(
	RiesgoId
	) REFERENCES dbo.Riesgos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.RiesgosProrrata ADD CONSTRAINT
	FK_RiesgosProrrata_Companias FOREIGN KEY
	(
	CompaniaId
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.RiesgosProrrata ADD CONSTRAINT
	FK_RiesgosProrrata_Monedas FOREIGN KEY
	(
	MonedaId
	) REFERENCES dbo.Monedas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.RiesgosProrrata SET (LOCK_ESCALATION = TABLE)
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
ALTER TABLE dbo.RiesgosProrrata
	DROP CONSTRAINT FK_RiesgosProrrata_Monedas
GO
ALTER TABLE dbo.Monedas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RiesgosProrrata
	DROP CONSTRAINT FK_RiesgosProrrata_Companias
GO
ALTER TABLE dbo.Companias SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RiesgosProrrata
	DROP CONSTRAINT FK_RiesgosProrrata_Riesgos
GO
ALTER TABLE dbo.Riesgos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_RiesgosProrrata
	(
	Id int NOT NULL IDENTITY (1, 1),
	RiesgoId int NOT NULL,
	CompaniaId nvarchar(10) NOT NULL,
	Nosotros bit NOT NULL,
	MonedaId nvarchar(10) NOT NULL,
	PrimaAnterior money NOT NULL,
	OrdenPorcAnterior decimal(5, 2) NOT NULL,
	PrimaBrutaAnterior money NOT NULL,
	Prima money NOT NULL,
	OrdenPorc decimal(5, 2) NOT NULL,
	PrimaBruta money NOT NULL,
	PrimaBrutaDiff money NOT NULL,
	DiasRiesgo smallint NOT NULL,
	DiasOrden smallint NOT NULL,
	PrimaProrrata money NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_RiesgosProrrata SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_RiesgosProrrata ON
GO
IF EXISTS(SELECT * FROM dbo.RiesgosProrrata)
	 EXEC('INSERT INTO dbo.Tmp_RiesgosProrrata (Id, RiesgoId, CompaniaId, Nosotros, MonedaId, PrimaAnterior, OrdenPorcAnterior, PrimaBrutaAnterior, Prima, OrdenPorc, PrimaBruta, DiasRiesgo, DiasOrden, PrimaProrrata)
		SELECT Id, RiesgoId, CompaniaId, Nosotros, MonedaId, PrimaAnterior, OrdenPorcAnterior, PrimaBrutaAnterior, Prima, OrdenPorc, PrimaBruta, DiasRiesgo, DiasOrden, PrimaProrrata FROM dbo.RiesgosProrrata WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_RiesgosProrrata OFF
GO
DROP TABLE dbo.RiesgosProrrata
GO
EXECUTE sp_rename N'dbo.Tmp_RiesgosProrrata', N'RiesgosProrrata', 'OBJECT' 
GO
ALTER TABLE dbo.RiesgosProrrata ADD CONSTRAINT
	PK_RiesgosProrrata PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.RiesgosProrrata ADD CONSTRAINT
	FK_RiesgosProrrata_Riesgos FOREIGN KEY
	(
	RiesgoId
	) REFERENCES dbo.Riesgos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.RiesgosProrrata ADD CONSTRAINT
	FK_RiesgosProrrata_Companias FOREIGN KEY
	(
	CompaniaId
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.RiesgosProrrata ADD CONSTRAINT
	FK_RiesgosProrrata_Monedas FOREIGN KEY
	(
	MonedaId
	) REFERENCES dbo.Monedas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
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
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Paises
GO
ALTER TABLE dbo.Paises SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Asegurados
GO
ALTER TABLE dbo.Asegurados SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Ramos
GO
ALTER TABLE dbo.Ramos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Monedas
GO
ALTER TABLE dbo.Monedas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Companias
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Companias1
GO
ALTER TABLE dbo.Companias SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Tipos
GO
ALTER TABLE dbo.Tipos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Empresa
GO
ALTER TABLE dbo.Empresa SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_Riesgos
	(
	Id int NOT NULL IDENTITY (1, 1),
	Numero nvarchar(16) NOT NULL,
	Endoso smallint NOT NULL,
	TipoEndoso nvarchar(6) NULL,
	FechaEmision datetime NULL,
	Desde_original datetime NOT NULL,
	Hasta_original datetime NOT NULL,
	Dias_original smallint NOT NULL,
	Desde_aceptacion datetime NULL,
	Hasta_aceptacion datetime NULL,
	Dias_aceptacion smallint NULL,
	Estado nvarchar(10) NOT NULL,
	Moneda nvarchar(10) NOT NULL,
	Cedente nvarchar(10) NOT NULL,
	Corredor nvarchar(10) NULL,
	Ramo nvarchar(10) NOT NULL,
	Tipo nvarchar(10) NOT NULL,
	Asegurado nvarchar(10) NOT NULL,
	Pais nvarchar(6) NOT NULL,
	Cia nvarchar(10) NOT NULL,
	UploadDate datetime NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Riesgos SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_Riesgos ON
GO
IF EXISTS(SELECT * FROM dbo.Riesgos)
	 EXEC('INSERT INTO dbo.Tmp_Riesgos (Id, Numero, Endoso, FechaEmision, Desde_original, Hasta_original, Dias_original, Desde_aceptacion, Hasta_aceptacion, Dias_aceptacion, Estado, Moneda, Cedente, Corredor, Ramo, Tipo, Asegurado, Pais, Cia, UploadDate)
		SELECT Id, Numero, Endoso, FechaEmision, Desde_original, Hasta_original, Dias_original, Desde_aceptacion, Hasta_aceptacion, Dias_aceptacion, Estado, Moneda, Cedente, Corredor, Ramo, Tipo, Asegurado, Pais, Cia, UploadDate FROM dbo.Riesgos WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_Riesgos OFF
GO
ALTER TABLE dbo.RiesgosProrrata
	DROP CONSTRAINT FK_RiesgosProrrata_Riesgos
GO
ALTER TABLE dbo.RiesgosCoberturas
	DROP CONSTRAINT FK_RiesgosCoberturas_Riesgos
GO
ALTER TABLE dbo.RiesgosCompanias
	DROP CONSTRAINT FK_RiesgosCompanias_Riesgos
GO
ALTER TABLE dbo.Cuotas
	DROP CONSTRAINT FK_Cuotas_Riesgos
GO
ALTER TABLE dbo.RiesgosDatosAeronave
	DROP CONSTRAINT FK_RiesgosDatosAeronave_Riesgos
GO
DROP TABLE dbo.Riesgos
GO
EXECUTE sp_rename N'dbo.Tmp_Riesgos', N'Riesgos', 'OBJECT' 
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	PK_Riesgos PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
CREATE UNIQUE NONCLUSTERED INDEX IX_Riesgos ON dbo.Riesgos
	(
	Numero,
	Endoso
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Tipos FOREIGN KEY
	(
	Tipo
	) REFERENCES dbo.Tipos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Companias FOREIGN KEY
	(
	Cedente
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Companias1 FOREIGN KEY
	(
	Corredor
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Monedas FOREIGN KEY
	(
	Moneda
	) REFERENCES dbo.Monedas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Ramos FOREIGN KEY
	(
	Ramo
	) REFERENCES dbo.Ramos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Asegurados FOREIGN KEY
	(
	Asegurado
	) REFERENCES dbo.Asegurados
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Paises FOREIGN KEY
	(
	Pais
	) REFERENCES dbo.Paises
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RiesgosDatosAeronave ADD CONSTRAINT
	FK_RiesgosDatosAeronave_Riesgos FOREIGN KEY
	(
	RiesgoId
	) REFERENCES dbo.Riesgos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.RiesgosDatosAeronave SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Cuotas ADD CONSTRAINT
	FK_Cuotas_Riesgos FOREIGN KEY
	(
	Source_EntityId
	) REFERENCES dbo.Riesgos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.Cuotas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RiesgosCompanias ADD CONSTRAINT
	FK_RiesgosCompanias_Riesgos FOREIGN KEY
	(
	RiesgoId
	) REFERENCES dbo.Riesgos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.RiesgosCompanias SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
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
ALTER TABLE dbo.RiesgosCoberturas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RiesgosProrrata ADD CONSTRAINT
	FK_RiesgosProrrata_Riesgos FOREIGN KEY
	(
	RiesgoId
	) REFERENCES dbo.Riesgos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.RiesgosProrrata SET (LOCK_ESCALATION = TABLE)
GO
COMMIT





Update Riesgos Set TipoEndoso = 'ORIG' 
Alter Table Riesgos Alter Column TipoEndoso nvarchar(6) Not Null







Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.029', GetDate()) 

