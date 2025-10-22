USE AdventureWorks2019;					--Make sure to select the database before writing SQL queries
GO
--1
	SELECT 
		ProductID, 
		Name, 
		Color, 
		ListPrice
	FROM 
		Production.Product;
--2
	SELECT 
		ProductID, 
		Name, 
		Color, 
		ListPrice
	FROM
		Production.Product
	WHERE 
		NOT ListPrice = 0;
--3
	SELECT 
		ProductID, 
		Name, 
		Color, 
		ListPrice
	FROM
		Production.Product
	WHERE 
		Color IS NULL;
--4		
	SELECT
		ProductID,
		Name,
		Color,
		ListPrice
	FROM
		Production.Product
	WHERE
		Color IS NOT NULL;
--5
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
--6
	SELECT 
		Name + ' ' + Color  --Concatenate name and color
	FROM 
		Production.Product
	WHERE
		Color IS NOT NULL;	--Exclude rows with null color
--7		
    SELECT 
		'Name: ' + Name + ' -- Color: ' + Color		--Concatenate the text with column values
	  AS ProductInfo			-- I added Alias AS for clarity
	FROM 
		Production.Product
	WHERE 
		Color IS NOT NULL;
--8	
    SELECT
		ProductID,
		Name
	FROM 
		Production.Product 
	WHERE 
		ProductID BETWEEN 400 AND 500;		--Using BETWEEN and AND to specify range
--9
	SELECT 
		ProductID,
		Name
	FROM 
		Production.Product
	WHERE 
		Color IN ('Black', 'Blue');		--Using IN to filter rows 
--10
	SELECT * 
	FROM 
		Production.Product
	WHERE 
		Name LIKE 'S%';			--Using LIKE to filter row where Name starts with S
--11		
	SELECT
		ProductID,
		Name,
		ListPrice
	FROM 
		Production.Product
	ORDER BY 
		Name ASC;				--Name is sorted alphabetically or ascending by default
--12
	SELECT 
		Name,
		ListPrice
	FROM
		Production.Product
	WHERE
		Name LIKE 'A%' OR Name LIKE'S%'		--OR Operator to expand the filter search
	ORDER BY 
		Name ASC;				--Sort the Name in ascending
--13
	SELECT 
		Name
	FROM 
		Production.Product
	WHERE 
		Name LIKE 'SPO[^K]%'		--Match the first three letters then exclude the lettter 
	ORDER BY
		Name;
--14
	SELECT 
		Color
	FROM 
		Production.Product
	GROUP BY
		Color				--Groups rows by each unique color
	ORDER BY
		Color DESC;			--Sort the color in descending order

	


