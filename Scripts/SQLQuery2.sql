DELETE FROM product WHERE product_name = 'Patient Records'
DELETE FROM product WHERE product_name = 'Patient Records'
DELETE FROM product WHERE product_name = 'Patient Records'
DELETE FROM product WHERE product_name = 'Patient Records'
DECLARE @product_id int;
DECLARE @product_name varchar(50);

SET @product_name = 'Patient Records'

INSERT INTO product([product_name]) VALUES (@product_name)

SET @product_id = (SELECT product_id FROM product WHERE product_name=@product_name)

