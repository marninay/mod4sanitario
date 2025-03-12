CREATE PROCEDURE [dbo].[GetVisitaMedicaChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
	SELECT   
	     vimed.codVisita,
		  DateKey = CONVERT(INT,
							(CONVERT(CHAR(4),DATEPART(YEAR,vimed.[fechahora]))
						  + CASE 
								WHEN DATEPART(MONTH,vimed.[fechahora]) < 10 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,vimed.[fechahora]))
								ELSE + CONVERT(CHAR(2),DATEPART(MONTH,vimed.[fechahora]))
							END
						  + CASE 
								WHEN DATEPART(DAY,vimed.[fechahora]) < 10 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,vimed.[fechahora]))
								ELSE + CONVERT(CHAR(2),DATEPART(DAY,vimed.[fechahora]))
							END)),
	vimed.codHospital ,
    vimed.codServicio ,
    vimed.codMedico ,
    hc.codPaciente ,
    vimed.diagnostico ,
    vimed.tratamiento
    FROM [dbo].[VisitaMedica] vimed
	INNER JOIN [dbo].[HistoriaClinica] hc ON (vimed.[codHist]=hc.[codHist])
	WHERE (vimed.[rowversion] > CONVERT(ROWVERSION,@startRow) 
			AND vimed.[rowversion] <= CONVERT(ROWVERSION,@endRow))
	OR (hc.[rowversion] > CONVERT(ROWVERSION,@startRow) 
			AND hc.[rowversion] <= CONVERT(ROWVERSION,@endRow))
END
