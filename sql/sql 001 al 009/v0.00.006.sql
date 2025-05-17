/*    
	  Martes, 30 de Abril de 2.024  -   v0.00.006.sql 
	  
	  Agregamos la tabla Filtros 
*/

/****** Object:  Table [dbo].[Filtros]    Script Date: 30/04/2024 13:04:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Filtros](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [nvarchar](50) NOT NULL,
	[nombreForma] [nvarchar](50) NOT NULL,
	[filtro] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_Filtros] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.006', GetDate()) 
