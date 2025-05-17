/*    
	  Lunes, 2 de Septiembre de 2.024  -   v0.00.022.sql 
	  
	  Agregamos la tabla ProcesosUsuarios 
*/

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
 CONSTRAINT [PK_ProcesosUsuarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.022', GetDate()) 

