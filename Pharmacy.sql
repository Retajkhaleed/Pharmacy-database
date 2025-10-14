CREATE  SCHEMA if not exists  Pharmacy;
USE pharmacy;

CREATE TABLE IF NOT EXISTS Pharmacy(
PharmacyID INT PRIMARY KEY,
PharmacyName  VARCHAR(225),
Address VARCHAR(225),
Phone VARCHAR(15),
Email VARCHAR(100),
LicenseNumber VARCHAR(50),
OpeningHours VARCHAR(100)
);
INSERT INTO Pharmacy (PharmacyID,PharmacyName,Address,Phone,Email,LicenseNumber,OpeningHours)
VALUES	(1,'Nahdi Pharmacy','123 st, Makkah','111-2345','nahdi@gmail.com','abc1122','24\7');
INSERT INTO Pharmacy (PharmacyID,PharmacyName,Address,Phone,Email,LicenseNumber,OpeningHours)
VALUES	(2,'Nahdi Pharmacy','111 st, Jeddah','098-8576','nahdi@gmail.com','abc1122','24\7');
INSERT INTO Pharmacy (PharmacyID,PharmacyName,Address,Phone,Email,LicenseNumber,OpeningHours)
VALUES	(3,'Nahdi Pharmacy','432 st, Taif','260-7245','nahdi@gmail.com','abc1122','24\7');
INSERT INTO Pharmacy (PharmacyID,PharmacyName,Address,Phone,Email,LicenseNumber,OpeningHours)
VALUES	(4,'Nahdi Pharmacy','565 st, riyadh','073-6932','nahdi@gmail.com','abc1122','24\7');
INSERT INTO Pharmacy (PharmacyID,PharmacyName,Address,Phone,Email,LicenseNumber,OpeningHours)
VALUES	(5,'Nahdi Pharmacy','342 st, madinah','713-0684','nahdi@gmail.com','abc1122','24\7');
INSERT INTO Pharmacy (PharmacyID,PharmacyName,Address,Phone,Email,LicenseNumber,OpeningHours)
VALUES	(6,'Nahdi Pharmacy','355 st, madinah','791-0426','nahdi@gmail.com','abc1122','24\7');

UPDATE Pharmacy
SET Phone='111-2245'
WHERE PharmacyID=1;

DELETE FROM pharmacy
WHERE PharmacyID=6;

SELECT * FROM Pharmacy
ORDER BY PharmacyID ASC;

CREATE TABLE IF NOT EXISTS Medications (
    MedicationID INT PRIMARY KEY,
    MedicationName VARCHAR(225) NOT NULL,
    Brand VARCHAR(100),
    Price DECIMAL(10,2) NOT NULL,
    QuantityInStock INT NOT NULL,
    ExpiryDate DATE,
    PharmacyID INT,
    FOREIGN KEY (PharmacyID) REFERENCES Pharmacy(PharmacyID)
);
INSERT INTO Medications (MedicationID, MedicationName, Brand, Price, QuantityInStock, ExpiryDate, PharmacyID)
VALUES 
    (1, 'Paracetamol', 'Panadol', 5.50, 100, '2026-12-31', 1),
    (2, 'Ibuprofen', 'Advil', 8.75, 50, '2025-11-30', 2),
    (3, 'Cough Syrup', 'Benylin', 12.00, 25, '2025-10-15', 3),
    (4, 'Amoxicillin', 'Moxatag', 18.90, 200, '2026-01-20', 4),
    (5, 'Antihistamine', 'Zyrtec', 10.00, 150, '2024-09-15', 5),
   (6, 'prozac', 'Eli Lilly', 100.00, 100, '2024-10-11', 5) ;

UPDATE Medications
SET Price =Price* 6.00
WHERE MedicationID = 1;

DELETE FROM Medications
WHERE QuantityInStock < 30;

SELECT PharmacyID, COUNT(*) AS MedicationCount
FROM Medications
GROUP BY PharmacyID;

SELECT * FROM Medications;


CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15),
    Address VARCHAR(200),
    RegistrationDate DATE
);

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, PhoneNumber, Address, RegistrationDate) 
VALUES 
(1, 'Lana', 'Alotaibi', 'lana.alotaibi@gmail.com', '0599565670', 'Mecca, Saudi Arabia', '2025-01-01'),
(2, 'Ahmed', 'Ali', 'ahmed.ali@gmail.com', '0595773200', 'Jeddah, Saudi Arabia', '2025-01-02'),
(3, 'Noura', 'Salem', 'noura.salem@gmail.com', '0505221055', 'Dammam, Saudi Arabia', '2025-01-03'),
(4, 'Hassan', 'Omar', 'hassan.omar@gmail.com', '0571436366', 'Riyadh, Saudi Arabia', '2025-01-04'),
(5, 'Maha', 'Khalid', 'maha.khalid@gmail.com', '0504432808', 'Medina, Saudi Arabia', '2025-01-05');

UPDATE Customers
SET PhoneNumber = '0599880101'
WHERE CustomerID = 1;

DELETE FROM Customers
WHERE Email = 'hassan.omar@gmail.com';

SELECT * FROM Customers;

CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    PharmacyID INT,
    MedicationID INT,
    OrderDate DATETIME,
    OrderStatus VARCHAR(50),
    PrescriptionRequired BOOLEAN,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (PharmacyID) REFERENCES Pharmacy(PharmacyID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);

INSERT INTO Orders (OrderID, CustomerID, PharmacyID, MedicationID, OrderDate, OrderStatus, PrescriptionRequired)
VALUES  (1, 3, 1,4 ,'2025-01-17 12:59:00', 'Pending', FALSE),
       (2, 3, 5,2 ,'2024-12-24 17:45:20', 'Completed', FALSE),
       (3, 2, 2, 1,'2025-01-12 3:25:56', 'Cancelled',FALSE),
       (4, 2, 2,6 ,'2025-01-13 14:32:00', 'Completed',TRUE),
       (5, 1, 1,4 ,'2024-11-30 21:17:47', 'Pending', FALSE),
	   (6, 5, 3,2 ,'2025-01-8 18:34:00', 'Completed', FALSE),
	   (7, 3, 4,5 ,'2025-01-15 10:23:42', 'Pending', FALSE),
       (8, 2, 1,6 ,'2025-01-2 20:59:34', 'Pending', TRUE);

UPDATE Orders 
SET OrderStatus = 'Completed'
WHERE OrderID = 7;

UPDATE Orders 
SET OrderStatus = 'Cancelled'
WHERE OrderID = 8; 

UPDATE Orders 
SET OrderStatus = 'Cancelled'
WHERE OrderID = 5;

UPDATE Orders 
SET OrderStatus = 'Completed'
WHERE OrderID = 1;

DELETE FROM Orders
WHERE OrderID = 8;
 
SELECT * FROM Orders
WHERE OrderStatus = 'Completed';
       
SELECT PharmacyID, COUNT(OrderID) AS NumberOfOrders
FROM Orders
GROUP BY PharmacyID;

SELECT PharmacyID, COUNT(OrderID) AS NumberOfOrders
FROM Orders
GROUP BY PharmacyID
HAVING COUNT(OrderID) > 1;

SELECT * FROM Orders
ORDER BY OrderDate DESC;

SELECT Orders.OrderID, Customers.FirstName, Customers.LastName, Pharmacy.PharmacyName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN Pharmacy ON Orders.PharmacyID = Pharmacy.PharmacyID;

CREATE TABLE IF NOT EXISTS Payment (
    PaymentID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    CustomerID INT NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    CHECK (PaymentMethod IN ('Cash', 'Credit Card')),
    AmountPaid DECIMAL(10, 2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentStatus VARCHAR(50),
    CHECK (PaymentStatus IN ('Completed', 'Pending', 'Refunded')),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Payment (PaymentID, OrderID, CustomerID, PaymentMethod, AmountPaid, PaymentDate, PaymentStatus)
VALUES
    (1, 1, 3, 'Credit Card', 250.50, '2025-01-15', 'Completed'),
    (2, 2, 3, 'Cash', 120.00, '2025-01-16', 'Pending'),
    (3, 3, 2, 'Credit Card', 300.75, '2025-01-17', 'Completed'),
    (4, 4, 2, 'Credit Card', 75.00, '2025-01-17', 'Refunded'),
    (5, 5, 1, 'Cash', 50.00, '2025-01-18', 'Completed');

UPDATE Payment
SET PaymentStatus = 'Completed'
WHERE PaymentID = 2;

DELETE FROM Payment
WHERE PaymentStatus = 'Refunded';

SELECT * FROM Payment;

SELECT * FROM Payment WHERE PaymentStatus = 'Completed';

SELECT * FROM Payment ORDER BY PaymentDate DESC;

SELECT PaymentMethod, SUM(AmountPaid) AS TotalAmount
FROM Payment
GROUP BY PaymentMethod;

SELECT PaymentMethod, COUNT(*) AS PaymentCount
FROM Payment
GROUP BY PaymentMethod
HAVING PaymentCount > 1;

SELECT *
FROM Payment
WHERE AmountPaid = (
    SELECT MAX(AmountPaid)
    FROM Payment
);


CREATE TABLE IF NOT EXISTS Have (
    PharmacyID INT NOT NULL,
    MedicationID INT NOT NULL,
    StockQuantity INT NOT NULL,
    PRIMARY KEY (PharmacyID, MedicationID),
    FOREIGN KEY (PharmacyID) REFERENCES Pharmacy(PharmacyID) ON DELETE CASCADE,
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID) ON DELETE CASCADE
);

INSERT INTO Have (PharmacyID, MedicationID, StockQuantity)
VALUES 
    (1, 1, 100), 
    (1, 2, 50),  
    (2, 4, 30),  
    (3, 4, 200), 
    (4, 5, 150), 
    (5, 6, 75);

SELECT p.PharmacyName, m.MedicationName, h.StockQuantity
FROM Have h
JOIN Pharmacy p ON h.PharmacyID = p.PharmacyID
JOIN Medications m ON h.MedicationID = m.MedicationID;

SELECT m.MedicationName, h.StockQuantity
FROM Have h
JOIN Medications m ON h.MedicationID = m.MedicationID
WHERE h.PharmacyID = 1;

SELECT p.PharmacyName, h.StockQuantity
FROM Have h
JOIN Pharmacy p ON h.PharmacyID = p.PharmacyID
WHERE h.MedicationID = 4;

SELECT m.MedicationName, SUM(h.StockQuantity) AS TotalStock
FROM Have h
JOIN Medications m ON h.MedicationID = m.MedicationID
WHERE m.MedicationID = 1
GROUP BY m.MedicationName;
