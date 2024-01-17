-------Page With No Likes [Facebook SQL Interview Question]
SELECT p.page_id FROM pages p
LEFt join page_likes pl 
ON p.page_id=pl.page_id
WHERE liked_date is NULL
ORDER BY p.page_id
---------listed products in a period
SELECT p.product_name, SUM(o.unit) AS total_units_ordered
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE MONTH(o.order_date) = 2 AND YEAR(o.order_date) = 2020
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;
---------employee report each others
SELECT 
    e.employee_id,
    e.name,
    COUNT(r.employee_id) AS report_count,
    ROUND(AVG(r.age)) AS average_age
FROM Employees e
LEFT JOIN Employees r ON e.employee_id = r.reports_to
WHERE e.employee_id IN (SELECT DISTINCT reports_to FROM Employees WHERE reports_to IS NOT NULL)
GROUP BY e.employee_id, e.name
ORDER BY e.employee_id;
-----------Supercloud Customer [Microsoft SQL Interview Question]
not finish
-------Sending vs. Opening Snaps [Snapchat SQL Interview Question]
with cte_query as (select * from activities inner join age_breakdown on activities.user_id = age_breakdown.user_id where activity_type in ('open','send'))
select distinct age_bucket,
ROUND((sum(case when activity_type='send' then time_spent else 0 END) OVER(PARTITION BY age_bucket)/sum(time_spent) OVER(PARTITION BY age_bucket) * 100)::numeric,2) as
send_perc, 
ROUND ((sum(case when activity_type='open' then time_spent else 0 END) OVER(PARTITION BY age_bucket)/sum(time_spent) OVER(PARTITION BY age_bucket) * 100)::numeric,2) as
open_perc
FROM cte_query group by cte_query.age_bucket,cte_query.time_spent,cte_query.activity_type
-------Signup Activation Rate
SELECT
    ROUND(SUM(CASE WHEN user_id IS NOT NULL THEN 1 ELSE 0 END) / COUNT(e.user_id) * 100.0, 2) AS activation_rate
FROM
    emails e
LEFT JOIN
    texts t ON e.user_id = user_id;
--------query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) 
SELECT
    COUNTRY.Continent,
    FLOOR(AVG(CITY.Population)) AS average_city_population
FROM
    COUNTRY
JOIN
    CITY ON COUNTRY.Code = CITY.CountryCode
GROUP BY
    COUNTRY.Continent;



