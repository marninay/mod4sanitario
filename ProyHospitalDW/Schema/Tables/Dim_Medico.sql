CREATE TABLE Dim_Medico (
    idMedico INT PRIMARY KEY,
    nombre VARCHAR(100),
    fechaNacimiento DATE,
    especialidad VARCHAR(100),
    codHospital INT,
    FOREIGN KEY (codHospital) REFERENCES Dim_Hospital(codHospital)
);

