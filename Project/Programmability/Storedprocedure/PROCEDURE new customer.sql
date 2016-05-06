/*INSERTS new customer
However it cannot create a new company for this customer, so 
NULL or existing company_id should be passed.
I've created a Querry which handles creation of a new company if neccessary but 
couldn't incorporate it into this procedure.
It's in the Utility Scripts Folder*/

CREATE PROCEDURE [dbo].[insert_new_customer]

	@first_name varchar(50),
	@last_name varchar(50),
	@email varchar(250),
	@company_id int,     /*can be NULL*/
	@title_id tinyint	 /*can be NULL*/
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRANSACTION
BEGIN TRY
INSERT INTO customer VALUES (@first_name,
							 @last_name,
							 @email,
							 @company_id,
							 @title_id)
COMMIT TRANSACTION
END TRY
BEGIN CATCH
	PRINT 'ERROR'
	ROLLBACK TRANSACTION
END CATCH
END

