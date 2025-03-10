CREATE PROCEDURE [dbo].[GetPacienteChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
SELECT 
    codPaciente
   ,DNI
   ,apellidosnombre
   ,fechaNacimiento
   ,numSS
   ,datosOpcionales
 FROM Paciente
	  WHERE [rowversion] > CONVERT(ROWVERSION,@startRow) 
	  AND [rowversion] <= CONVERT(ROWVERSION,@endRow)
END
