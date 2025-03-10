CREATE PROCEDURE [dbo].[GetHospitalChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
	SELECT codHospital
    ,nombre
    ,ciudad
    ,telefono
    ,codMedicoDirector
 FROM Hospital
	  WHERE [rowversion] > CONVERT(ROWVERSION,@startRow) 
	  AND [rowversion] <= CONVERT(ROWVERSION,@endRow)
END
