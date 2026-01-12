-- notes 

-- WHERE CLAUSE 
SELECT * 
FROM fruits_data 
WHERE item = 'apel' 

-- BETWEEN CLAUSE -- condition clause 
SELECT item, sold, price, city
FROM fruits_data
WHERE price BETWEEN 25000 AND 45000 -- BETWEEN is inclusive 

-- IN CLAUSE -- multiple WHERE clauses substitute 
SELECT item, sold, price, city
FROM fruits_data
WHERE city IN ('kota bandung', 'kota malang') -- IN operator 

-- WILDCARDS -- % or _ 
SELECT * 
FROM fruits_data 
WHERE item LIKE 'Man%' -- wildcards % - any chars, _ - one char 

-- ORDER BY OPERATOR -- ordering by column_name desc / asc 
SELECT item, item_name, price, sold  
FROM fruits_data 
WHERE price > 25000 AND price < 30000
ORDER BY price DESC						-- ORDER BY operator 

-- ORDER BY 1,3 DIFF VERSION -- referring to select statement 
-- via datalemur  
SELECT policy_holder_id, call_category, call_received 
FROM callers
ORDER BY 1,3 DESC;		-- 1-3 relate to select statement parts 

-- LIMIT AND OFFSET OPERATORS -- how many / by how many 
SELECT item, item_name, price, sold  
FROM fruits_data 
WHERE price > 25000 AND price < 30000
ORDER BY price DESC
LIMIT 5										-- top 5 after skipping first 3 
offset 3									-- skips first 3 

-- COUNT / AGGREGATE OPERATORS -- in SELECT clause -- must go in GROUP BY statement 
SELECT COUNT(item)			-- returns count of how many items are there // sum/avg/min/max
FROM fruits_data 

-- GROUP BY AND ORDER BY OPERATORS 
SELECT item, sum(sold) AS total_items_sold, sum(price) AS total_price_of_items		-- assigning aliases to column names 
FROM fruits_data 		
GROUP BY item								-- ** use group by when using aggregate		-- returns sold amt and price amt for each item 
-- ORDER BY goes after GROUP BY

-- HAVING OPERATOR -- condition clause with only aggregates 
SELECT item, sum(sold)
FROM fruits_data
GROUP BY item 
HAVING sum(sold) > 25000		-- is same as WHERE clause but only if using aggregate **
ORDER BY sum(sold) DESC 		-- top 5 items and their revenues 

SELECT DISTINCT(item)
FROM fruits_data			-- shows only unique items 

-- ARITHMETIC, SUM, AND GROUP BY -- amt sold per item adding item numbers 
SELECT item, sum(price*sold) AS revenue_earned_per_item
FROM fruits_data	
GROUP BY item		-- returning revenue earned per item and item is grouped 

-- CEIL / FLOOR OPERATORS -- wont work if numbers are integers 
SELECT item, sold, floor(sold) AS approx_sold, price, floor(price) AS approx_sell
FROM fruits_data			

-- IS NULL / = NULL / IS NOT NULL OPERATORS -- NULL -> missing data 
SELECT *
FROM fruits_data
WHERE item IS NULL 	-- returns nothing because no values are null

-- COALESCE AND NULL -- use coalesce only if finding for NULL values  aka substitute method**
SELECT coalsce(item, 0)
FROM fruits_data
WHERE item IS NULL 	-- returns nothing because no values are null

-- CASE WHEN THEN ELSE END AS OPERATORS -- in this order...like python IF statements, ** comes right after select statements with , or after WHERE clause 
SELECT item, sold,
CASE
	WHEN sold > 2500 THEN 'popular' 	-- case true value
    ELSE 'false'			-- default value 
END AS more_than_2100_sold		-- creates a new column with this column name 
FROM fruits_data

-- JOIN OPERATOR -- join one table with another table 
SELECT *
FROM fruits_data 
JOIN fruits_sales			-- left/middle/right/outer/inner/full outer/self
	ON fruits_data.item_id = fruits_sales.item_id 		-- table 1 = table 2 should match with FROM and JOIN clauses 	

-- SUBQUERIES -- queries inside queries -- read inside first then outside***
SELECT item_name, city, price			-- show me the item, and which city its from, if the items price exceeds the average 
FROM fruits_data 
WHERE price > (						-- only if the item's price is more than the average
	SELECT AVG(price)			-- average price of items is 29038.67
    FROM fruits_data
    )
ORDER BY price DESC

-- OVER(PARTITION BY...) -- ****know the difference between GROUP BY vs OVER(PARTITION BY)
SELECT item, sum(sold) over(
	partition BY item
    ORDER BY item) AS money_spent
FROM fruits_data


SELECT item, SUM(sold) over(
	PARTITION BY item
    ORDER BY item DESC) as total_items_sold
FROM fruits_data





































