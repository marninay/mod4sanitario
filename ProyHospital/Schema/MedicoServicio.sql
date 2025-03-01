CREATE TABLE MedicoServicio (
    DNI VARCHAR(10),
    idServicio VARCHAR(10),
    codHospital INT,
    PRIMARY KEY (DNI, idServicio, codHospital),
    FOREIGN KEY (DNI) REFERENCES Medico(DNI),
    FOREIGN KEY (idServicio) REFERENCES Servicio(idServicio),
    FOREIGN KEY (codHospital) REFERENCES Hospital(codHospital)
);
