CREATE DATABASE e_commerce_order_trends;
use e_commerce_order_trends;

CREATE TABLE Users (
UserID INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100) UNIQUE,
PasswordHash VARCHAR(255),
Role ENUM('Admin', 'Customer'),
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Customers (
CustomerID INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
Address TEXT,
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Products (
ProductID INT AUTO_INCREMENT PRIMARY KEY,
ProductName VARCHAR(100),
Category VARCHAR(50),
Price DECIMAL(10, 2),
Stock INT,
Description TEXT,
ImageURL VARCHAR(255),
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Orders (
OrderID INT AUTO_INCREMENT PRIMARY KEY,
CustomerID INT,
OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
TotalAmount DECIMAL(10, 2),
Status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled'),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT,
Price DECIMAL(10, 2),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Coupons (
CouponID INT AUTO_INCREMENT PRIMARY KEY,
Code VARCHAR(50),
DiscountPercentage DECIMAL(5, 2),
ExpiryDate DATE,
UsageLimit INT,
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE OrderCoupons (
OrderCouponID INT AUTO_INCREMENT PRIMARY KEY,
OrderID INT,
CouponID INT,
DiscountAmount DECIMAL(10, 2),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (CouponID) REFERENCES Coupons(CouponID)
);

CREATE TABLE ProductReviews (
ReviewID INT AUTO_INCREMENT PRIMARY KEY,
ProductID INT,
CustomerID INT,
Rating INT CHECK (Rating BETWEEN 1 AND 5),
ReviewText TEXT,
ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Shipments (
ShipmentID INT AUTO_INCREMENT PRIMARY KEY,
OrderID INT,
Carrier VARCHAR(100),
TrackingNumber VARCHAR(100),
ShippedDate TIMESTAMP,
EstimatedDeliveryDate TIMESTAMP,
DeliveredDate TIMESTAMP,
Status ENUM('Shipped', 'In Transit', 'Delivered', 'Failed'),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Cart (
CartID INT AUTO_INCREMENT PRIMARY KEY,
CustomerID INT,
ProductID INT,
Quantity INT,
AddedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- INSERT VALUES INTO THE TABLE 

INSERT INTO Users (Name, Email, PasswordHash, Role)
VALUES
('Admin User', 'admin@example.com', 'hashedpassword1', 'Admin'),
('John Doe', 'john.doe@example.com', 'hashedpassword2', 'Customer'),
('Jane Smith', 'jane.smith@example.com', 'hashedpassword3', 'Customer'),
('Alice Brown', 'alice.brown@example.com', 'hashedpassword4', 'Customer'),
('Bob White', 'bob.white@example.com', 'hashedpassword5', 'Customer'),
('Michael Brown', 'michael.brown@example.com', 'hashedpassword4', 'Customer'),
('Sarah Johnson', 'sarah.johnson@example.com', 'hashedpassword5', 'Customer');

INSERT INTO Customers (Name, Email, Phone, Address)
VALUES
('John Doe', 'john.doe@example.com', '1234567890', '123 Elm St, New York'),
('Jane Smith', 'jane.smith@example.com', '0987654321', '456 Oak St, California'),
('Alice Brown', 'alice.brown@example.com', '1122334455', '789 Pine St, Texas'),
('Bob White', 'bob.white@example.com', '5566778899', '159 Maple St, Florida'),
('Michael Brown', 'michael.brown@example.com', '1122334455', '789 Pine St, Texas'),
('Sarah Johnson', 'sarah.johnson@example.com', '6677889900', '321 Birch St, Florida');

INSERT INTO Products (ProductName, Category, Price, Stock, Description, ImageURL)
VALUES
('Laptop', 'Electronics', 1000.00, 20, 'High-performance laptop', 'http://example.com/laptop.jpg'),
('Headphones', 'Accessories', 50.00, 100, 'Noise-cancelling headphones', 'http://example.com/headphones.jpg'),
('Smartphone', 'Electronics', 800.00, 30, 'Latest smartphone model', 'http://example.com/smartphone.jpg'),
('Backpack', 'Accessories', 40.00, 50, 'Stylish and durable backpack', 'http://example.com/backpack.jpg'),
('Gaming Console', 'Electronics', 500.00, 15, 'Next-gen gaming console', 'http://example.com/console.jpg'),
('Wireless Mouse', 'Accessories', 25.00, 200, 'Ergonomic wireless mouse', 'http://example.com/mouse.jpg'),
('Smartwatch', 'Electronics', 300.00, 40, 'Feature-packed smartwatch', 'http://example.com/smartwatch.jpg');

INSERT INTO Orders (CustomerID, TotalAmount, Status, OrderDate)
VALUES
(1, 1050.00, 'Shipped', '2024-12-01'),
(2, 850.00, 'Delivered', '2024-11-28'),
(3, 525.00, 'Delivered', '2024-11-30'),
(4, 325.00, 'Shipped', '2024-12-05');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES
(1, 1, 1, 1000.00),
(1, 2, 1, 50.00),
(2, 3, 1, 800.00),
(2, 4, 1, 40.00),
(3, 5, 1, 500.00),
(3, 6, 1, 25.00),
(4, 7, 1, 300.00);

INSERT INTO Coupons (Code, DiscountPercentage, ExpiryDate, UsageLimit)
VALUES
('WELCOME10', 10.00, '2024-12-31', 100),
('FESTIVE20', 20.00, '2024-12-25', 50),
('HOLIDAY15', 15.00, '2024-12-31', 75);

INSERT INTO OrderCoupons (OrderID, CouponID, DiscountAmount)
VALUES
(1, 1, 100.00),
(2, 2, 170.00),
(3, 3, 78.75);

INSERT INTO ProductReviews (ProductID, CustomerID, Rating, ReviewText)
VALUES
(1, 1, 5, 'Excellent laptop! Highly recommend.'),
(2, 2, 4, 'Great headphones, but a bit pricey.'),
(5, 3, 5, 'Amazing gaming experience!'),
(6, 4, 4, 'Great wireless mouse, very responsive.');

INSERT INTO Shipments (OrderID, Carrier, TrackingNumber, ShippedDate, EstimatedDeliveryDate, DeliveredDate, Status)
VALUES
(1, 'FedEx', 'TRACK123', '2024-12-02', '2024-12-05', NULL, 'In Transit'),
(2, 'UPS', 'TRACK456', '2024-11-29', '2024-12-03', '2024-12-03', 'Delivered'),
(3, 'DHL', 'TRACK789', '2024-12-01', '2024-12-06', '2024-12-06', 'Delivered'),
(4, 'FedEx', 'TRACK101', '2024-12-06', '2024-12-10', NULL, 'In Transit');

INSERT INTO Cart (CustomerID, ProductID, Quantity, AddedDate)
VALUES
(1, 4, 1, '2024-12-10'),
(2, 2, 2, '2024-12-09'),
(3, 7, 1, '2024-12-08'),
(4, 5, 1, '2024-12-09');


#Q1. What are the average prices of products by category, 
#filtered to only show categories with an average price greater than $100?
SELECT Category, AVG(Price)
FROM Products
GROUP BY Category
HAVING AVG(Price) > 100;

#Q2. What are the top 5 best-selling products?
SELECT Products.ProductName, 
       SUM(OrderDetails.Quantity) AS TotalSales
FROM OrderDetails
JOIN Products 
ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalSales DESC
LIMIT 5;

#Q3. Write a trigger that automatically updates 
#the stock of a product when an order is placed.
DELIMITER $$
CREATE TRIGGER update_stock_after_order
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Products
    SET Stock = Stock - NEW.Quantity
    WHERE ProductID = NEW.ProductID;
END$$
DELIMITER ;
#placing order
SELECT ProductID, ProductName, Stock
FROM Products
WHERE ProductID = 1;
#inserting new order item
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES (4, 1, 2, 1000.00);
#checking stock again
SELECT ProductID, ProductName, Stock
FROM Products
WHERE ProductID = 1;

#Q4. Which products have received 5-star reviews?
SELECT 
    p.ProductName,
    pr.Rating,
    pr.ReviewText
FROM ProductReviews pr
JOIN Products p 
ON pr.ProductID = p.ProductID
WHERE pr.Rating = 5;

#Q5. How much discount has been applied to each order?
SELECT 
    o.OrderID,
    oc.DiscountAmount
FROM Orders o
JOIN OrderCoupons oc
ON o.OrderID = oc.OrderID;

#Q6. How many orders were placed each month?
select monthname(OrderDate) as month,
count(OrderID) as TotalOrders from orders 
group by month(OrderDate) , monthname(OrderDate) 
order by month(OrderDate);

#Q7. Which customers have spent the most?
select
Customers.Name,
sum(Orders.TotalAmount) as TotalSpent
from Customers
join Orders
on Customers.CustomerID = Orders.CustomerID
group by Customers.CustomerID, Customers.name
order by TotalSpent 
desc;

#Q8. Create a view that shows all orders along with customer names and order statuses, 
#and how can you query this view to get all 'Shipped' orders?
create view OrderCustomerView as
select 
orders.OrderID,
Customers.Name as CustomerName,
Orders.Status
From orders
join customers
on orders.CustomerId = Customers.CustomerID;
select* from OrderCustomerView
where status='Shipped';

#Q9. What is the average rating and total reviews for each product?
SELECT p.ProductName,
AVG(pr.Rating) AS average_rating,
COUNT(pr.Rating) AS total_reviews
FROM Products p
JOIN ProductReviews pr
ON p.ProductID = pr.ProductID
GROUP BY p.ProductName;

#Q10. How many shipments were handled by each carrier?
SELECT Status,
COUNT(ShipmentID) AS total_shipments
FROM Shipments
GROUP BY Status;

#Q11. Which orders were placed in the year 2024?
SELECT*
FROM Orders
WHERE YEAR(OrderDate) = 2024;

#Q12. How can you rank customers based on their total spending using a window function?
SELECT c.Name,
SUM(o.TotalAmount) AS total_spent,

RANK() OVER (
ORDER BY SUM(o.TotalAmount) DESC
) AS customer_rank

FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID

GROUP BY c.Name;

#Q13. What is the delivery time for each completed order?
SELECT OrderID,
DATEDIFF(DeliveredDate, ShippedDate) AS delivery_days
FROM Shipments
WHERE Status = 'Delivered';

#Q14. How can products be categorized by price range?
SELECT ProductName,
Price,

CASE
    WHEN Price < 100 THEN 'Low Price'

    WHEN Price BETWEEN 100 AND 1000
    THEN 'Medium Price'

    ELSE 'High Price'

END AS price_category

FROM Products;

#Q15. How many unique delivered orders were made by each customer?
SELECT c.Name,
COUNT(DISTINCT o.OrderID) AS delivered_orders

FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID

WHERE o.Status = 'Delivered'

GROUP BY c.Name;