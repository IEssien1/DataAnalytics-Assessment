# DataAnalytics-Assessment
_This repository contains my submission for the Cowrywise SQL Assessment for Data Analyst applicants._

Below is a detailed explanation of my approach to each assessment question:

## Assessment Q1: High-Value Customers with Multiple Products
**Objective:** Identify customers who have both a savings and an investment plan to support cross-selling opportunities.

**Approach:**
  1. Concatenated the first_name and last_name columns into a new name column.
  2. Joined the users_customuser, savings_savingsaccount, and plans_plan tables.
  3. Used case statements to identify whether a customer holds savings and/or investment accounts.
  4. Counted the number of each account type and calculated the total deposit per customer.
  5. Displayed owner_id, name, count of savings and investment accounts, and total deposits.

The resulting output shows customers who have at least one funded savings plan and one funded investment plan, sorted by total deposits.

**Note:** I observed duplicate customer names associated with different IDs. This could indicate that:
  1. A single customer holds multiple accounts under different IDs, or
  2. Different customers happen to share the same name.
It’s recommended to consult the data engineering team for clarification on this.

## Assessment Q2: Transaction Frequency Analysis
**Objective:** Help the finance team understand customer transaction frequency to enable user segmentation (e.g., frequent vs. occasional users).

**Approach:**
  1. Created a CTE to compute the average number of transactions per customer per month by joining users_customuser and savings_savingsaccount.
  2. In the outer query:

     a. Used case statements to classify customers into frequency segments (High, Medium, Low).

     b. Aggregated the number of customers in each segment along with their average transaction frequency.

This output segments customers based on activity levels and shows how many customers fall into each group.

## Assessment Q3: Account Inactivity Alert
**Objective:** Enable the operations team to flag accounts with no inflow transactions for over one year.

**Approach:**
  1. Joined the plans_plan and savings_savingsaccount tables.
  2. Filtered for customers with either a savings or investment account who were previously active.
  3. Within the SELECT clause:

     Used a CASE statement to classify account types.

     Extracted the last transaction date using MAX() and formatted it to show only the date.

     Calculated inactivity duration using DATEDIFF().
  4. Applied a HAVING clause to return only accounts with inactivity periods of 365 days or more.

This allows the operations team to easily identify and flag dormant accounts for follow-up.

## Assessment Q4: Customer Lifetime Value (CLV) Estimation
**Objective:** Help the marketing team estimate Customer Lifetime Value (CLV) based on account tenure and transaction volume.

**Approach:**
  1. Created a CTE that joins users_customuser and savings_savingsaccount to calculate:
     
    a. Account tenure in months (tenure_months)
    
    b. Total transaction value per customer
    
    c. Average profit per transaction (assumed at 0.1%)
    
  2. In the final query:
     
    a. Calculated CLV 
    
    b. Selected customer_id, name, tenure_months, total_transactions, and estimated_clv.
    
    c. Ordered results by estimated CLV in descending order.

This approach provides the marketing team with insights into the most valuable customers based on historical data.
