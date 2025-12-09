-- ===========================================
-- SparrowTech Database - Sample Data
-- ===========================================

-- -------------------
-- Location Data
-- -------------------
INSERT INTO Location (state, city, revenue, street_address) VALUES
('CA', 'Los Angeles', 2500000, '123 Main St'),
('TX', 'Austin', 1800000, '456 Tech Blvd'),
('NY', 'New York', 3200000, '789 Broadway Ave'),
('WA', 'Seattle', 2100000, '321 Pine St'),
('FL', 'Miami', 1500000, '654 Ocean Dr');

-- -------------------
-- Employee Data
-- -------------------
INSERT INTO Employee (salary, hourly, name, position, location_id) VALUES
(85000, NULL, 'John Smith', 'Manager', 1),
(NULL, 25, 'Sarah Johnson', 'Sales Associate', 1),
(95000, NULL, 'Michael Chen', 'Manager', 2),
(NULL, 22, 'Emily Davis', 'Technician', 2),
(75000, NULL, 'Robert Wilson', 'Lead Technician', 3),
(NULL, 20, 'Jessica Brown', 'Sales Associate', 3),
(120000, NULL, 'David Lee', 'Regional Manager', 4),
(NULL, 28, 'Lisa Garcia', 'Senior Technician', 4),
(NULL, 18, 'Kevin Martinez', 'Sales Associate', 5),
(65000, NULL, 'Amanda Taylor', 'Store Supervisor', 5);

-- -------------------
-- Component Data (Base Table)
-- -------------------
INSERT INTO Component (price) VALUES
-- CPUs (IDs 1-4)
(599.99),
(399.99),
(249.99),
(799.99),
-- GPUs (IDs 5-8)
(1499.99),
(899.99),
(599.99),
(349.99),
-- RAM (IDs 9-12)
(129.99),
(89.99),
(179.99),
(59.99),
-- Displays (IDs 13-16)
(299.99),
(199.99),
(399.99),
(249.99);

-- -------------------
-- CPU Data
-- -------------------
INSERT INTO CPU (component_id, model, cores, threads, clock) VALUES
(1, 'Intel Core i9-13900K', 24, 32, '3.0 GHz base, 5.8 GHz boost'),
(2, 'AMD Ryzen 7 7700X', 8, 16, '4.5 GHz base, 5.4 GHz boost'),
(3, 'Intel Core i5-13600K', 14, 20, '3.5 GHz base, 5.1 GHz boost'),
(4, 'AMD Ryzen 9 7950X', 16, 32, '4.5 GHz base, 5.7 GHz boost');

-- -------------------
-- GPU Data
-- -------------------
INSERT INTO GPU (component_id, vram, model, clock) VALUES
(5, 24, 'NVIDIA RTX 4090', '2230 MHz base, 2520 MHz boost'),
(6, 16, 'NVIDIA RTX 4080', '2210 MHz base, 2510 MHz boost'),
(7, 12, 'NVIDIA RTX 4070 Ti', '2310 MHz base, 2610 MHz boost'),
(8, 8, 'AMD Radeon RX 7600', '1720 MHz base, 2655 MHz boost');

-- -------------------
-- RAM Data
-- -------------------
INSERT INTO RAM (component_id, size, type) VALUES
(9, 32, 'DDR5-6000'),
(10, 16, 'DDR5-5600'),
(11, 64, 'DDR5-6400'),
(12, 8, 'DDR4-3200');

-- -------------------
-- Display Data
-- -------------------
INSERT INTO Display (component_id, panel_type, resolution) VALUES
(13, 'IPS', '1920x1080'),
(14, 'TN', '1920x1080'),
(15, 'OLED', '2560x1440'),
(16, 'IPS', '2560x1440');

-- -------------------
-- Computer Data
-- -------------------
INSERT INTO Computer (price, employee_id, location_id) VALUES
(3499.99, 1, 1),
(2299.99, 4, 2),
(1899.99, 5, 3),
(4999.99, 8, 4),
(1499.99, 10, 5),
(2799.99, 1, 1),
(3999.99, 3, 2),
(1299.99, 5, 3);

-- -------------------
-- ComputerComponent (Junction Table)
-- -------------------
INSERT INTO ComputerComponent (computer_id, component_id) VALUES
-- Computer 1 (High-end gaming PC)
(1, 1), -- Intel i9
(1, 5), -- RTX 4090
(1, 9), -- 32GB DDR5
(1, 15), -- OLED display
-- Computer 2 (Mid-range workstation)
(2, 2), -- Ryzen 7
(2, 6), -- RTX 4080
(2, 10), -- 16GB DDR5
(2, 13), -- IPS display
-- Computer 3 (Budget gaming PC)
(3, 3), -- Intel i5
(3, 7), -- RTX 4070 Ti
(3, 10), -- 16GB DDR5
(3, 14), -- TN display
-- Computer 4 (Ultimate workstation)
(4, 4), -- Ryzen 9
(4, 5), -- RTX 4090
(4, 11), -- 64GB DDR5
(4, 15), -- OLED display
-- Computer 5 (Entry-level PC)
(5, 3), -- Intel i5
(5, 8), -- RX 7600
(5, 12), -- 8GB DDR4
(5, 14), -- TN display
-- Computer 6
(6, 2), -- Ryzen 7
(6, 6), -- RTX 4080
(6, 9), -- 32GB DDR5
(6, 16), -- IPS 1440p
-- Computer 7
(7, 1), -- Intel i9
(7, 5), -- RTX 4090
(7, 9), -- 32GB DDR5
(7, 15), -- OLED display
-- Computer 8
(8, 3), -- Intel i5
(8, 8), -- RX 7600
(8, 12), -- 8GB DDR4
(8, 14); -- TN display

-- -------------------
-- Item Data (Base Table)
-- -------------------
INSERT INTO Item (price) VALUES
-- Monitors (IDs 1-4)
(599.99),
(399.99),
(799.99),
(299.99),
-- Mice (IDs 5-8)
(149.99),
(79.99),
(49.99),
(29.99),
-- Keyboards (IDs 9-12)
(199.99),
(129.99),
(89.99),
(49.99),
-- Accessories (IDs 13-16)
(19.99),
(29.99),
(39.99),
(14.99);

-- -------------------
-- Monitor Data
-- -------------------
INSERT INTO Monitor (item_id, model, size) VALUES
(1, 'Dell UltraSharp U2723DE', 27),
(2, 'ASUS TUF Gaming VG27AQ', 27),
(3, 'LG 34WN80C-B UltraWide', 34),
(4, 'BenQ GW2485TC', 24);

-- -------------------
-- Mouse Data
-- -------------------
INSERT INTO Mouse (item_id, resolution, model) VALUES
(5, 25600, 'Logitech G Pro X Superlight'),
(6, 16000, 'Razer DeathAdder V3'),
(7, 8000, 'SteelSeries Rival 3'),
(8, 3200, 'Logitech M705');

-- -------------------
-- Keyboard Data
-- -------------------
INSERT INTO Keyboard (item_id, model) VALUES
(9, 'Corsair K100 RGB'),
(10, 'Razer Huntsman V2'),
(11, 'Keychron K2'),
(12, 'Logitech K380');

-- -------------------
-- Accessory Data
-- -------------------
INSERT INTO Accessory (item_id, price) VALUES
(13, 19.99), -- Mouse pad
(14, 29.99), -- USB Hub
(15, 39.99), -- Webcam stand
(16, 14.99); -- Cable management

-- ------------------

-- -------------------
-- Government Customer Data
-- -------------------
INSERT INTO Government (customer_id, agency, liason) VALUES
(1, 'Department of Defense', 'Colonel James Mitchell'),
(2, 'NASA', 'Dr. Sarah Thompson'),
(3, 'Department of Education', 'Mary Johnson'),
(4, 'FBI', 'Agent Robert Anderson'),
(5, 'EPA', 'Jennifer Davis');

-- -------------------
-- Private Customer Data
-- -------------------
INSERT INTO Private (customer_id, payment_mode, last_name, first_name) VALUES
(6, 'Credit Card', 'Williams', 'Michael'),
(7, 'PayPal', 'Brown', 'Jennifer'),
(8, 'Debit Card', 'Garcia', 'Carlos'),
(9, 'Cash', 'Kim', 'David'),
(10, 'Credit Card', 'Patel', 'Priya');

-- -------------------
-- Purchase Data
-- -------------------

INSERT INTO Purchase (customer_id, purchase_date) VALUES
(1, '2024-01-15'),
(6, '2024-01-20'),
(2, '2024-02-05'),
(7, '2024-02-14'),
(3, '2024-02-28'),
(8, '2024-03-10'),
(4, '2024-03-22'),
(9, '2024-04-01'),
(5, '2024-04-15'),
(10, '2024-04-20'),
(6, '2024-05-05'),
(7, '2024-05-18');

-- -------------------
-- Inventory Data
-- -------------------

INSERT INTO Inventory (item_id, computer_id, purchase_id) VALUES
(NULL, 1, 1),
(NULL, 4, 3),
(NULL, 2, 5),
(NULL, 7, 7),
(NULL, 6, 9),

(NULL, 3, 2),
(1, NULL, 2),
(5, NULL, 2), 
(NULL, 5, 4),
(2, NULL, 6),
(6, NULL, 6),
(10, NULL, 6),
(NULL, 8, 8),
(4, NULL, 10),
(7, NULL, 10),
(11, NULL, 10),
(13, NULL, 11),
(14, NULL, 11),
(9, NULL, 12),
(8, NULL, 12);