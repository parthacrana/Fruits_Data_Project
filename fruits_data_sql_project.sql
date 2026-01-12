-- notes 

-- WHERE CLAUSE 
select * 
from fruits_data 
where item = 'apel' 

-- BETWEEN CLAUSE -- condition clause 
select item, sold, price, city
from fruits_data
where price between 25000 and 45000 -- BETWEEN is inclusive 

-- IN CLAUSE -- multiple WHERE clauses substitute 
select item, sold, price, city
from fruits_data
where city in ('kota bandung', 'kota malang') -- IN operator 

-- WILDCARDS -- % or _ 
select * 
from fruits_data 
where item like 'Man%' -- wildcards % - any chars, _ - one char 

-- ORDER BY OPERATOR -- ordering by column_name desc / asc 
select item, item_name, price, sold  
from fruits_data 
where price > 25000 and price < 30000
order by pric desc						-- ORDER BY operator 

-- ORDER BY 1,3 DIFF VERSION -- referring to select statement 
-- via datalemur  
SELECT policy_holder_id, call_category, call_received 
FROM callers
ORDER BY 1,3 DESC;		-- 1-3 relate to select statement parts 

-- LIMIT AND OFFSET OPERATORS -- how many / by how many 
select item, item_name, price, sold  
from fruits_data 
where price > 25000 and price < 30000
order by price desc
limit 5										-- top 5 after skipping first 3 
offset 3									-- skips first 3 

-- COUNT / AGGREGATE OPERATORS -- in SELECT clause -- must go in GROUP BY statement 
select count(item)			-- returns count of how many items are there // sum/avg/min/max
from fruits_data 

-- GROUP BY AND ORDER BY OPERATORS 
select item, sum(sold) as total_items_sold, sum(price) as total_price_of_items		-- assigning aliases to column names 
from fruits_data 		
group by item								-- ** use group by when using aggregate		-- returns sold amt and price amt for each item 
-- ORDER BY goes after GROUP BY

-- HAVING OPERATOR -- condition clause with only aggregates 
select item, sum(sold)
from fruits_data
group by item 
having sum(sold) > 25000		-- is same as WHERE clause but only if using aggregate **
order by sum(sold) desc 		-- top 5 items and their revenues 

select distinct(item)
from fruits_data			-- shows only unique items 

-- ARITHMETIC, SUM, AND GROUP BY -- amt sold per item adding item numbers 
select item, sum(price*sold) as revenue_earned_per_item
from fruits_data	
group by item		-- returning revenue earned per item and item is grouped 

-- CEIL / FLOOR OPERATORS -- wont work if numbers are integers 
select item, sold, floor(sold) as approx_sold, price, floor(price) as approx_sell
from fruits_data			

-- IS NULL / = NULL / IS NOT NULL OPERATORS -- NULL -> missing data 
select *
from fruits_data
where item is null 	-- returns nothing because no values are null

-- COALESCE AND NULL -- use coalesce only if finding for NULL values  aka substitute method**
select coalsce(item, 0)
from fruits_data
where item is null 	-- returns nothing because no values are null

-- CASE WHEN THEN ELSE END AS OPERATORS -- in this order...like python IF statements, ** comes right after select statements with , or after WHERE clause 
select item, sold,
case
	when sold > 2500 then 'popular' 	-- case true value
    else 'false'			-- default value 
end as more_than_2100_sold		-- creates a new column with this column name 
from fruits_data

-- JOIN OPERATOR -- join one table with another table 
select *
from fruits_data 
join fruits_sales			-- left/middle/right/outer/inner/full outer/self
	on fruits_data.item_id = fruits_sales.item_id 		-- table 1 = table 2 should match with FROM and JOIN clauses 	

-- SUBQUERIES -- queries inside queries -- read inside first then outside***
select item_name, city, price			-- show me the item, and which city its from, if the items price exceeds the average 
from fruits_data 
where price > (						-- only if the item's price is more than the average
	select avg(price)			-- average price of items is 29038.67
    from fruits_data
    )
order by price desc

-- OVER(PARTITION BY...) -- ****know the difference between GROUP BY vs OVER(PARTITION BY)
select item, sum(sold) over(
	partition by item
    order by item) as money_spent
from fruits_data


select item, sum(sold) over(
	partition by item
    order by item desc) as total_items_sold
from fruits_data





































