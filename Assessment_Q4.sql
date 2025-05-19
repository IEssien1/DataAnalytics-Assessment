-- Customer Lifetime Value (CLV) Estimation

-- Calculate tenure, total transactions and total profit
WITH transactions AS (
    SELECT
        user.id AS customer_id,
        user.name AS name,
        TIMESTAMPDIFF(MONTH, user.date_joined, CURDATE()) AS tenure_months,
        SUM(savings.confirmed_amount) AS total_transactions,
        SUM(savings.confirmed_amount) * 0.001 AS total_profit
    FROM
        adashi_staging.users_customuser user
    JOIN
        adashi_staging.savings_savingsaccount savings
        ON user.id = savings.owner_id
    GROUP BY
        user.id, user.name, user.date_joined
)

-- calculate estimated CLV
SELECT
    customer_id,
    name,
    tenure_months,
    total_transactions,
    ROUND((total_profit / NULLIF(tenure_months, 0)) * 12, 2) AS estimated_clv
FROM
    transactions
ORDER BY
    estimated_clv DESC;