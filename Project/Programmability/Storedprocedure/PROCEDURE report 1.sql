/*Counts how many times the request for support for each
version was submitted*/


CREATE PROCEDURE [dbo].[number_of_requests]

	@version_id int
	

AS
BEGIN
	SET NOCOUNT ON;

BEGIN TRANSACTION
BEGIN TRY
    
	SELECT COUNT(version_id) AS number_of_requests, version_id FROM customer_actions
	WHERE (version_id = version_id) AND (action_type_id=3)  
	GROUP BY version_id
	COMMIT TRANSACTION
END TRY
BEGIN CATCH 
        PRINT 'ERROR'
    ROLLBACK TRANSACTION
END CATCH
END
