-- Get the average cost per quarter
SELECT 
    YEAR(inv.date_stocked) as year,
    QUARTER(inv.date_stocked) as quarter,
    SUM(
        COALESCE(i.cost, 0) +
        COALESCE(c.base_cost, 0) +
        COALESCE(com.cost, 0)
    ) AS total_cost
FROM Inventory inv
LEFT JOIN Item i ON inv.item_id = i.item_id
LEFT JOIN Computer c ON inv.computer_id = c.computer_id
LEFT JOIN Component com on inv.component_id = com.component_id
GROUP BY quarter, year
ORDER BY year,quarter;

-- Get the average income
SELECT 
    YEAR(p.purchase_date) as year,
    QUARTER(p.purchase_date) as quarter,
    SUM(
        COALESCE(i.price, 0) +
        COALESCE(c.price, 0) +
        COALESCE(com.price, 0)
    ) AS total_income
FROM Purchase p
JOIN inventory inv on p.purchase_id = inv.purchase_id
LEFT JOIN Item i ON inv.item_id = i.item_id
LEFT JOIN Computer c ON inv.computer_id = c.computer_id
LEFT JOIN Component com on inv.component_id = com.component_id
GROUP BY quarter, year
ORDER BY year,quarter;

-- get the totall revenue 
SELECT 
    YEAR(p.purchase_date) as year,
    QUARTER(p.purchase_date) as quarter,
    SUM(
        COALESCE(i.price, 0) +
        COALESCE(c.price, 0) +
        COALESCE(com.price, 0)
    ) - SUM(
        COALESCE(i.cost, 0) +
        COALESCE(c.base_cost, 0) +
        COALESCE(com.cost, 0)
    )
   AS profit
FROM Purchase p
JOIN inventory inv on p.purchase_id = inv.purchase_id
LEFT JOIN Item i ON inv.item_id = i.item_id
LEFT JOIN Computer c ON inv.computer_id = c.computer_id
LEFT JOIN Component com on inv.component_id = com.component_id
GROUP BY quarter, year
ORDER BY year,quarter;

-- get the three biggest spenders

SELECT 
    c.customer_id,
    COALESCE(
        CONCAT(p.first_name, ' ', p.last_name),
        g.agency
    ) AS customer_name,
    SUM(
        COALESCE(co.price, 0) + COALESCE(i.price, 0)
    ) AS total_spent
FROM Customer c
LEFT JOIN Private p ON c.customer_id = p.customer_id
LEFT JOIN Government g ON c.customer_id = g.customer_id
LEFT JOIN Purchase pu ON c.customer_id = pu.customer_id
LEFT JOIN Inventory inv ON pu.purchase_id = inv.purchase_id
LEFT JOIN Computer co ON inv.computer_id = co.computer_id
LEFT JOIN Item i ON inv.item_id = i.item_id
GROUP BY c.customer_id, customer_name
ORDER BY total_spent DESC
LIMIT 3;

