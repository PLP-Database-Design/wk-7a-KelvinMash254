/* Question 1: Achieving 1NF in SQL */
WITH RECURSIVE SplitProducts AS (
    SELECT 
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(Products, ',', 1)) AS Product,
        /* Remove first product plus comma and space */
        TRIM(SUBSTR(Products, LENGTH(SUBSTRING_INDEX(Products, ',', 1)) + 2)) AS RestProducts
    FROM ProductDetail

    UNION ALL

    SELECT
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(RestProducts, ',', 1)) AS Product,
        TRIM(SUBSTR(RestProducts, LENGTH(SUBSTRING_INDEX(RestProducts, ',', 1)) + 2))
    FROM SplitProducts
    WHERE RestProducts <> ''
)
SELECT OrderID, CustomerName, Product
FROM SplitProducts
WHERE Product <> '';

/* Question 2: Achieving 2NF in SQL */

/* Step 1: Create Orders table */
CREATE TABLE Orders AS
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

/* Step 2: Create OrderDetails table without CustomerName */
CREATE TABLE OrderDetails_2NF AS
SELECT OrderID, Product, Quantity
FROM OrderDetails;
