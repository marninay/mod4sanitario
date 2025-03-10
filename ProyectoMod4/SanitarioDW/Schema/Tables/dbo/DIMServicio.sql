CREATE TABLE [dbo].[DIMServicio]
(
    ServicioSK INT IDENTITY(1,1) PRIMARY KEY,
    codServicio INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    comentario VARCHAR (150)

)
