-- Q1: High-Value Customers with Multiple Products

-- Enable updating of tables
-- SET SQL_SAFE_UPDATES = 0

-- Concatenate firstname and lastname
-- UPDATE adashi_staging.users_customuser
-- SET name = lower(CONCAT(COALESCE(first_name, ''), ' ', COALESCE(last_name, '')))

-- retrieving customers with multiple products
SELECT 
	user.id AS owner_id,
    user.name,
    COUNT(CASE WHEN plans.is_regular_savings = 1 THEN 1 END) AS savings_count,
    COUNT(CASE WHEN plans.is_a_fund = 1 THEN 1 END) AS investment_count,
    SUM(savings.confirmed_amount) AS total_deposits
FROM
    adashi_staging.users_customuser user
JOIN
    adashi_staging.savings_savingsaccount savings
    ON user.id = savings.owner_id
JOIN
    adashi_staging.plans_plan plans
    ON savings.plan_id = plans.id
WHERE
    savings.confirmed_amount > 0 -- only funded plans
GROUP BY
    user.id, user.name
HAVING
    savings_count >= 1 AND investment_count = 1
ORDER BY
    total_deposits DESC;
