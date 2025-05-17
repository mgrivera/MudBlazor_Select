/*    
	  Lunes, 9 de Septiembre de 2.024  -   v0.00.024.sql 
	  
	  Agregamos las tablas: ProcesosUsuario y Tmp_CifrasPorCobertura_ConsultaEmision_Report 
	  Además, el view para leer la tabla desde la apliacción Access: V_Tmp_CifrasPorCobertura_ConsultaEmision_Report
*/



/****** Object:  Table [dbo].[Tmp_CifrasPorCobertura_ConsultaEmision_Report]    Script Date: 9/9/2024 5:12:03 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tmp_CifrasPorCobertura_ConsultaEmision_Report]') AND type in (N'U'))
	DROP TABLE [dbo].[Tmp_CifrasPorCobertura_ConsultaEmision_Report]
GO


/****** Object:  Table [dbo].[ProcesosUsuarios]    Script Date: 9/9/2024 5:11:31 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProcesosUsuarios]') AND type in (N'U'))
	DROP TABLE [dbo].[ProcesosUsuarios]
GO


/****** Object:  Table [dbo].[Tmp_CifrasPorCobertura_ConsultaEmision_Report]    Script Date: 9/9/2024 5:12:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  Table [dbo].[ProcesosUsuarios]    Script Date: 9/9/2024 5:11:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ProcesosUsuarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [smalldatetime] NOT NULL,
	[Categoria] [nvarchar](30) NOT NULL,
	[SubCategoria] [nvarchar](30) NOT NULL,
	[Descripcion] [nvarchar](300) NOT NULL,
	[Usuario] [nvarchar](25) NOT NULL,
	[SubTituloReport] [nvarchar](100) NULL,
 CONSTRAINT [PK_ProcesosUsuarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[Tmp_CifrasPorCobertura_ConsultaEmision_Report](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProcesoId] [int] NOT NULL,
	[MonedaId] [nvarchar](10) NOT NULL,
	[Ramo] [nvarchar](10) NOT NULL,
	[CoberturaId] [nvarchar](10) NOT NULL,
	[Pais] [nvarchar](6) NOT NULL,
	[Numero] [nvarchar](16) NOT NULL,
	[Endoso] [smallint] NOT NULL,
	[Estado] [nvarchar](10) NOT NULL,
	[Desde_aceptacion] [datetime] NOT NULL,
	[Hasta_aceptacion] [datetime] NOT NULL,
	[Dias_aceptacion] [smallint] NOT NULL,
	[Asegurado] [nvarchar](10) NOT NULL,
	[Cedente] [nvarchar](10) NOT NULL,
	[SumaAseguradaUnidad] [money] NULL,
	[Cantidad] [smallint] NULL,
	[SumaAsegurada] [money] NOT NULL,
	[Tasa] [decimal](10, 6) NULL,
	[Prima] [money] NOT NULL,
	[Cia] [nvarchar](10) NOT NULL
 CONSTRAINT [PK_Tmp_CifrasPorCobertura_ConsultaEmision_Report] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Tmp_CifrasPorCobertura_ConsultaEmision_Report]  WITH CHECK ADD  CONSTRAINT [FK_Tmp_CifrasPorCobertura_ConsultaEmision_Report_ProcesosUsuarios] FOREIGN KEY([ProcesoId])
REFERENCES [dbo].[ProcesosUsuarios] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Tmp_CifrasPorCobertura_ConsultaEmision_Report] CHECK CONSTRAINT [FK_Tmp_CifrasPorCobertura_ConsultaEmision_Report_ProcesosUsuarios]
GO


/****** Object:  View [dbo].[V_Tmp_CifrasPorCobertura_ConsultaEmision_Report]     ******/
CREATE OR ALTER View [dbo].[V_Tmp_CifrasPorCobertura_ConsultaEmision_Report] as 
SELECT tmp.ProcesoId as procesoId, mon.Descripcion as monedaNombre, ram.Descripcion as ramoNombre, cob.Descripcion as coberturaNombre, pai.Nombre as paisNombre, 
		tmp.Numero as numero, tmp.Endoso as endoso, tmp.Estado as estado, 
		tmp.Desde_aceptacion as desde, tmp.Hasta_aceptacion as hasta, tmp.Dias_aceptacion as dias, 
		comp.Abreviatura as companiaAbreviatura, aseg.Abreviatura as aseguradoAbreviatura, 
		tmp.SumaAseguradaUnidad as sumaAseguradaUnidad, tmp.Cantidad as cantidad, tmp.SumaAsegurada as sumaAsegurada, 
		tmp.Tasa as tasa, tmp.Prima as prima, emp.Nombre as empresaNombre 
FROM   dbo.Tmp_CifrasPorCobertura_ConsultaEmision_Report tmp Left Join dbo.Monedas  mon On tmp.MonedaId = mon.Id    
                 Left Join dbo.Ramos ram On tmp.Ramo = ram.Id 
                 Left Join dbo.Coberturas  cob On tmp.CoberturaId = cob.Id                 
                 Left Join dbo.Paises pai On tmp.Pais = pai.Id 
                 Left Join dbo.Companias comp On tmp.Cedente = comp.Id 
                 Left Join dbo.Asegurados aseg On tmp.Asegurado = aseg.Id        
                 Left Join dbo.Empresa emp On tmp.Cia = emp.Id 
GO



/****** Object:  Table [dbo].[Usuarios]    Script Date: 9/10/2024 5:30:04 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usuarios]') AND type in (N'U'))
DROP TABLE [dbo].[Usuarios]
GO

/****** Object:  Table [dbo].[Usuarios]    Script Date: 9/10/2024 5:30:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Usuarios](
	[Usuario] [int] IDENTITY(1,1) NOT NULL,
	[PalabraClave] [nvarchar](20) NULL,
	[Nombre] [nvarchar](25) NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[IsUser] [bit] NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY NONCLUSTERED 
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Usuarios] ADD  CONSTRAINT [DF_Usuarios_IsAdmin]  DEFAULT ((0)) FOR [IsAdmin]
GO

ALTER TABLE [dbo].[Usuarios] ADD  CONSTRAINT [DF_Usuarios_IsUser]  DEFAULT ((0)) FOR [IsUser]
GO





Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.024', GetDate()) 

