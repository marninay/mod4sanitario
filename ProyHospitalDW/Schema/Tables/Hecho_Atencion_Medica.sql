CREATE TABLE Hecho_Atencion_Medica (
    idAtencion INT PRIMARY KEY,
    codHist INT,
    idMedico INT,
    codHospital INT,
    idServicio VARCHAR(10),
    idTiempo INT,
    diagnostico TEXT,
    tratamiento TEXT,
    numHabitacion INT,
    tipoAtencion VARCHAR(50),
    FOREIGN KEY (codHist) REFERENCES Dim_Paciente(codHist),
    FOREIGN KEY (idMedico) REFERENCES Dim_Medico(idMedico),
    FOREIGN KEY (codHospital) REFERENCES Dim_Hospital(codHospital),
    FOREIGN KEY (idServicio) REFERENCES Dim_Servicio(idServicio),
    FOREIGN KEY (idTiempo) REFERENCES Dim_Tiempo(idTiempo)
);

