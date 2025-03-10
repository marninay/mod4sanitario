CREATE TABLE [dbo].[DIMPaciente]
(
	PacienteSK INT IDENTITY(1,1) PRIMARY KEY,
    codPaciente INT NOT NULL,
    DNI VARCHAR(10) UNIQUE NOT NULL,
    apellidosnombre VARCHAR(100) NOT NULL,
    fechaNacimiento DATE,
    numSS VARCHAR(20) UNIQUE NOT NULL,
    datosOpcionales VARCHAR(150)

)
