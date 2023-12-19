SELECT tbl1.title, tbl1.firstName, tbl1.lastName, tbl2.firstName, tbl2.lastName
from employee as tbl1
inner JOIN employee as tbl2 on tbl1.managerId = tbl2.employeeId;

select tbl1.firstName, tbl1.lastName, salesAmount
from employee as tbl1
LEFT JOIN sales as tbl2 on tbl1.employeeId = tbl2.employeeId
where salesId IS NULL AND tbl1.title = 'Sales Person';

select t1.customerId, t1.firstName, t1.lastName, T2.salesAmount, T2.soldDate
from customer as t1
FULL OUTER JOIN sales as t2 on t1.customerId = t2.customerId;

