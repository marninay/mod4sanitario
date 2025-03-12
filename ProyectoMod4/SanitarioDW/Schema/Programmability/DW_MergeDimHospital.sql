CREATE PROCEDURE [dbo].[DW_MergeDimHospital]
AS
BEGIN
	UPDATE dh
	SET [nombre]=sh.[nombre],
		[ciudad]=sh.[ciudad],
		[telefono]=sh.[telefono],
		[codDirector]=sh.[codDirector] 
	FROM [dbo].[DIMHospital]    dh
	INNER JOIN stagingHospital sh ON (dh.[HospitalSK] =sh.[HospitalSK])
END