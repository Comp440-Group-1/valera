BEGIN TRY
	DECLARE @product_id int;
	DECLARE @product_name varchar(50);

	SET @product_name = 'Patient Records'

	INSERT INTO product([product_name]) VALUES (@product_name)

	SET @product_id = (SELECT product_id FROM product WHERE product_name=@product_name)

	INSERT INTO product_description([product_id], product_description) VALUES (@product_id, 'Very good software!')

	INSERT INTO product_housekeeping([product_id], date_introduced, employee_id) VALUES (@product_id, '01/01/2000',1)


	SET @product_name = 'Therac-25'

	INSERT INTO product([product_name]) VALUES (@product_name)

	SET @product_id = (SELECT product_id FROM product WHERE product_name=@product_name)

	INSERT INTO product_description([product_id], product_description) VALUES (@product_id, 'Recommended!!')

	INSERT INTO product_housekeeping([product_id], date_introduced, employee_id) VALUES (@product_id, '01/01/2000',1)
END TRY
BEGIN CATCH
PRINT('Something went very wrong!')
END CATCH