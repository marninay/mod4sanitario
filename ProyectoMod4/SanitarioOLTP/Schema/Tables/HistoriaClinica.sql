CREATE TABLE [dbo].[HistoriaClinica]
(
	codHist INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_HistoriaClinica PRIMARY KEY,
    codPaciente INT,
    CONSTRAINT FK_HistoriaClinica_Paciente FOREIGN KEY (codPaciente) REFERENCES Paciente(codPaciente)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
    rowversion TIMESTAMP NOT NULL
)

