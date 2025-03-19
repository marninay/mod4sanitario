CREATE TABLE Medico (
    DNI VARCHAR(10) PRIMARY KEY,
    apellidosnombre VARCHAR(100) NOT NULL,
    fechaNacimiento DATE,
    codHospital INT,
    esDirector BIT,
    FOREIGN KEY (codHospital) REFERENCES Hospital(codHospital)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

