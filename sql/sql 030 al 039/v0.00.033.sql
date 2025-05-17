/*    
	  Domingo, 15 de Diciembre de 2.024  -   v0.00.033.sql 
	  
	  Agregamos las nuevas tablas: Ciudades y Causas de Siniestro 
*/


/****** Object:  Table [dbo].[Ciudades]    Script Date: 12/15/2024 11:04:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Ciudades](
	[Id] [nvarchar](6) NOT NULL,
	[Nombre] [nvarchar](25) NOT NULL,
	[Abreviatura] [nvarchar](6) NOT NULL,
	[PaisId] [nvarchar](6) NOT NULL,
 CONSTRAINT [PK_Ciudades] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Ciudades]  WITH CHECK ADD  CONSTRAINT [FK_Ciudades_Paises] FOREIGN KEY([PaisId])
REFERENCES [dbo].[Paises] ([Id])
GO

ALTER TABLE [dbo].[Ciudades] CHECK CONSTRAINT [FK_Ciudades_Paises]
GO


/****** Object:  Table [dbo].[CausasSiniestro]    Script Date: 12/15/2024 11:04:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CausasSiniestro](
	[Id] [nvarchar](10) NOT NULL,
	[Descripcion] [nvarchar](30) NOT NULL,
	[Abreviatura] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_CausasSiniestro] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO























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
ALTER TABLE dbo.Riesgos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.CausasSiniestro SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Ciudades SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Siniestros
	(
	Id int NOT NULL IDENTITY (1, 1),
	RiesgoId int NOT NULL,
	FEmision date NOT NULL,
	FNotificacion date NOT NULL,
	FOcurrencia date NOT NULL,
	Status nvarchar(20) NOT NULL,
	Causa nvarchar(10) NOT NULL,
	CiudadPoliza nvarchar(6) NOT NULL,
	CiudadAsegurado nvarchar(6) NOT NULL,
	CiudadSiniestro nvarchar(6) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Siniestros ADD CONSTRAINT
	PK_Siniestros PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Siniestros ADD CONSTRAINT
	FK_Siniestros_Riesgos FOREIGN KEY
	(
	RiesgoId
	) REFERENCES dbo.Riesgos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Siniestros ADD CONSTRAINT
	FK_Siniestros_CausasSiniestro FOREIGN KEY
	(
	Causa
	) REFERENCES dbo.CausasSiniestro
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Siniestros ADD CONSTRAINT
	FK_Siniestros_Ciudades FOREIGN KEY
	(
	CiudadPoliza
	) REFERENCES dbo.Ciudades
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Siniestros ADD CONSTRAINT
	FK_Siniestros_Ciudades1 FOREIGN KEY
	(
	CiudadAsegurado
	) REFERENCES dbo.Ciudades
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Siniestros ADD CONSTRAINT
	FK_Siniestros_Ciudades2 FOREIGN KEY
	(
	CiudadSiniestro
	) REFERENCES dbo.Ciudades
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Siniestros SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.033', GetDate()) 

