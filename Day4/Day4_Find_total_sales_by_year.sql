/*
create table sales ( product_id int, period_start date, period_end date, average_daily_sales int ); 
insert into sales values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);
*/

-- Find total sales by year
Select * from sales;

WITH cte_numbers AS (
    -- Anchor query (start point)
    SELECT 
        product_id,
        period_start,
        period_end,
        period_start AS current_dates,
        average_daily_sales
    FROM sales
    
    UNION ALL
    
    -- Recursive query (next day)
    SELECT 
        c.product_id,
        c.period_start,
        c.period_end,
        DATEADD(DAY, 1, c.current_dates),
        average_daily_sales
    FROM cte_numbers c
    WHERE c.current_dates < c.period_end
)
SELECT  product_id,
        YEAR(current_dates) AS report_year,
        sum(average_daily_sales) AS total_amount
FROM cte_numbers
GROUP BY product_id, YEAR(current_dates)
ORDER BY product_id
OPTION (MAXRECURSION 32767);



