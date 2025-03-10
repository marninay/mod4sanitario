CREATE TABLE [dbo].[Servicio]
(
	codServicio INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Servicio PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    comentario VARCHAR(150),
    rowversion TIMESTAMP NOT NULL

)
