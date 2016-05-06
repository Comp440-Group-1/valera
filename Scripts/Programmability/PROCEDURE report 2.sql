/*returns a list of customers who
belong to the given company*/

CREATE PROCEDURE [dbo].[get_customers_by_company] 

@company_name varchar(50)

AS
BEGIN
	
	SET NOCOUNT ON;

	
	BEGIN TRY
	DECLARE @company_id int;
	SET @company_id = (SELECT company_id FROM company WHERE name = @company_name)
	SELECT first_name, last_name, email FROM customer WHERE company_id = @company_id
	

		GROUP BY last_name, first_name, email
	END TRY

	
	BEGIN CATCH
		PRINT 'ERROR'
	END CATCH
END