
-- SparrowTech Database Schema
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Inventory; 
DROP TABLE IF EXISTS Purchase; 
DROP TABLE IF EXISTS Government; 
DROP TABLE IF EXISTS Private; 
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS ComputerComponent;
DROP TABLE IF EXISTS Computer; 
DROP TABLE IF EXISTS CPU;
DROP TABLE IF EXISTS GPU; 
DROP TABLE IF EXISTS RAM; 
DROP TABLE IF EXISTS Display; 
DROP TABLE IF EXISTS Component; 
DROP TABLE IF EXISTS Employee; 
DROP TABLE IF EXISTS Location; 
DROP TABLE IF EXISTS Item; 
DROP TABLE IF EXISTS Monitor;
DROP TABLE IF EXISTS Mouse; 
DROP TABLE IF EXISTS Keyboard; 

SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE Location (
    location_id     INT PRIMARY KEY,
    state           CHAR(2),
    city            VARCHAR(50),
    revenue         INT,
    street_address  VARCHAR(100)
);

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    salary      INT,
    hourly      INT,
    name        VARCHAR(50),
    position    VARCHAR(20),
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

CREATE TABLE Component (
    component_id INT PRIMARY KEY,
    price        DECIMAL(10,2),
    cost         DECIMAL(10,2)
);

-- Component Subtypes

-- CPU 
CREATE TABLE CPU (
    component_id INT PRIMARY KEY,
    model        VARCHAR(50),
    cores        INT,
    threads      INT,
    clock        VARCHAR(50),
    FOREIGN KEY (component_id) REFERENCES Component(component_id)
);

-- GPU
CREATE TABLE GPU (
    component_id INT PRIMARY KEY,
    vram         INT,
    model        VARCHAR(50),
    clock        VARCHAR(50),
    FOREIGN KEY (component_id) REFERENCES Component(component_id)
);

-- RAM
CREATE TABLE RAM (
    component_id INT PRIMARY KEY,
    size         INT,
    type         VARCHAR(50),
    FOREIGN KEY (component_id) REFERENCES Component(component_id)
);

-- Display (internal
CREATE TABLE Display (
    component_id INT PRIMARY KEY,
    panel_type   VARCHAR(50),
    resolution   VARCHAR(50),
    FOREIGN KEY (component_id) REFERENCES Component(component_id)
);

-- Computer
CREATE TABLE Computer (
    computer_id INT PRIMARY KEY,
    price       DECIMAL(10,2),
    base_cost   DECIMAL(10,2),
    employee_id INT,
    location_id INT,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);


-- ComputerComponent (junction)
CREATE TABLE ComputerComponent (
    computer_id  INT,
    component_id INT,
    PRIMARY KEY (computer_id, component_id),
    FOREIGN KEY (computer_id) REFERENCES Computer(computer_id),
    FOREIGN KEY (component_id) REFERENCES Component(component_id)
);

CREATE TABLE Item (
    item_id INT PRIMARY KEY,
    price   DECIMAL(10,2),
    cost    DECIMAL(10,2)
);


-- Item Subtypes
-- Monitor 
CREATE TABLE Monitor (
    item_id INT PRIMARY KEY,
    model   VARCHAR(100),
    size    INT,
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

-- Mouse
CREATE TABLE Mouse (
    item_id    INT PRIMARY KEY,
    resolution INT,
    model      VARCHAR(100),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

-- Keyboard
CREATE TABLE Keyboard (
    item_id INT PRIMARY KEY,
    model   VARCHAR(100),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY
);

-- Customer Subtypes
-- Government customer
CREATE TABLE Government (
    customer_id INT PRIMARY KEY,
    agency      VARCHAR(50),
    liason      VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Private customer
CREATE TABLE Private (
    customer_id   INT PRIMARY KEY,
    payment_mode  VARCHAR(20),
    last_name     VARCHAR(30),
    first_name    VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Purchase
CREATE TABLE Purchase (
    purchase_id   INT PRIMARY KEY,
    customer_id   INT,
    purchase_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Inventory
CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY,
    item_id      INT,
    computer_id  INT,
    purchase_id  INT,
    component_id INT,
    date_stocked DATE,
    FOREIGN KEY (item_id) REFERENCES Item(item_id),
    FOREIGN KEY (computer_id) REFERENCES Computer(computer_id),
    FOREIGN KEY (purchase_id) REFERENCES Purchase(purchase_id),
    FOREIGN KEY (component_id) REFERENCES Component(component_id)
);

-- =========================

-- LOCATIONS
INSERT INTO Location (location_id, state, city, revenue, street_address) VALUES
(1, 'CA', 'San Jose', 2500000, '100 Silicon Ave'),
(2, 'TX', 'Austin', 1800000, '200 Tech Blvd'),
(3, 'VA', 'Arlington', 3100000, '50 Defense Way'),
(4, 'WA', 'Seattle', 2200000, '88 Cloud Pkwy');

-- EMPLOYEES
INSERT INTO Employee (employee_id, salary, hourly, name, position, location_id) VALUES
(1, 95000, NULL, 'Alice Johnson', 'Manager', 1),
(2, 72000, NULL, 'Brian Chen', 'Technician', 1),
(3, 81000, NULL, 'Carla Gomez', 'Sales', 2),
(4, 65000, NULL, 'David Patel', 'Assembler', 2),
(5, 110000, NULL, 'Evelyn Park', 'Manager', 3),
(6, NULL, 32, 'Frank Miller', 'Support', 3),
(7, NULL, 28, 'Grace Lee', 'Sales', 4);


-- COMPONENTS 
INSERT INTO Component (component_id, price, cost) VALUES
(1001, 299.99, 180.00),(1002, 499.99, 320.00),(1003, 899.99, 610.00),
(1004, 129.99, 85.00),(1005, 159.99,105.00),(1006, 799.99,560.00),
(1007, 249.99,170.00),(1008, 179.99,120.00),(1009, 229.99,150.00),
(1010, 399.99,280.00),(1011, 299.99,210.00),(1012, 1099.99,780.00),
(8001,75000.00,60000.00),(8002,65000.00,52000.00),
(8003,40000.00,30000.00),(8004,90000.00,70000.00),
(8005,120000.00,95000.00);

-- CPU
INSERT INTO CPU VALUES
(1001,'Intel i5-13600K',14,20,'3.5GHz'),
(1002,'Intel i7-13700K',16,24,'3.4GHz'),
(1003,'AMD Ryzen 9 7950X',16,32,'4.5GHz'),
(8001,'Xeon Ultra 128-Core',128,256,'5.2GHz'),
(8002,'Threadripper Pro X',96,192,'5.0GHz');

-- GPU
INSERT INTO GPU VALUES
(1006,8,'RTX 4060','2.5GHz'),
(1007,12,'RTX 4070','2.6GHz'),
(1012,24,'RTX 4090','2.0GHz'),
(8003,96,'RTX Titan AI','2.8GHz'),
(8004,144,'A1000 Data Center GPU','3.2GHz'),
(8005,192,'Quantum Acceleration Module','4.0GHz');

-- RAM
INSERT INTO RAM VALUES
(1004,16,'DDR5'),
(1005,32,'DDR5'),
(1010,64,'DDR5');

-- DISPLAY
INSERT INTO Display VALUES
(1008,'IPS','1920x1080'),
(1011,'OLED','2560x1440');

-- COMPUTERS
INSERT INTO Computer (computer_id, price, base_cost, employee_id, location_id) VALUES
(9001,149999.99,110000.00,1,1),
(9002,129999.99,95000.00,2,1),
(9003, 99999.99,72000.00,3,2),
(9004,199999.99,150000.00,5,1),
(9005,249999.99,180000.00,5,3),
(5001,1799.99,1200.00,1,1),
(5002,1499.99,1050.00,2,1),
(5003,2499.99,1750.00,5,3),
(5004,2999.99,2150.00,7,4);

-- COMPUTER COMPONENTS
INSERT INTO ComputerComponent (computer_id, component_id) VALUES
(9001,8001),(9001,8003),(9001,8004),
(9002,8002),(9002,8003),
(9003,8001),(9003,8005),
(9004,8004),(9004,8005),
(9005,8002),(9005,8003),(9005,8004),(9005,8005),
(5001,1001),(5001,1006),(5001,1004),
(5002,1002),(5002,1007),(5002,1005),
(5003,1003),(5003,1012),(5003,1010),
(5004,1001),(5004,1006),(5004,1004);

-- ITEMS
INSERT INTO Item VALUES
(2001,299.99,210.00),(2002,79.99,55.00),(2003,129.99,85.00),
(2004,499.99,380.00),(2005,59.99,40.00),(2006,39.99,25.00);

-- MONITORS
INSERT INTO Monitor VALUES
(2001,'Dell UltraSharp U2723QE',27),
(2004,'Samsung Odyssey G9',49);

-- MICE
INSERT INTO Mouse VALUES
(2002,16000,'Logitech G Pro X'),
(2005,12000,'Razer DeathAdder V3');

-- KEYBOARDS
INSERT INTO Keyboard VALUES
(2003,'Keychron K10 Pro'),
(2006,'Logitech MX Keys');

-- CUSTOMERS
INSERT INTO Customer VALUES
(3001),(3002),(3003),(3004),(3005),(3006),(3007),(3008),(3009),(3010),(3011);

INSERT INTO Government VALUES
(3001,'Department of Defense','Lt. Sarah Williams'),
(3002,'Homeland Security','James Carter'),
(3003,'NASA','Dr. Michael Ross'),
(3004,'FBI','Special Agent Turner'),
(3009,'NSA','Director Paul Reed'),
(3010,'CIA','Director Anne Cole'),
(3011,'Department of Energy','Dr. Steven Yu');

-- PRIVATE CUSTOMERS
INSERT INTO Private VALUES
(3005,'Credit Card','Doe','John'),
(3006,'Debit Card','Smith','Jane'),
(3007,'PayPal','Brown','Chris'),
(3008,'Credit Card','Wilson','Taylor');

-- PURCHASES
INSERT INTO Purchase (purchase_id, customer_id, purchase_date) VALUES
-- 2024 Q1
(6001,3001,'2024-01-02'),(6002,3002,'2024-01-03'),(6003,3003,'2024-01-05'),
(6004,3004,'2024-01-08'),(6005,3009,'2024-01-10'),(6006,3010,'2024-01-12'),
(6007,3011,'2024-01-15'),(6008,3001,'2024-01-18'),(6009,3002,'2024-01-20'),
(6010,3003,'2024-01-25'),

(6011,3004,'2024-02-01'),(6012,3009,'2024-02-03'),(6013,3010,'2024-02-07'),
(6014,3011,'2024-02-10'),(6015,3001,'2024-02-14'),(6016,3002,'2024-02-18'),

(6017,3003,'2024-03-01'),(6018,3004,'2024-03-05'),(6019,3009,'2024-03-09'),
(6020,3010,'2024-03-15'),

-- 2024 Q2
(6021,3011,'2024-04-02'),(6022,3001,'2024-04-05'),(6023,3002,'2024-04-10'),
(6024,3003,'2024-04-15'),(6025,3004,'2024-04-20'),(6026,3009,'2024-04-25'),

(6027,3010,'2024-05-03'),(6028,3011,'2024-05-08'),(6029,3001,'2024-05-12'),
(6030,3002,'2024-05-17'),

(6031,3003,'2024-06-02'),(6032,3004,'2024-06-06'),(6033,3009,'2024-06-10'),
(6034,3010,'2024-06-15'),

-- 2024 Q3
(6035,3011,'2024-07-02'),(6036,3001,'2024-07-08'),(6037,3002,'2024-07-15'),
(6038,3003,'2024-07-20'),(6039,3004,'2024-07-25'),(6040,3009,'2024-07-29'),

(6041,3010,'2024-08-03'),(6042,3011,'2024-08-07'),(6043,3001,'2024-08-12'),
(6044,3002,'2024-08-18'),

(6045,3003,'2024-09-01'),(6046,3004,'2024-09-06'),(6047,3009,'2024-09-10'),
(6048,3010,'2024-09-14'),

-- 2024 Q4
(6049,3011,'2024-10-03'),(6050,3001,'2024-10-06'),(6051,3002,'2024-10-09'),
(6052,3003,'2024-10-13'),(6053,3004,'2024-10-16'),(6054,3009,'2024-10-20'),

(6055,3010,'2024-11-03'),(6056,3011,'2024-11-09'),(6057,3001,'2024-11-15'),
(6058,3002,'2024-11-20'),

(6059,3003,'2024-12-02'),(6060,3004,'2024-12-07'),(6061,3009,'2024-12-12'),
(6062,3010,'2024-12-18'),

-- 2025 Q1
(6063,3011,'2025-01-05'),(6064,3001,'2025-01-09'),(6065,3002,'2025-01-13'),
(6066,3003,'2025-01-18'),(6067,3004,'2025-01-22'),(6068,3009,'2025-01-25'),
(6069,3010,'2025-02-03'),(6070,3011,'2025-02-07'),(6071,3001,'2025-02-12'),
(6072,3002,'2025-02-17'),(6073,3003,'2025-02-21'),(6074,3004,'2025-03-05'),
(6075,3009,'2025-03-12'),(6076,3010,'2025-03-18');


INSERT INTO Inventory (inventory_id, item_id, computer_id, purchase_id, component_id, date_stocked) VALUES
(90001, NULL, 9001, 6001, NULL,'2024-01-03'),
(90002, NULL, 9002, 6002, NULL,'2024-01-04'),
(90003, NULL, 9003, 6003, NULL,'2024-01-06'),
(90004, NULL, 9004, 6004, NULL,'2024-01-09'),
(90005, NULL, 9005, 6005, NULL,'2024-01-11'),

(90006,2001, NULL, 6006, NULL,'2024-01-13'),
(90007,2002, NULL, 6007, NULL,'2024-01-16'),
(90008,NULL, NULL, 6008,1001,'2024-01-19'),
(90009,NULL, NULL, 6009,1002,'2024-01-21'),
(90010,2003,NULL, 6010,NULL,'2024-01-26'),

(90011,NULL,5001,6011,NULL,'2024-02-02'),
(90012,NULL,5002,6012,NULL,'2024-02-04'),
(90013,NULL,5003,6013,NULL,'2024-02-08'),
(90014,NULL,5004,6014,NULL,'2024-02-11'),

(90015,NULL, NULL,6015,1003,'2024-02-15'),
(90016,2004,NULL, 6016,NULL,'2024-02-19'),
(90017,2005,NULL, 6017,NULL,'2024-03-02'),
(90018,NULL, NULL,6018,1004,'2024-03-06'),
(90019,NULL, NULL,6019,1005,'2024-03-10'),
(90020,NULL, NULL,6020,1006,'2024-03-16'),

(90021,NULL,5001,6021,NULL,'2024-04-03'),
(90022,NULL,5002,6022,NULL,'2024-04-06'),
(90023,NULL,5003,6023,NULL,'2024-04-11'),
(90024,NULL,5004,6024,NULL,'2024-04-16'),

(90025,2006,NULL,6025,NULL,'2024-04-21'),
(90026,NULL,NULL,6026,1007,'2024-04-26'),
(90027,NULL,NULL,6027,1008,'2024-05-04'),
(90028,NULL,NULL,6028,1009,'2024-05-09'),
(90029,NULL,5001,6029,NULL,'2024-05-13'),
(90030,NULL,5002,6030,NULL,'2024-05-18'),

(90031,NULL,NULL,6031,1010,'2024-06-03'),
(90032,NULL,NULL,6032,1011,'2024-06-07'),
(90033,NULL,NULL,6033,1012,'2024-06-11'),
(90034,NULL,NULL,6034,1001,'2024-06-16'),

(90035,NULL,9001,6035,NULL,'2024-07-03'),
(90036,NULL,9002,6036,NULL,'2024-07-09'),
(90037,NULL,9003,6037,NULL,'2024-07-16'),
(90038,NULL,9004,6038,NULL,'2024-07-21'),

(90039,2001,NULL,6039,NULL,'2024-07-26'),
(90040,NULL,NULL,6040,1002,'2024-07-30'),
(90041,NULL,NULL,6041,1003,'2024-08-04'),
(90042,NULL,NULL,6042,1004,'2024-08-08'),

(90043,NULL,9005,6043,NULL,'2024-08-13'),
(90044,NULL,5003,6044,NULL,'2024-08-19'),
(90045,NULL,5002,6045,NULL,'2024-09-02'),
(90046,2002,NULL,6046,NULL,'2024-09-07'),

(90047,NULL,NULL,6047,1005,'2024-09-11'),
(90048,NULL,NULL,6048,1006,'2024-09-15'),

(90049,NULL,9004,6049,NULL,'2024-10-04'),
(90050,NULL,9002,6050,NULL,'2024-10-07'),
(90051,NULL,9001,6051,NULL,'2024-10-10'),
(90052,NULL,5001,6052,NULL,'2024-10-14'),

(90053,2003,NULL,6053,NULL,'2024-10-17'),
(90054,NULL,NULL,6054,1007,'2024-10-21'),
(90055,NULL,NULL,6055,1008,'2024-11-04'),
(90056,NULL,NULL,6056,1009,'2024-11-10'),

(90057,NULL,5004,6057,NULL,'2024-11-16'),
(90058,NULL,5003,6058,NULL,'2024-11-21'),
(90059,2004,NULL,6059,NULL,'2024-12-03'),
(90060,NULL,NULL,6060,1010,'2024-12-08'),

(90061,NULL,NULL,6061,1011,'2024-12-13'),
(90062,NULL,NULL,6062,1012,'2024-12-19'),

(90063,NULL,9005,6063,NULL,'2025-01-06'),
(90064,NULL,9001,6064,NULL,'2025-01-10'),
(90065,NULL,9002,6065,NULL,'2025-01-14'),
(90066,NULL,NULL,6066,1001,'2025-01-19'),

(90067,2005,NULL,6067,NULL,'2025-01-23'),
(90068,NULL,NULL,6068,1002,'2025-01-26'),
(90069,NULL,NULL,6069,1003,'2025-02-04'),
(90070,NULL,5001,6070,NULL,'2025-02-08'),

(90071,NULL,5002,6071,NULL,'2025-02-13'),
(90072,2006,NULL,6072,NULL,'2025-02-18'),
(90073,NULL,NULL,6073,1004,'2025-02-22'),
(90074,NULL,NULL,6074,1005,'2025-03-06'),
(90075,NULL,9003,6075,NULL,'2025-03-13'),
(90076,NULL,9004,6076,NULL,'2025-03-19');
