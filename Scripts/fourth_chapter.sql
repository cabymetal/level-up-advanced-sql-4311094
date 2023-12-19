select employeeId, salesAmountPerModel, model, RANK() OVER(PARTITION BY employeeId ORDER BY salesAmountPerModel DESC) Rank
from (
  select employeeid, sum(salesAmount) as salesAmountPerModel, t3.model
  from sales as t1
  INNER JOIN inventory as t2 on t1.inventoryId = t2.inventoryId
  inner join model as t3 on t2.modelId = t3.modelId
  group by employeeId, model
) as q1;

with sales_per_year as(
  select "" as year, strftime('%Y', soldDate) as month, sum(salesAmount) as salesAmount
  from sales
  group by month
),
sales_per_month as ( 
  select strftime('%Y', soldDate) as year, strftime('%m', soldDate) as month, sum(salesAmount) as salesAmount
  from sales
  group by year, month)
select *
from sales_per_month
union 
select *
from sales_per_year;

with cte_sales as (
SELECT strftime('%Y', soldDate) AS soldYear, 
  strftime('%m', soldDate) AS soldMonth,
  SUM(salesAmount) AS salesAmount
FROM sales
GROUP BY soldYear, soldMonth
)
SELECT soldYear, soldMonth, salesAmount,
  SUM(salesAmount) OVER (
    PARTITION BY soldYear 
    ORDER BY soldYear, soldMonth) AS AnnualSales_RunningTotal
FROM cte_sales
ORDER BY soldYear, soldMonth;

SELECT strftime('%Y-%m', soldDate) AS MonthSold,
  COUNT(*) AS NumberCarsSold,
  LAG (COUNT(*), 1, 0 ) OVER (ORDER BY strftime('%Y-%m', soldDate)) AS LastMonthCarsSold
FROM sales
GROUP BY strftime('%Y-%m', soldDate)
ORDER BY strftime('%Y-%m', soldDate);

