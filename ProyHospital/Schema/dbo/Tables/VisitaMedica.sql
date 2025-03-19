CREATE TABLE VisitaMedica (
    idVisita INT PRIMARY KEY,
    fechahora DATETIME NOT NULL,
    codHospital INT,
    idServicio VARCHAR(10),
    DNIMedico VARCHAR(10),
    codHist INT,
    diagnostico TEXT,
    tratamiento TEXT,
    FOREIGN KEY (codHospital) REFERENCES Hospital(codHospital),
    FOREIGN KEY (idServicio) REFERENCES Servicio(idServicio),
    FOREIGN KEY (DNIMedico) REFERENCES Medico(DNI),
    FOREIGN KEY (codHist) REFERENCES HistoriaClinica(codHist)
);

