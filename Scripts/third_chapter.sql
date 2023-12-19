with sold as (
SELECT strftime('%Y', soldDate) as soldYear, salesAmount
from sales
)
SELECT soldYear, FORMAT("$%.2f", sum(salesAmount)) as AnnualSales
FROM sold
GROUP BY soldYear
ORDER by soldYear;


with employees_cte as (
  SELECT employeeId, firstName, lastName
  from employee
),
sales_per_month as (
  select employeeId,
          sum(CASE
          WHEN strftime('%m', soldDate) == '01' then salesAmount ELSE NULL
          END) AS janSales,
          sum(CASE
          WHEN strftime('%m', soldDate) == '02' then salesAmount ELSE NULL
          END) AS febSales,
          sum(CASE
          WHEN strftime('%m', soldDate) == '03' then salesAmount ELSE NULL
          END) AS marSales,
          sum(CASE
          WHEN strftime('%m', soldDate) == '04' then salesAmount ELSE NULL
          END) AS aprSales,
          sum(CASE
          WHEN strftime('%m', soldDate) == '05' then salesAmount ELSE NULL
          END) AS maySales,
          sum(CASE
          WHEN strftime('%m', soldDate) == '06' then salesAmount ELSE NULL
          END) AS junSales
  FROM sales
  WHERE strftime('%Y', soldDate) == '2021'
  GROUP by employeeId

)
SELECT t2.*, t1.*
FROM sales_per_month as t1
INNER join employees_cte as t2 on t1.employeeId = t2.employeeId
ORDER by lastName, firstName;

SELECT sum(salesAmount)
from sales as s1
inner join inventory i1 on s1.inventoryId = i1.inventoryId
where i1.modelId in ( select modelId from model
where EngineType = "Electric");
