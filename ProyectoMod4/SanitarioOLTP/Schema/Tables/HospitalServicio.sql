CREATE TABLE [dbo].[HospitalServicio]
(
	codHospital INT NOT NULL,
    codServicio INT NOT NULL,
    numCamas INT,
    PRIMARY KEY (codHospital, codServicio),
    CONSTRAINT FK_HospServicio_Hosp FOREIGN KEY (codHospital) REFERENCES
    Hospital(codHospital)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FK_HospServcio_Serv FOREIGN KEY (codServicio) REFERENCES Servicio(codServicio)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    rowversion TIMESTAMP NOT NULL
)
