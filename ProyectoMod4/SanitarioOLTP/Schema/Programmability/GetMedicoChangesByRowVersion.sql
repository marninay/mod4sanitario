CREATE PROCEDURE [dbo].[GetMedicoChangesByRowVersion]
	(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
SELECT codMedico
       ,DNI
       ,apellidosnombre
       ,fechaNacimiento
       ,hos.nombre

 FROM Medico med INNER JOIN Hospital hos ON (med.codHospital=hos.codHospital)
	  WHERE (med.[rowversion]) > CONVERT(ROWVERSION,@startRow) 
	  AND (med.[rowversion]) <= CONVERT(ROWVERSION,@endRow)
	  OR (hos.[rowversion]) > CONVERT(ROWVERSION,@startRow) 
	  AND (hos.[rowversion]) <= CONVERT(ROWVERSION,@endRow)
END
