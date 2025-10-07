USE Cis111_GuitarShop
--CIS 111 03 Hebatallah Tharhan end of chapter 6 upload--
--Query 1--
Select DISTINCT CategoryName
From Categories
Where CategoryID in (Select CategoryID from Products)
ORDER BY CategoryName
--Query 2--
Select ProductName, ListPrice
From Products 
Where ListPrice > (Select AVG(ListPrice) from Products )
Order by ListPrice desc;
--Query 3--
Select CategoryName
from Categories c
where not exists (Select * from Products p where c.CategoryID = p.CategoryID)
--Query 4--
Select c.EmailAddress, o.OrderID, SUM((oi.ItemPrice - oi.DiscountAmount) * oi.Quantity) as OrderTotal
From Customers c inner join Orders o on c.CustomerID = o.CustomerID
inner join OrderItems oi on o.OrderID=oi.OrderID
Group by c.EmailAddress,  o.OrderID;

Select EmailAddress, MAX(OrderTotal) as LargestOrder
From (Select c.EmailAddress, o.OrderID, SUM((oi.ItemPrice - oi.DiscountAmount) * oi.Quantity) as OrderTotal
From Customers c inner join Orders o on c.CustomerID = o.CustomerID
inner join OrderItems oi on o.OrderID=oi.OrderID
Group by c.EmailAddress,  o.OrderID) as Sub
Group by EmailAddress
--Query 5--
Select ProductName, DiscountPercent
From Products
Where DiscountPercent in (
    Select DiscountPercent
    from Products
    group by DiscountPercent
    having COUNT(*) = 1
)
order by ProductName;
--Query 6--
Select c.EmailAddress, o.OrderID, o.OrderDate
From Customers c inner join Orders o on c.CustomerID = o.CustomerID
Where o.OrderDate =
	(SELECT min(OrderDate)
	From Orders as o
	where c.CustomerID = o.CustomerID)
Order by o.OrderDate


