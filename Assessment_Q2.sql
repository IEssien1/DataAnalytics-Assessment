-- Transaction Frequency Analysis

-- Q2: Transaction Frequency Analysis

-- CTE of average transactions per customer per month
WITH customer_avg_transaction AS (
    SELECT 
        user.name,
        COUNT(*) / COUNT(DISTINCT DATE_FORMAT(`transaction_date`, '%Y-%m')) AS avg_transactions_per_month
    FROM
        adashi_staging.users_customuser user
    JOIN
        adashi_staging.savings_savingsaccount savings
        ON user.id = savings.owner_id
    GROUP BY 
        user.name
)

-- Classify frequency and summarize by category
SELECT 
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month >= 3 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 2) AS avg_transactions_per_month
FROM
    customer_avg_transaction
GROUP BY 
    frequency_category;
