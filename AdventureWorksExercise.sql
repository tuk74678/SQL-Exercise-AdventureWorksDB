USE AdventureWorks2019;					--Make sure to select the database before writing SQL queries
GO

	SELECT 
		ProductID, 
		Name, 
		Color, 
		ListPrice
	FROM 
		Production.Product;

	SELECT 
		ProductID, 
		Name, 
		Color, 
		ListPrice
	FROM
		Production.Product
	WHERE 
		NOT ListPrice = 0;

	SELECT 
		ProductID, 
		Name, 
		Color, 
		ListPrice
	FROM
		Production.Product
	WHERE 
		Color IS NULL;
		
	SELECT
		ProductID,
		Name,
		Color,
		ListPrice
	FROM
		Production.Product
	WHERE
		Color IS NOT NULL;

	SELECT
		ProductID,
		Name,
		Color,
		ListPrice 
	FROM
		Production.Product
	WHERE 
		Color IS NOT NULL 	--Return row that are not null for column color
	  AND					--Using AND Operator when both conditions are met
		ListPrice > 0;		--ListPrice has to be greater than 0

	SELECT 
		Name + ' ' + Color  --Concatenate name and color
	FROM 
		Production.Product
	WHERE
		Color IS NOT NULL;	--Exclude rows with null color
		
    SELECT 
		'Name: ' + Name + ' -- Color: ' + Color		--Concatenate the text with column values
	  AS ProductInfo			-- I added Alias AS for clarity
	FROM 
		Production.Product
	WHERE 
		Color IS NOT NULL;
	
    SELECT
		ProductID,
		Name
	FROM 
		Production.Product 
	WHERE 
		ProductID BETWEEN 400 AND 500;		--Using BETWEEN and AND to specify range

	SELECT 
		ProductID,
		Name
	FROM 
		Production.Product
	WHERE 
		Color IN ('Black', 'Blue');		--Using IN to filter rows 

	SELECT * 
	FROM 
		Production.Product
	WHERE 
		Name LIKE 'S%';			--Using LIKE to filter row where Name starts with S
		
	SELECT
		ProductID,
		Name,
		ListPrice
	FROM 
		Production.Product
	ORDER BY 
		Name ASC;				--Name is sorted alphabetically or ascending by default

	SELECT 
		Name,
		ListPrice
	FROM
		Production.Product
	WHERE
		Name LIKE 'A%' OR Name LIKE'S%'		--OR Operator to expand the filter search
	ORDER BY 
		Name ASC;				--Sort the Name in ascending

	SELECT 
		Name
	FROM 
		Production.Product
	WHERE 
		Name LIKE 'SPO[^K]%'		--Match the first three letters then exclude the lettter 
	ORDER BY
		Name;

	SELECT 
		Color
	FROM 
		Production.Product
	GROUP BY
		Color				--Groups rows by each unique color
	ORDER BY
		Color DESC;			--Sort the color in descending order

	

