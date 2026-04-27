WITH customer_last_purchase AS (	
	SELECT 
		cohort_year, 
		customerkey,
		orderdate,
		row_number() OVER (PARTITION BY customerkey ORDER BY orderdate DESC) AS rn,
		first_purchase_date
	FROM 
		cohort_analysis 
), churned_customers AS(
	SELECT 	
		customerkey, 
		orderdate AS last_purchase_date,
		cohort_year, 
		CASE 
			WHEN orderdate < '2024-04-20'::date- INTERVAL '6 months' THEN 'Churned'
			ELSE 'Active'
		END AS customer_status
	FROM 
		customer_last_purchase 
	WHERE rn = 1	
		AND first_purchase_date < '2024-04-20'::date - INTERVAL '6 months'
)
SELECT
    cohort_year,
    customer_status,
    COUNT(customerkey) AS num_customers,
    SUM(COUNT(customerkey)) OVER(PARTITION BY cohort_year) AS total_customers,
    ROUND(COUNT(customerkey) / SUM(COUNT(customerkey)) OVER(PARTITION BY cohort_year), 2) AS cohort_percentage
FROM churned_customers
GROUP BY
    cohort_year,
    customer_status
ORDER BY
    cohort_year,
    customer_status;