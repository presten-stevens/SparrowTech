-- ===========================================
-- SparrowTech Database Schema (Full SQL File)
-- ===========================================

-- -------------------
-- Location
-- -------------------
CREATE TABLE Location (
    location_id     INT PRIMARY KEY,
    state           CHAR(2),
    city            VARCHAR(50),
    revenue         INT,
    street_address  VARCHAR(100)
);

-- -------------------
-- Employee
-- -------------------
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    salary      INT,
    hourly      INT,
    name        VARCHAR(50),
    position    VARCHAR(20),
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

-- -------------------
-- Component (Supertype)
-- -------------------
CREATE TABLE Component (
    component_id INT PRIMARY KEY,
    price        DECIMAL(7,2)
);

-- -------------------
-- Component Subtypes
-- -------------------

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

-- Display (internal)
CREATE TABLE Display (
    component_id INT PRIMARY KEY,
    panel_type   VARCHAR(50),
    resolution   VARCHAR(50),
    FOREIGN KEY (component_id) REFERENCES Component(component_id)
);

-- -------------------
-- Computer
-- -------------------
CREATE TABLE Computer (
    computer_id INT PRIMARY KEY,
    price       DECIMAL(7,2),
    employee_id INT,
    location_id INT,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

-- -------------------
-- ComputerComponent (junction)
-- -------------------
CREATE TABLE ComputerComponent (
    computer_id  INT,
    component_id INT,
    PRIMARY KEY (computer_id, component_id),
    FOREIGN KEY (computer_id) REFERENCES Computer(computer_id),
    FOREIGN KEY (component_id) REFERENCES Component(component_id)
);

-- -------------------
-- Item (supertype for retail products)
-- -------------------
CREATE TABLE Item (
    item_id INT PRIMARY KEY,
    price   DECIMAL(7,2)
);

-- -------------------
-- Item Subtypes
-- -------------------

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

-- Accessory
CREATE TABLE Accessory (
    item_id INT PRIMARY KEY,
    price   DECIMAL(5,2),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

-- -------------------
-- Customer (Supertype)
-- -------------------
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY
);

-- -------------------
-- Customer Subtypes
-- -------------------

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

-- -------------------
-- Purchase
-- -------------------
CREATE TABLE Purchase (
    purchase_id   INT PRIMARY KEY,
    customer_id   INT,
    purchase_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- -------------------
-- Inventory (tracks physical stock)
-- -------------------
CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY,
    item_id      INT,
    computer_id  INT,
    purchase_id  INT,
    FOREIGN KEY (item_id) REFERENCES Item(item_id),
    FOREIGN KEY (computer_id) REFERENCES Computer(computer_id),
    FOREIGN KEY (purchase_id) REFERENCES Purchase(purchase_id)
);
