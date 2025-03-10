CREATE TABLE [dbo].[Hospital]
(
	codHospital INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Hospital PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    telefono VARCHAR(15),
    codMedicoDirector INT UNIQUE,
    rowversion TIMESTAMP NOT NULL

)
