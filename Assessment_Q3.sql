-- Q3: Account Inactivity Alert

SELECT 
	plans.id AS plan_id,
    plans.owner_id AS owner_id,
	-- identify account type
    CASE 
		WHEN plans.is_regular_savings = 1 THEN 'Savings'
        WHEN plans.is_a_fund = 1 THEN 'Investment'
	END AS type,
    DATE(MAX(savings.transaction_date)) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(transaction_date)) AS days_inactive
FROM
	adashi_staging.plans_plan plans
JOIN
	adashi_staging.savings_savingsaccount savings
	ON savings.plan_id = plans.id
WHERE
	(plans.is_a_fund = 1 OR plans.is_regular_savings = 1)
    AND savings.confirmed_amount > 0 -- accounts with no inflows
GROUP BY 
	plans.id, plans.owner_id
HAVING 
	days_inactive >= 365 -- no inflows for more than one year
ORDER BY 
	days_inactive DESC;
