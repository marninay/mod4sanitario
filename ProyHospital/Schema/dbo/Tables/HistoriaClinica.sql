CREATE TABLE HistoriaClinica (
    codHist INT PRIMARY KEY,
    DNIPaciente VARCHAR(10),
    FOREIGN KEY (DNIPaciente) REFERENCES Paciente(DNI)
);

