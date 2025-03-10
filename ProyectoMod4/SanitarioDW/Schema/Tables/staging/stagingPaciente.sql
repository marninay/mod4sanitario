CREATE TABLE [dbo].[stagingPaciente]
(
	PacienteSK INT,
    DNI VARCHAR(10) UNIQUE NOT NULL,
    apellidosnombre VARCHAR(100) NOT NULL,
    fechaNacimiento DATE,
    numSS VARCHAR(20) UNIQUE NOT NULL,
    datosOpcionales VARCHAR(150)

)
