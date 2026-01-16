USE LittleLemonDB;

SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE Orders;
TRUNCATE TABLE Bookings;
TRUNCATE TABLE Menu;
TRUNCATE TABLE Customers;
TRUNCATE TABLE Staff;
SET FOREIGN_KEY_CHECKS=1;

-- Wstawiamy dane do tabeli Menu 
INSERT INTO Menu (MenuID, ItemName, Type, Price) VALUES
(1, 'Olives','Starters', 5),
(2, 'Flatbread','Starters', 5),
(3, 'Minestrone', 'Starters', 8),
(4, 'Tomato Bread','Starters', 8),
(5, 'Falafel', 'Starters', 7),
(6, 'Hummus', 'Starters', 5),
(7, 'Greek Salad', 'Main Courses', 15),
(8, 'Bean Soup', 'Main Courses', 12),
(9, 'Pizza', 'Main Courses', 15),
(10, 'Greek Yoghurt','Desserts', 7),
(11, 'Ice cream', 'Desserts', 6),
(12, 'Cheesecake', 'Desserts', 4),
(13, 'Athens White wine', 'Drinks', 25),
(14, 'Corfu Red Wine', 'Drinks', 30),
(15, 'Turkish Coffee', 'Drinks', 10),
(16, 'Kabasa', 'Main Courses', 17);

-- Klienci 
INSERT INTO Customers (CustomerID, FullName, ContactNumber, Email) VALUES
(1, 'Vanessa McCarthy', '111111', 'vanessa@example.com'),
(2, 'Marcos Romero', '222222', 'marcos@example.com'),
(3, 'Hiroki Yamane', '333333', 'hiroki@example.com'),
(4, 'Anna Iversen', '444444', 'anna@example.com'),
(5, 'Diana Pinto', '555555', 'diana@example.com');

-- Rezerwacje 
INSERT INTO Bookings (BookingID, Date, TableNumber, CustomerID) VALUES
(1, '2022-10-10', 5, 1),
(2, '2022-11-12', 3, 3),
(3, '2022-10-11', 2, 2),
(4, '2022-10-13', 2, 1);

-- Pracownicy
INSERT INTO Staff (StaffID, FullName, Role, Salary) VALUES
(1, 'Mario Gollini', 'Manager', 70000),
(2, 'Adrian Gollini', 'Assistant Manager', 65000),
(3, 'Giorgos Dioudis', 'Head Chef', 50000),
(4, 'Fatma Phillips', 'Assistant Chef', 45000),
(5, 'Eleanor Zweig', 'Head Waiter', 40000);

-- Zamowienia
INSERT INTO Orders (OrderID, OrderDate, Quantity, TotalCost, BookingID, MenuID, StaffID) VALUES
(1, '2022-10-10', 5, 250, 1, 1, 5), -- StaffID=5 (Kelner)
(2, '2022-11-12', 1, 40, 2, 3, 5),
(3, '2022-10-11', 1, 40, 3, 5, 5),
(4, '2022-10-13', 3, 200, 4, 1, 5),
(5, '2022-10-10', 1, 100, 1, 4, 5);

CREATE VIEW OrdersView AS
SELECT OrderID, Quantity, TotalCost
FROM Orders
WHERE Quantity > 2;

Select * from OrdersView;

SELECT 
    c.CustomerID, 
    c.FullName, 
    o.OrderID, 
    o.TotalCost, 
    m.ItemName, 
    m.Type 
FROM Customers c
INNER JOIN Bookings b ON c.CustomerID = b.CustomerID
INNER JOIN Orders o ON b.BookingID = o.BookingID
INNER JOIN Menu m ON o.MenuID = m.MenuID
WHERE o.TotalCost > 150
ORDER BY o.TotalCost ASC;

SELECT ItemName 
FROM Menu 
WHERE MenuID = ANY (
    SELECT MenuID 
    FROM Orders 
    WHERE Quantity > 2
);

DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(Quantity) AS "Max Quantity in Order" 
    FROM Orders;
END //

DELIMITER ;

CALL GetMaxQuantity();

PREPARE GetOrderDetail FROM 
'SELECT OrderID, Quantity, TotalCost 
 FROM Orders 
 JOIN Bookings ON Orders.BookingID = Bookings.BookingID 
 WHERE Bookings.CustomerID = ?';
 
 SET @id = 1;
 
 EXECUTE GetOrderDetail USING @id;
 
 
 DELIMITER //

CREATE PROCEDURE CancelOrder(IN target_order_id INT)
BEGIN
    -- Usuwamy zamówienie
    DELETE FROM Orders WHERE OrderID = target_order_id;
    
    -- Wyświetlamy potwierdzenie
    SELECT CONCAT('Order ', target_order_id, ' is cancelled') AS Confirmation;
END //

DELIMITER ;

CALL CancelOrder(5);




