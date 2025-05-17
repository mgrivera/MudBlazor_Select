/*    
	  Jueves, 25 de Abril de 2.024  -   v0.00.001.sql 
	  
	  Agregamos las tablas iniciales que hemos agregado hasta el momento 
	  Este es el primer script de esta aplicación! 
*/


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Empresa](
	[Id] [nvarchar](10) NOT NULL,
	[Nombre] [nvarchar](70) NOT NULL,
	[Abreviatura] [nvarchar](15) NOT NULL,
	[Direccion1] [nvarchar](50) NULL,
	[Direccion2] [nvarchar](50) NULL,
	[Direccion3] [nvarchar](50) NULL,
	[Direccion4] [nvarchar](50) NULL,
	[Direccion5] [nvarchar](50) NULL,
 CONSTRAINT [PK_Empresa] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



/****** Object:  Table [dbo].[Coberturas]    Script Date: 25/04/2024 15:45:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Coberturas](
	[Id] [nvarchar](10) NOT NULL,
	[Descripcion] [nvarchar](50) NOT NULL,
	[Abreviatura] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_Coberturas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO




SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tVersion](
	[VersionActual] [nvarchar](12) NOT NULL,
	[Fecha] [datetime] NOT NULL
) ON [PRIMARY]
GO




Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.001', GetDate()) 