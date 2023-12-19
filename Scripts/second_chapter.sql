select t1.firstName, t1.lastName, t1.title, count(*) as carsSold
from employee as t1
INNER join sales as t2  on t1.employeeid = t2.employeeid
GROUP by t1.firstName, t1.lastName, t1.title
ORDER BY carsSold;

select t1.firstName, t1.lastName, t1.title, min(salesAmount), max(salesAmount)
from employee as t1
INNER join sales as t2  on t1.employeeid = t2.employeeid
GROUP by t1.firstName, t1.lastName, t1.title
HAVING t2.soldDate >= date('now', 'start of year');


select t1.firstName, t1.lastName, t1.title, min(salesAmount), max(salesAmount)
from employee as t1
INNER join sales as t2  on t1.employeeid = t2.employeeid
WHERE t2.soldDate >= date('now', 'start of year')
GROUP by t1.firstName, t1.lastName, t1.title
HAVING COUNT(*) > 5;
