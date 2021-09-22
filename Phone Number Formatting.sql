
/*********************************************************************************
TELEPHONE NUMBER FORMAT CHECK 

Strip a single string phone and strip out all non-digit characters

Input parameters:  @Phone
Return Value: VARCHAR(50)

**********************************************************************************/

CREATE FUNCTION fn_CleanPhone(@Phone VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE
		@Phone_Clean VARCHAR(50),
		@Counter INT,
		@StringLength INT

	-- INITIALIZE VARIABLES
	SELECT 
		@Counter = 1,
		@Phone_Clean = '',
		@StringLength = DATALENGTH(@Phone)

	-- For every character in the string, from left to right
	WHILE @Counter <= @StringLength
	BEGIN 
		-- Add the character to the clean string only if it is in the range 0..0
		SELECT @Phone_Clean = @Phone_Clean + CASE 
			WHEN SUBSTRING(@Phone, @Counter, 1) LIKE '%[0-9]%' THEN SUBSTRING(@Phone, @Counter, 1)
			ELSE ''
			END
		SELECT @Counter = @Counter + 1
	END
	RETURN @Phone_Clean
END;