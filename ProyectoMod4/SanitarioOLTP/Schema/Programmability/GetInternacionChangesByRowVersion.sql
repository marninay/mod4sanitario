CREATE PROCEDURE [dbo].[GetInternacionChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
	SELECT   
	     inter.codinternacion,
		 TiempoIngresoKey = CONVERT(INT,
							(CONVERT(CHAR(4),DATEPART(YEAR,inter.fechaInternacion))
						  + CASE 
								WHEN DATEPART(MONTH,inter.fechaInternacion) < 10 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,inter.fechaInternacion))
								ELSE + CONVERT(CHAR(2),DATEPART(MONTH,inter.fechaInternacion))
							END
						  + CASE 
								WHEN DATEPART(DAY,inter.fechaInternacion) < 10 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,inter.fechaInternacion))
								ELSE + CONVERT(CHAR(2),DATEPART(DAY,inter.fechaInternacion))
							END)),
		 TiempoSalidaKey = CONVERT(INT,
							(CONVERT(CHAR(4),DATEPART(YEAR,inter.fechaSalida))
						  + CASE 
								WHEN DATEPART(MONTH,inter.fechaSalida) < 10 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,inter.fechaSalida))
								ELSE + CONVERT(CHAR(2),DATEPART(MONTH,inter.fechaSalida))
							END
						  + CASE 
								WHEN DATEPART(DAY,inter.fechaSalida) < 10 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,inter.fechaSalida))
								ELSE + CONVERT(CHAR(2),DATEPART(DAY,inter.fechaSalida))
							END)),
    hc.codPaciente,
    inter.codVisita,
    numHabitacion,
    numCama
    FROM [dbo].[Internacion] inter INNER JOIN [dbo].[VisitaMedica] vimed ON (inter.codVisita=vimed.codVisita)
	INNER JOIN [dbo].[HistoriaClinica] hc ON (vimed.[codHist]=hc.[codHist])
	WHERE (inter.[rowversion] > CONVERT(ROWVERSION,@startRow) 
			AND inter.[rowversion] <= CONVERT(ROWVERSION,@endRow)) 
			OR (vimed.[rowversion] > CONVERT(ROWVERSION,@startRow) 
			AND vimed.[rowversion] <= CONVERT(ROWVERSION,@endRow))
			OR (hc.[rowversion] > CONVERT(ROWVERSION,@startRow) 
			AND hc.[rowversion] <= CONVERT(ROWVERSION,@endRow))
END
