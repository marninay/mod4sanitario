CREATE TABLE [dbo].[Paciente]
(
	codPaciente INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Paciente PRIMARY KEY,
    DNI VARCHAR(10) UNIQUE NOT NULL,
    apellidosnombre VARCHAR(100) NOT NULL,
    fechaNacimiento DATE,
    numSS VARCHAR(20) UNIQUE NOT NULL,
    datosOpcionales VARCHAR(150),
    rowversion TIMESTAMP NOT NULL

)
