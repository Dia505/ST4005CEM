CREATE DATABASE 13703462_DiaDewan;
USE 13703462_DiaDewan;

CREATE TABLE City (City varchar(15) PRIMARY KEY, Postal_code integer NOT NULL);
SHOW TABLES;
INSERT INTO City VALUES ("Kathmandu",44600),("Lalitpur",44700);

CREATE TABLE Address (Address varchar(10) PRIMARY KEY, City varchar(15), FOREIGN KEY Address(City) REFERENCES City(City) ON UPDATE CASCADE ON DELETE CASCADE);
DESCRIBE Address;
INSERT INTO Address VALUES ("Tinkune","Kathmandu"),("Pulchowk","Lalitpur"),("Gaushala","Kathmandu"),("Chabahil","Kathmandu"),("Thamel","Kathmandu");
ALTER TABLE Address MODIFY COLUMN Address varchar(30);
DESCRIBE Address;

CREATE TABLE Membership_tiers_perks (Tier_ID varchar(4) PRIMARY KEY, Tier varchar(12) NOT NULL UNIQUE, Discount varchar(255) NOT NULL, Product_access varchar(255) NOT NULL);
DESCRIBE Membership_tiers_perks;
INSERT INTO Membership_tiers_perks VALUES ("T101","Platinum","15% off all purchases + exclusive discounts","First access to new products"),("T102","Gold","10% off all purchases","Access to new products after Platinum"),("T103","Silver","5% off all purchases","No exclusive access to new products"),("T104","Non-Member","No exclusive discounts","No exclusive access to new products");
SELECT * FROM Membership_tiers_perks;

CREATE TABLE Customer_details (First_name varchar(15) NOT NULL, Last_name varchar(20) NOT NULL, Email varchar(50) UNIQUE, Phone_number varchar(10) PRIMARY KEY, Address varchar(10) NOT NULL, FOREIGN KEY Customer_details(Address) REFERENCES Address(Address) ON UPDATE CASCADE ON DELETE CASCADE, Tier_ID varchar(4) NOT NULL, FOREIGN KEY Customer_details(Tier_ID) REFERENCES Membership_tiers_perks(Tier_ID) ON UPDATE CASCADE ON DELETE CASCADE);
DESCRIBE Customer_details;
INSERT INTO Address VALUES ("Jhamsikhel","Lalitpur"),("Sanepa","Lalitpur"),("Maitidevi","Kathmandu"),("Jorpati","Kathmandu");
ALTER TABLE Customer_details DROP INDEX Email;
INSERT INTO Customer_details VALUES ("Ram","Sharma","ram.sharma@gmail.com","9841234567","Tinkune","T104"),("Sita","Shrestha","sita.shrestha@gmail.com","9809876543","Pulchowk","T103"),("Hari","Maharjan","hari.maharjan@gmail.com","9867543210","Gaushala","T103"),("Gita","Joshi","gita.joshi@gmail.com","9845678901","Chabahil","T101"),("Raju","Thapa","raju.thapa@gmail.com","9812345678","Thamel","T104"),("Ram","Gurung","ram.gurung@gmail.com","9860554387","Jhamsikhel","T101"),("Sita","Tamang","sita.tamang@gmail.com","9851449832","Sanepa","T102"),("Hari","Sharma"," ","9879006544","Maitidevi","T103"),("Raju","Karki"," ","9841355901","Jorpati","T104");
SELECT * FROM Customer_details;

CREATE TABLE Delivery_information (Delivery_date date PRIMARY KEY, Delivery_time time NOT NULL, Phone_number varchar(10) NOT NULL, FOREIGN KEY Delivery_information(Phone_number) REFERENCES Customer_details(Phone_number) ON UPDATE CASCADE ON DELETE CASCADE);
DESCRIBE Delivery_information;
INSERT INTO City VALUES ("Butwal",32907);
INSERT INTO Address VALUES ("Milanchowk","Butwal"),("Devinagar","Butwal");
INSERT INTO Customer_details VALUES ("Amit","Khanal","amit.khanal@gmail.com","9869345678","Milanchowk","T102"),("Rita","Dhakal","rita.dhakal@gmail.com","9841799554","Devinagar","T102"),("Simran","KC"," ","9809803045","Milanchowk","T103");
SELECT * FROM Customer_details;
INSERT INTO Delivery_information VALUES ("2023-03-24","10:00","9869345678"),("2023-03-25","14:00","9841799554"),("2023-03-26","16:00","9809803045");
SELECT * FROM Delivery_information;
ALTER TABLE Delivery_information DROP PRIMARY KEY;
DESCRIBE Delivery_information;

CREATE TABLE Category (Category_ID varchar(3) PRIMARY KEY, Category_name varchar(25) NOT NULL);
DESCRIBE Category;
INSERT INTO Category VALUES ("001","One-Piece Garment"),("002","Two-Piece Garment"),("003","Three-Piece Garment");
SELECT * FROM Category;
ALTER TABLE Category MODIFY COLUMN Category_name varchar(25) NOT NULL UNIQUE;
ALTER TABLE Category MODIFY COLUMN Category_ID varchar(4);
UPDATE Category SET Category_ID = "C001" WHERE Category_name = "One-Piece Garment";
UPDATE Category SET Category_ID = "C002" WHERE Category_name = "Two-Piece Garment";
UPDATE Category SET Category_ID = "C003" WHERE Category_name = "Three-Piece Garment";
SELECT * FROM Category;

CREATE TABLE Brand (Brand_ID varchar(4) PRIMARY KEY, Brand_name varchar(10) NOT NULL UNIQUE);
DESCRIBE Brand;
INSERT INTO Brand VALUES ("B001","ABC"),("B002","PQR"),("B003","XYZ");
SELECT * FROM Brand;

CREATE TABLE Products (Product_ID varchar(4) PRIMARY KEY, Product_name varchar(25) NOT NULL UNIQUE, Description varchar(255), Price float NOT NULL, Category_ID varchar(4) NOT NULL, FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID) ON UPDATE CASCADE ON DELETE CASCADE, Brand_ID varchar(4) NOT NULL, FOREIGN KEY (Brand_ID) REFERENCES Brand(Brand_ID) ON UPDATE CASCADE ON DELETE CASCADE);
DESCRIBE Products;
INSERT INTO Products VALUES ("P001","Sari","A long, unstitched garment draped around the body",15000.00,"C001","B001"),("P002","Kurta","Long tunic paired with loose-fitting pants",4000.00,"C002","B003"),("P003","Lehenga Choli","A long skirt, a fitted blouse and a dupatta",20000.00,"C003","B001"),("P004","Sherwani","A long coat-like garment with fitted pants for men",4500.00,"C002","B003"),("P005","Anarkali","A flowing, floor-length tunic with fitted pants",12000.00,"C002","B002"),("P006","Salwar Kameez","A long tunic top paired with loose-fitting pants and a dupatta",4000.00,"C003","B002"),("P007","Ghagra Choli","A long, flared skirt, a blouse and a dupatta",21000.00,"C003","B003"),("P008","Dupatta","A long scarf",2000.00,"C001","B002"),("P009","Indo-Western gown","A long gown dress",7000.00,"C001","B001");
SELECT * FROM Products;

CREATE TABLE Sales (Date date PRIMARY KEY, Product_ID varchar(4) NOT NULL, FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON UPDATE CASCADE ON DELETE CASCADE, Quantity int NOT NULL, Total_sales float NOT NULL, Salesperson varchar(50) NOT NULL, Customer_phNumber varchar(10) NOT NULL, FOREIGN KEY (Customer_phNumber) REFERENCES Customer_details(Phone_number) ON UPDATE CASCADE ON DELETE CASCADE);
DESCRIBE Sales;
INSERT INTO Sales VALUES ("2022-03-21","P001",10,150000.00,"Ambika Lamichhane","9860554387"),("2022-03-22","P002",5,20000.00,"Aashma Regmi","9841234567"),("2022-03-23","P003",8,160000.00,"Sarah Ghimire","9869345678"),("2022-03-24","P004",3,13500.00,"Ambika Lamichhane","9869345678"),("2022-03-25","P005",6,72000.00,"Subhadra Thapa","9851449832"),("2022-03-26","P006",4,16000.00,"Sarah Ghimire","9841355901"),("2022-03-27","P007",7,147000.00,"Subhadra Thapa","9867543210"),("2022-03-28","P008",12,24000.00,"Pooja Manandhar","9867543210"),("2022-03-29","P009",2,14000.00,"Subhadra Thapa","9845678901");
SELECT * FROM Sales;

CREATE TABLE Suppliers (Supplier_ID varchar(4) PRIMARY KEY, Supplier_address varchar(15) NOT NULL, Contact_number varchar(10) NOT NULL UNIQUE);
DESCRIBE Suppliers;
INSERT INTO Suppliers VALUES ("S001","Kathmandu","9860123456"), ("S002","Lalitpur","9844234567"),("S003","Bhaktapur","9849223069");
SELECT * FROM Suppliers;
ALTER TABLE Suppliers MODIFY COLUMN Supplier_address value(30);
DESCRIBE Suppliers;

CREATE TABLE Purchase_orders (PO_number varchar(5) PRIMARY KEY, Product_ID varchar(4) NOT NULL, FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON UPDATE CASCADE ON DELETE CASCADE, Quantity int NOT NULL, Cost_price float NOT NULL, Order_date date NOT NULL, Supplier_ID varchar(4) NOT NULL, FOREIGN KEY (Supplier_ID) REFERENCES Suppliers(Supplier_ID) ON UPDATE CASCADE ON DELETE CASCADE);
DESCRIBE Purchase_orders;
INSERT INTO Purchase_orders VALUES ("PO1","P001",10,7500.00,"2023-03-01","S001"),("PO2","P002",5,1500.00,"2023-03-15","S002"),("PO3","P003",8,13000.00,"2023-03-20","S003");
SELECT * FROM Purchase_orders;

ALTER TABLE Membership_tiers_perks ADD COLUMN Criteria varchar(255) NOT NULL;
SELECT * FROM Membership_tiers_perks;
ALTER TABLE Membership_tiers_perks RENAME COLUMN Product_access TO Stock_clearance_access;
SELECT * FROM Membership_tiers_perks;

UPDATE Membership_tiers_perks SET Criteria = "Purchase of Rs.100,000 or more in 5 weeks" WHERE Tier_ID = "T101";
SELECT * FROM Membership_tiers_perks;
UPDATE Membership_tiers_perks SET Criteria = "Purchase of Rs.50,000 or more in 5 weeks" WHERE Tier_ID = "T102";
UPDATE Membership_tiers_perks SET Criteria = "Purchase of Rs.20,000 or more in 5 weeks" WHERE Tier_ID = "T103";
UPDATE Membership_tiers_perks SET Criteria = "Purchase of less than Rs.20,000" WHERE Tier_ID = "T104";
SELECT * FROM Membership_tiers_perks;

UPDATE Membership_tiers_perks SET Stock_clearance_access = "Earliest" WHERE Tier_ID = "T101";
UPDATE Membership_tiers_perks SET Stock_clearance_access = "A week after Platinum" WHERE Tier_ID = "T102";
UPDATE Membership_tiers_perks SET Stock_clearance_access = "No access permitted" WHERE Tier_ID = "T103";
UPDATE Membership_tiers_perks SET Stock_clearance_access = "No access permitted" WHERE Tier_ID = "T104";
SELECT * FROM Membership_tiers_perks;
DESCRIBE Membership_tiers_perks;

ALTER TABLE Membership_tiers_perks ADD COLUMN Exchange_policy varchar(100) NOT NULL;
UPDATE Membership_tiers_perks SET Exchange_policy = "15 day exchange period" WHERE Tier_ID = "T101";
UPDATE Membership_tiers_perks SET Exchange_policy = "7 day exchange period" WHERE Tier_ID = "T102";
UPDATE Membership_tiers_perks SET Exchange_policy = "no exchange" WHERE Tier_ID = "T103";
UPDATE Membership_tiers_perks SET Exchange_policy = "no exchange" WHERE Tier_ID = "T104";
SELEct * FROM Membership_tiers_perks;

ALTER TABLE Sales ADD COLUMN Time time NOT NULL;
SELECT * FROM Sales;
UPDATE Sales SET Time = "09:30" WHERE Date = "2022-03-21";
UPDATE Sales SET Time = "11:20" WHERE Date = "2022-03-22";
UPDATE Sales SET Time = "12:00" WHERE Date = "2022-03-23";
UPDATE Sales SET Time = "12:40" WHERE Date = "2022-03-24";
UPDATE Sales SET Time = "12:55" WHERE Date = "2022-03-25";
UPDATE Sales SET Time = "14:30" WHERE Date = "2022-03-26";
UPDATE Sales SET Time = "16:45" WHERE Date = "2022-03-27";
UPDATE Sales SET Time = "16:00" WHERE Date = "2022-03-28";
UPDATE Sales SET Time = "18:30" WHERE Date = "2022-03-29";
SELECT * FROM Sales;

INSERT INTO Sales VALUES ("2023-02-12","P004",2,9000.00,"Pooja Manandhar","9812345678","10:45"),("2023-02-13","P001",6,90000.00,"Subhadra Thapa","9841799554","14:10"),("2023-02-14","P009",4,28000.00,"Aashma Regmi","9809803045","17:30"),("2023-02-15","P006",8,32000.00,"Pooja Manandhar","9841234567","10:30");
SELECT * FROM Sales;
INSERT INTO Sales VALUES ("2023-03-23","P005",5,60000.00,"Pooja Manandhar","9869345678","11:55"),("2023-03-24","P001",2,30000.00,"Ambika Lamichhane","9879006544","15:15"),("2023-03-25","P007",2,42000.00,"Ambika Lamichhane","9841799554","10:00"),("2023-03-26","P002",5,20000,"Sarah Ghimire","9809803045","10:30"),("2023-03-27","P009",3,21000.00,"Pooja Manandhar","9879006544","18:45");
SELECT * FROM Sales;

ALTER TABLE Sales DROP PRIMARY KEY;
DESCRIBE Sales;
ALTER TABLE Sales ADD COLUMN Sales_ID varchar(5) NOT NULL;
DESCRIBE Sales;
UPDATE Sales SET Sales_ID = "SL1" WHERE Date = "2022-03-21";
UPDATE Sales SET Sales_ID = "SL2" WHERE Date = "2022-03-22";
UPDATE Sales SET Sales_ID = "SL3" WHERE Date = "2022-03-23";
UPDATE Sales SET Sales_ID = "SL4" WHERE Date = "2022-03-24";
UPDATE Sales SET Sales_ID = "SL5" WHERE Date = "2022-03-25";
UPDATE Sales SET Sales_ID = "SL6" WHERE Date = "2022-03-26";
UPDATE Sales SET Sales_ID = "SL7" WHERE Date = "2022-03-27";
UPDATE Sales SET Sales_ID = "SL8" WHERE Date = "2022-03-28";
UPDATE Sales SET Sales_ID = "SL9" WHERE Date = "2022-03-29";
UPDATE Sales SET Sales_ID = "SL10" WHERE Date = "2023-02-12";
UPDATE Sales SET Sales_ID = "SL11" WHERE Date = "2023-02-13";
UPDATE Sales SET Sales_ID = "SL12" WHERE Date = "2023-02-14";
UPDATE Sales SET Sales_ID = "SL13" WHERE Date = "2023-02-15";
UPDATE Sales SET Sales_ID = "SL14" WHERE Date = "2023-03-23";
UPDATE Sales SET Sales_ID = "SL15" WHERE Date = "2023-03-24";
UPDATE Sales SET Sales_ID = "SL16" WHERE Date = "2023-03-25";
UPDATE Sales SET Sales_ID = "SL17" WHERE Date = "2023-03-26";
UPDATE Sales SET Sales_ID = "SL18" WHERE Date = "2023-03-27";

ALTER TABLE Sales ADD PRIMARY KEY (Sales_ID);
DESCRIBE Sales;

UPDATE Sales SET Sales_ID = "SL30" WHERE Date = "2023-03-24";
UPDATE Sales SET Sales_ID = "SL31" WHERE Date = "2023-03-25";
UPDATE Sales SET Sales_ID = "SL32" WHERE Date = "2023-03-26";
UPDATE Sales SET Sales_ID = "SL33" WHERE Date = "2023-03-27";

INSERT INTO Sales VALUES ("2023-03-23","P003",1,20000.00,"Sarah Ghimire","9841355901","13:00","SL15");
INSERT INTO Sales VALUES ("2023-03-23","P004",3,13500.00,"Sarah Ghimire","9841799554","17:20","SL16");

UPDATE Sales SET Sales_ID = "SL17" WHERE Date = "2023-03-24";
INSERT INTO Sales VALUES ("2023-03-24","P007",1,21000.00,"Aashma Regmi","9812345678","16:30","SL18");
INSERT INTO Sales VALUES ("2023-03-24","P007",1,21000.00,"Subhadra Thapa","9809876543","16:45","SL19");
INSERT INTO Sales VALUES ("2023-03-24","P008",4,8000.00,"Subhadra Thapa","9809803045","17:30","SL20");

UPDATE Sales SET Sales_ID = "SL21" WHERE Date = "2023-03-25";
INSERT INTO Sales VALUES ("2023-03-25","P004",4,18000.00,"Sarah Ghimire","9809876543","14:35","SL22");

UPDATE Sales SET Sales_ID = "SL23" WHERE Date = "2023-03-26";
INSERT INTO Sales VALUES ("2023-03-26","P009",1,7000.00,"Aashma Regmi","9812345678","11:35","SL24");

UPDATE Sales SET Sales_ID = "SL25" WHERE Date = "2023-03-27";
INSERT INTO Sales VALUES ("2023-03-27","P005",2,24000.00,"Ambika Lamichhane","9860554387","17:00","SL26");
INSERT INTO Sales VALUES ("2023-03-27","P006",5,20000.00,"Aashma Regmi","9845678901","18:45","SL27");

SELECT * FROM Sales ORDER BY Date;

/* Suppose, presently, the date is 2023-03-27, Thursday */
/* Query to retrieve orders made last week */
SELECT * FROM purchase_orders WHERE Order_date >= "2023-03-16" AND Order_date <= "2023-03-22";

/* Query to count total number of Saris sold in the last month */
SELECT COUNT(Quantity) FROM Sales WHERE Date >= "2023-02-01" AND Date <= "2023-02-28" AND Product_ID = "P001";

/* Query to count number of sales made by Pooja Manandhar */
SELECT COUNT(Date) FROM Sales WHERE Salesperson = "Pooja Manandhar";

/* Query to retrieve name of customers who have made a purchase of more than Rs. 50000 */
/* HAVING clause because grouped rows are involved */
SELECT DISTINCT First_name,Last_name FROM Customer_details RIGHT JOIN Sales ON Customer_details.Phone_number = Sales.Customer_phNumber GROUP BY First_name, Last_name HAVING SUM(Total_sales) > 50000.00;

/* Query to count number of customers who have made a purchase between 6-7 pm */
SELECT COUNT(Customer_phNumber) FROM Sales WHERE Time > "18:00" AND Time < "19:00";

/* Query to count total number of sales made this week */
SELECT SUM(Total_sales) FROM Sales WHERE Date >= "2023-03-23" AND Date <= "2023-03-27";
/* Query to retrieve top 10 best selling products */
SELECT Product_name, SUM(Total_sales) FROM Products RIGHT JOIN Sales ON Products.Product_ID = Sales.Product_ID WHERE Date >= "2023-03-23" AND Date <= "2023-03-27" GROUP BY Product_name ORDER BY SUM(Total_sales) DESC;

/* Query to retrieve average transaction value of each day of the week */
SELECT AVG(Total_sales) FROM Sales WHERE Date = "2023-03-23";
SELECT AVG(Total_sales) FROM Sales WHERE Date = "2023-03-24";
SELECT AVG(Total_sales) FROM Sales WHERE Date = "2023-03-25";
SELECT AVG(Total_sales) FROM Sales WHERE Date = "2023-03-26";
SELECT AVG(Total_sales) FROM Sales WHERE Date = "2023-03-27";

/* Query to delete records older than a year */
DELETE FROM Sales WHERE Date <= "2023-01-01";
