/*    
	  Sábado, 25 de Enero de 2.025  -   v0.00.040.sql 
	  
	  Modificamos levemente la tabla tmp que usa la consulta de
	  cifras emitidas por cobertura 
*/

ALTER TABLE [dbo].[Tmp_CifrasPorCobertura_ConsultaEmision_Report] DROP CONSTRAINT [FK_Tmp_CifrasPorCobertura_ConsultaEmision_Report_ProcesosUsuarios]
GO

/****** Object:  Table [dbo].[Tmp_CifrasPorCobertura_ConsultaEmision_Report]    Script Date: 1/25/2025 12:35:46 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tmp_CifrasPorCobertura_ConsultaEmision_Report]') AND type in (N'U'))
DROP TABLE [dbo].[Tmp_CifrasPorCobertura_ConsultaEmision_Report]
GO

/****** Object:  Table [dbo].[Tmp_CifrasPorCobertura_ConsultaEmision_Report]    Script Date: 1/25/2025 12:35:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
	[Referencia] [nvarchar](16) NOT NULL,
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
	NtraOrdenPorc [decimal](10, 6) Not Null, 
    SumaAseguradaNtraOrden money Not Null, 
    PrimaNtraOrden money Not Null, 
	[Cia] [nvarchar](10) NOT NULL,
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

/****** Object:  View [dbo].[V_Tmp_CifrasPorCobertura_ConsultaEmision_Report]    Script Date: 1/25/2025 12:48:25 PM ******/
DROP VIEW [dbo].[V_Tmp_CifrasPorCobertura_ConsultaEmision_Report]
GO

/****** Object:  View [dbo].[V_Tmp_CifrasPorCobertura_ConsultaEmision_Report]    Script Date: 1/25/2025 12:48:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/****** Object:  View [dbo].[V_Tmp_CifrasPorCobertura_ConsultaEmision_Report]     ******/
CREATE   View [dbo].[V_Tmp_CifrasPorCobertura_ConsultaEmision_Report] as 
SELECT tmp.ProcesoId as procesoId, mon.Descripcion as monedaNombre, ram.Descripcion as ramoNombre, cob.Descripcion as coberturaNombre, pai.Nombre as paisNombre, 
		tmp.Numero as numero, tmp.Endoso as endoso, tmp.Estado as estado, tmp.Referencia, 
		tmp.Desde_aceptacion as desde, tmp.Hasta_aceptacion as hasta, tmp.Dias_aceptacion as dias, 
		comp.Abreviatura as companiaAbreviatura, aseg.Abreviatura as aseguradoAbreviatura, 
		tmp.SumaAseguradaUnidad as sumaAseguradaUnidad, tmp.Cantidad as cantidad, tmp.SumaAsegurada as sumaAsegurada, 
		tmp.Tasa as tasa, tmp.Prima as prima, 
		tmp.NtraOrdenPorc, 
		tmp.SumaAseguradaNtraOrden, 
		tmp.PrimaNtraOrden, 
		emp.Nombre as empresaNombre 
FROM   dbo.Tmp_CifrasPorCobertura_ConsultaEmision_Report tmp Left Join dbo.Monedas  mon On tmp.MonedaId = mon.Id    
                 Left Join dbo.Ramos ram On tmp.Ramo = ram.Id 
                 Left Join dbo.Coberturas  cob On tmp.CoberturaId = cob.Id                 
                 Left Join dbo.Paises pai On tmp.Pais = pai.Id 
                 Left Join dbo.Companias comp On tmp.Cedente = comp.Id 
                 Left Join dbo.Asegurados aseg On tmp.Asegurado = aseg.Id        
                 Left Join dbo.Empresa emp On tmp.Cia = emp.Id 
GO

Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.040', GetDate()) 

