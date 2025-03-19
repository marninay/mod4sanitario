CREATE TABLE Internacion (
    idinternacion INT PRIMARY KEY,
    idVisita INT,
    numHabitacion INT,
    fechaSalida DATE,
    FOREIGN KEY (idVisita) REFERENCES VisitaMedica(idVisita)
);

