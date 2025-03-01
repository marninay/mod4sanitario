CREATE TABLE Paciente (
    DNI VARCHAR(10) PRIMARY KEY,
    apellidosnombre VARCHAR(100) NOT NULL,
    fechaNacimiento DATE,
    numSS VARCHAR(20) UNIQUE NOT NULL,
    datosOpcionales TEXT
);

