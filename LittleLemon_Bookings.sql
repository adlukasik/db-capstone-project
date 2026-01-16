USE LittleLemonDB;


REPLACE INTO Bookings (BookingID, Date, TableNumber, CustomerID) VALUES
(1, '2022-10-10', 5, 1),
(2, '2022-11-12', 3, 3),
(3, '2022-10-11', 2, 2),
(4, '2022-10-13', 2, 1);


SELECT * FROM Bookings;

DROP PROCEDURE IF EXISTS CheckBooking;

DELIMITER //

CREATE PROCEDURE CheckBooking(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE bookedTable INT DEFAULT 0;
    
    
    SELECT COUNT(bookedTable) INTO bookedTable
    FROM Bookings 
    WHERE Date = booking_date AND TableNumber = table_number;
    
    
    IF bookedTable > 0 THEN
        SELECT CONCAT('Table ', table_number, ' is already booked') AS 'Booking status';
    ELSE
        SELECT CONCAT('Table ', table_number, ' is available') AS 'Booking status';
    END IF;
END //

DELIMITER ;

CALL CheckBooking('2022-11-12', 3);

DROP PROCEDURE IF EXISTS AddValidBooking;

DELIMITER //

CREATE PROCEDURE AddValidBooking(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE booking_count INT DEFAULT 0;
    
    START TRANSACTION;
    
    
    SELECT COUNT(*) INTO booking_count
    FROM Bookings 
    WHERE Date = booking_date AND TableNumber = table_number;
    
    
    INSERT INTO Bookings (Date, TableNumber, CustomerID) 
    VALUES (booking_date, table_number, 1);
    
    
    IF booking_count > 0 THEN
        
        ROLLBACK;
        SELECT CONCAT('Table ', table_number, ' is already booked - booking cancelled') AS 'Booking status';
    ELSE
        
        COMMIT;
        SELECT 'Booking committed' AS 'Booking status';
    END IF;
    
END //

DELIMITER ;

CALL AddValidBooking('2022-10-10', 5);

DROP PROCEDURE IF EXISTS AddBooking;
DROP PROCEDURE IF EXISTS UpdateBooking;
DROP PROCEDURE IF EXISTS CancelBooking;

DELIMITER //

CREATE PROCEDURE AddBooking(IN customer_id INT, IN booking_date DATE, IN table_number INT)
BEGIN
    INSERT INTO Bookings (CustomerID, Date, TableNumber)
    VALUES (customer_id, booking_date, table_number);
    
    SELECT 'New booking added' AS Confirmation;
END //

CREATE PROCEDURE UpdateBooking(IN booking_id INT, IN booking_date DATE)
BEGIN
    UPDATE Bookings 
    SET Date = booking_date 
    WHERE BookingID = booking_id;
    
    SELECT CONCAT('Booking ', booking_id, ' updated') AS Confirmation;
END //


CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN
    DELETE FROM Bookings 
    WHERE BookingID = booking_id;
    
    SELECT CONCAT('Booking ', booking_id, ' cancelled') AS Confirmation;
END //

DELIMITER ;



CALL AddBooking(2, "2022-12-30", 4);

CALL UpdateBooking(6, "2022-12-17");
CALL CancelBooking(6);





