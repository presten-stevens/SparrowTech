-- ===========================================
-- SparrowTech Database Schema
-- ===========================================

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
    price        DECIMAL(7,2),
    cost         DECIMAL(7,2)
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
    price       DECIMAL(7,2),
    base_cost   DECIMAL(7,2),
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
    price   DECIMAL(7,2),
    cost    DECIMAL(7,2)
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
    date_stocked DATE,
    FOREIGN KEY (item_id) REFERENCES Item(item_id),
    FOREIGN KEY (computer_id) REFERENCES Computer(computer_id),
    FOREIGN KEY (purchase_id) REFERENCES Purchase(purchase_id)
);


-- INSERT
INSERT INTO Location (location_id, state, city, revenue, street_address) VALUES
(1, 'CA', 'San Jose', 2350000, '123 Silicon Ave'),
(2, 'TX', 'Austin', 1450000, '45 Tech Park Rd'),
(3, 'NY', 'New York', 3200000, '9 Broadway'),
(4, 'WA', 'Seattle', 1850000, '77 Cloud St'),
(5, 'IL', 'Chicago', 1250000, '600 W Loop Blvd');

-- Employees
INSERT INTO Employee (employee_id, salary, hourly, name, position, location_id) VALUES
(1, 95000, NULL, 'Alice Johnson', 'Manager', 1),
(2, 72000, NULL, 'Brian Chen', 'Technician', 1),
(3, 68000, NULL, 'Carla Gomez', 'Sales', 2),
(4, 55000, NULL, 'David Patel', 'Assembler', 2),
(5, 105000, NULL, 'Evelyn Park', 'Manager', 3),
(6, NULL, 32, 'Frank Miller', 'Support', 3),
(7, NULL, 28, 'Grace Lee', 'Sales', 4),
(8, 63000, NULL, 'Henry Davis', 'Technician', 5);

-- -------------------
-- Components
-- -------------------
INSERT INTO Component (component_id, price, cost) VALUES
(1001, 349.99, 220.00),
(1002, 499.99, 320.00),
(1003, 899.99, 610.00),
(1004, 129.99, 85.00),
(1005, 159.99, 105.00),
(1006, 799.99, 560.00),
(1007, 229.99, 160.00),
(1008, 179.99, 125.00),
(1009, 249.99, 175.00),
(1010, 299.99, 210.00),
(1011, 399.99, 280.00),
(1012, 1099.99, 780.00);

INSERT INTO CPU (component_id, model, cores, threads, clock) VALUES
(1001, 'Intel i5-13600K', 14, 20, '3.5GHz'),
(1002, 'Intel i7-13700K', 16, 24, '3.4GHz'),
(1003, 'AMD Ryzen 9 7950X', 16, 32, '4.5GHz');

INSERT INTO GPU (component_id, vram, model, clock) VALUES
(1006, 8, 'NVIDIA RTX 4060', '2.5GHz'),
(1007, 12, 'NVIDIA RTX 4070', '2.6GHz'),
(1012, 24, 'NVIDIA RTX 4090', '2.0GHz'),
(1009, 8, 'AMD Radeon RX 7800 XT', '2.4GHz');

INSERT INTO RAM (component_id, size, type) VALUES
(1004, 16, 'DDR5'),
(1005, 32, 'DDR5'),
(1010, 64, 'DDR5');

INSERT INTO Display (component_id, panel_type, resolution) VALUES
(1011, 'IPS', '1920x1080'),
(1008, 'OLED', '2560x1440');

INSERT INTO Computer (computer_id, price, base_cost, employee_id, location_id) VALUES
(5001, 1899.99, 1300.00, 1, 1),
(5002, 1499.99, 1020.00, 2, 1),
(5003, 2399.99, 1700.00, 3, 2),
(5004, 2999.99, 2100.00, 5, 3),
(5005, 1299.99, 900.00, 7, 4);

INSERT INTO ComputerComponent (computer_id, component_id) VALUES
(5001,1001),(5001,1006),(5001,1005),(5001,1011),
(5002,1002),(5002,1007),(5002,1004),(5002,1008),
(5003,1003),(5003,1012),(5003,1010),(5003,1011),
(5004,1003),(5004,1012),(5004,1010),(5004,1011),
(5005,1001),(5005,1009),(5005,1004),(5005,1008);

INSERT INTO Item (item_id, price, cost) VALUES
(2001, 299.99, 210.00),
(2002, 79.99, 55.00),
(2003, 129.99, 90.00),
(2004, 499.99, 375.00),
(2005, 999.99, 780.00),
(2006, 59.99, 40.00),
(2007, 39.99, 25.00);

INSERT INTO Monitor (item_id, model, size) VALUES
(2001, 'Dell UltraSharp U2723QE', 27),
(2004, 'Samsung Odyssey G9', 49),
(2005, 'LG UltraFine 5K', 27);

INSERT INTO Mouse (item_id, resolution, model) VALUES
(2002, 16000, 'Logitech G Pro X'),
(2006, 12000, 'Razer DeathAdder V3');

INSERT INTO Keyboard (item_id, model) VALUES
(2003, 'Keychron K10 Pro'),
(2007, 'Logitech MX Keys');

INSERT INTO Customer (customer_id) VALUES
(3001),(3002),(3003),(3004),(3005),(3006);

INSERT INTO Government (customer_id, agency, liason) VALUES
(3001, 'Department of Defense', 'Lt. Sarah Williams'),
(3004, 'NASA', 'Dr. Michael Ross');

INSERT INTO Private (customer_id, payment_mode, last_name, first_name) VALUES
(3002, 'Credit Card', 'Doe', 'John'),
(3003, 'Debit Card', 'Smith', 'Jane'),
(3005, 'PayPal', 'Brown', 'Chris'),
(3006, 'Credit Card', 'Wilson', 'Taylor');

INSERT INTO Purchase (purchase_id, customer_id, purchase_date) VALUES
(4001, 3001, '2023-12-15'),
(4002, 3002, '2024-01-10'),
(4003, 3003, '2024-02-05'),
(4004, 3004, '2024-03-12'),
(4005, 3005, '2024-04-18'),
(4006, 3006, '2024-06-22'),
(4007, 3002, '2024-08-30'),
(4008, 3003, '2024-10-11'),
(4009, 3004, '2025-01-05'),
(4010, 3005, '2025-03-14');

INSERT INTO Inventory (inventory_id, item_id, computer_id, purchase_id, date_stocked) VALUES
(6001, 2001, NULL, 4002, '2024-01-09'),
(6002, 2002, NULL, 4002, '2024-01-09'),
(6003, 2003, NULL, 4003, '2024-02-04'),
(6004, 2004, NULL, 4004, '2024-03-11'),
(6005, 2006, NULL, 4005, '2024-04-17'),
(6006, NULL, 5001, 4001, '2023-12-14'),
(6007, NULL, 5002, 4006, '2024-06-20'),
(6008, NULL, 5003, 4007, '2024-08-29'),
(6009, NULL, 5004, 4008, '2024-10-10'),
(6010, NULL, 5005, 4009, '2025-01-04'),
(6011, 2007, NULL, 4010, '2025-03-13');
