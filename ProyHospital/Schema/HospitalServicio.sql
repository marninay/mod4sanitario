CREATE TABLE HospitalServicio (
    codHospital INT,
    idServicio VARCHAR(10),
    numCamas INT,
    PRIMARY KEY (codHospital, idServicio),
    FOREIGN KEY (codHospital) REFERENCES Hospital(codHospital)
   ON DELETE CASCADE
    ON UPDATE CASCADE
,
    FOREIGN KEY (idServicio) REFERENCES Servicio(idServicio)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

