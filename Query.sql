-- ===========================================
-- SparrowTech Database Queries
-- ===========================================

-- -------------------------------------------
-- 1.) Top-selling computers - Which builds are most popular
-- -------------------------------------------
-- Shows computers ranked by number of units sold
SELECT  c.computer_id, c.price, c.base_cost, 
    (c.price - c.base_cost) AS profit_per_unit, COUNT(i.inventory_id) AS units_sold,
    SUM(c.price) AS total_revenue
FROM Computer c
JOIN Inventory i ON c.computer_id = i.computer_id
WHERE i.purchase_id IS NOT NULL
GROUP BY c.computer_id, c.price, c.base_cost
ORDER BY units_sold DESC;

-- -------------------------------------------
-- 2.) Highest profit margin items/computers - Best markup products
-- -------------------------------------------
-- Computers by profit margin
SELECT 'Computer' AS product_type, computer_id AS product_id, price,
    base_cost AS cost, (price - base_cost) AS profit,
    ROUND(((price - base_cost) / base_cost) * 100, 2) AS margin_percent
FROM Computer
ORDER BY margin_percent DESC;

-- -------------------------------------------
-- 3.) Computers built per employee - Productivity tracking
-- -------------------------------------------
SELECT e.employee_id,e.name, e.position, l.city AS location,
    COUNT(c.computer_id) AS computers_built
FROM Employee e
LEFT JOIN Computer c ON e.employee_id = c.employee_id
LEFT JOIN Location l ON e.location_id = l.location_id
GROUP BY e.employee_id, e.name, e.position, l.city
ORDER BY computers_built DESC;