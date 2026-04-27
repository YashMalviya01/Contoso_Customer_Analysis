📂 Dataset Overview

The analysis is based on the Contoso dataset, a retail business dataset containing transactional and customer-level information.

Data Scope:

Time period: 2015 – 2024
Granularity: Customer-level and transaction-level data

Key Tables Used:

Sales → Transactional revenue data
Customers → Customer demographics and identifiers
Products → Product categories and pricing

Key Metrics Derived:

Customer Lifetime Value (LTV) → Total revenue generated per customer
Cohort Year → First purchase year of customer
Revenue per Customer (ARPU) → Average revenue per user
Retention / Churn Rate → Active vs churned customers by cohort

Data Transformations:

Aggregated revenue at customer level to compute LTV
Segmented customers into Low, Mid, High-value tiers
Built cohort-based aggregations for trend analysis
Calculated retention percentages using cohort tracking


01 -  Customer Segmentation Analysis 
🎯 Executive Summary (What matters most)
We segmented customers into Low, Mid, and High LTV tiers and analyzed their revenue contribution.
Key finding:
A small group of high-value customers contributes ~66% of total revenue, while low-value customers contribute only ~2%.
This indicates a heavily skewed revenue distribution, where growth is driven more by customer quality than customer quantity.

-- segement_values AS (
    SELECT
        c.customerkey,
        c.total_ltv,
        CASE
            WHEN c.total_ltv < percentile_25th THEN '1 - Low-Value'
            WHEN c.total_ltv BETWEEN percentile_25th AND percentile_75th THEN '2 - Mid-Value'
            ELSE '3 - High-Value'
        END AS customer_segment
    FROM customer_ltv c,
    customer_segments cs
)

📊 Core Findings
1. Revenue Concentration
High-value customers → 65.6% of total revenue
Mid-value customers → 32.3%
Low-value customers → 2.1%
Interpretation:
The business follows a Pareto-like distribution
Revenue dependency on top-tier customers is very high

2. Customer Distribution vs Revenue
Segment
Customers
Revenue Contribution
Avg LTV
High-Value
12,372
65.6%
~10,946
Mid-Value
24,743
32.3%
~2,693
Low-Value
12,372
2.1%
~351

Interpretation:
Mid-value customers are 2x in volume but generate half the revenue of high-value
High-value customers are ~4x more valuable than mid-value
Low-value segment has minimal economic impact

3. Efficiency of Revenue Generation
From a unit economics perspective:
High-value segment = highest ROI per customer
Low-value segment = low yield, potentially high servicing cost
Implication:
Not all customers should be treated equally — segmentation-based strategy is necessary.

⚠️ Risk Assessment
1. Revenue Dependency Risk
Over 65% revenue tied to one segment
Any churn in high-value customers will have disproportionate impact
2. Underutilized Mid-Segment
Large base but under-monetized
Represents biggest opportunity for scalable growth

🚀 Strategic Recommendations
1. High-Value Customers → Protect & Retain
Priority: Retention over acquisition
Actions:
Personalized engagement
Loyalty incentives
Dedicated support
Goal: Reduce churn by even 5% → significant revenue protection

2. Mid-Value Customers → Upsell & Convert
Priority: Move them into high-value tier
Actions:
Targeted upselling
Behavior-based recommendations
Pricing bundles
This segment offers the highest marginal growth opportunity

3. Low-Value Customers → Optimize Cost
Priority: Efficiency
Actions:
Automate engagement
Limit acquisition spend
Run low-cost reactivation campaigns
Avoid over-investing in a low-return segment

📈 Business Impact Framing
If we:
Increase mid → high conversion by 10%
Reduce high-value churn by 5%
👉 Expected outcome:
Significant revenue lift without increasing customer acquisition cost

🧠 Final Takeaway for Stakeholders
“This is not a customer growth problem — this is a customer value optimization problem.”
Scaling low-value users won’t move the needle
Focusing on retention + value expansion will

<img width="459" height="411" alt="output" src="https://github.com/user-attachments/assets/b5d6845f-f2d3-4675-b50d-777660dc4629" />







02 - Cohort Analysis

🎯 Executive Summary
We analyzed customer cohorts from 2015–2024 across:
Total revenue
Customer volume
Revenue per customer
Key takeaway:
Growth has been inconsistent and recently declining in customer quality (revenue per user), despite periods of strong acquisition.

--SELECT
    days_since_first_purchase,
    SUM(total_net_revenue) as total_revenue,
    SUM(total_net_revenue) / (SELECT SUM(total_net_revenue) FROM cohort_analysis) * 100 as percentage_of_total_revenue,
    SUM(SUM(total_net_revenue) / (SELECT SUM(total_net_revenue) FROM cohort_analysis) * 100) OVER (ORDER BY days_since_first_purchase) as cumulative_percentage_of_total_revenue
FROM purchase_days
GROUP BY days_since_first_purchase
ORDER BY days_since_first_purchase;

📊 Core Findings
1. Growth Phase vs Instability Phase
📈 Growth Phase (2015–2019)
Revenue grew from ~7.2M → 22.2M
Customers grew from 2.8K → 7.7K
👉 Interpretation:
Strong acquisition + stable monetization
Business scaling efficiently

⚠️ Disruption Phase (2020)
Revenue dropped to ~7M
Customers dropped to 3K
👉 Likely causes:
External shock (market / COVID-type effect)
Acquisition + retention both impacted

🔄 Recovery Phase (2021–2022)
Revenue rebounded to ~21.5M (2022 peak)
Customers peaked at 9K (highest ever)
👉 Interpretation:
Aggressive acquisition strategy
Business regained scale

📉 Decline Phase (2023–2024)
Revenue dropped sharply:
2023 → 12.8M
2024 → 2.7M (critical drop)
Customers also dropped significantly
👉 Interpretation:
Acquisition slowdown or retention failure
Potential business contraction

2. Revenue per Customer (Critical Insight)
Year
Revenue per Customer
2016–2019
~2,600–2,900
2020
~2,328
2022
~2,387
2023
~2,188
2024
~1,972

🔍 Insight:
Customer quality is declining over time
Even when customers increased (2022),
→ value per customer dropped
👉 This signals:
Discount-heavy acquisition
Lower-value users entering funnel
Weak monetization strategy

3. Acquisition vs Monetization Imbalance
2022: Highest customers (9K)
BUT not highest efficiency
2019: Fewer customers (7.7K)
BUT better monetization
👉 Insight:
Growth is being driven by volume, not value

⚠️ Risk Assessment
1. Declining Customer Quality
Revenue per user consistently decreasing
Indicates long-term profitability risk

2. Volatile Revenue Trends
No stable upward trajectory
Business is sensitive to external or internal changes

3. Recent Sharp Drop (2024)
Revenue collapsed to ~2.7M
Customers also dropped
👉 This is not normal fluctuation — this is:
A potential structural issue (strategy, product, or market)

🚀 Strategic Recommendations
1. Shift Focus: Acquisition → Monetization
Current issue:
Too many low-value users entering system
Actions:
Tighten targeting (better customer profiles)
Reduce discount dependency
Improve pricing strategy

2. Improve Customer Quality
Focus on:
High-intent users
Retention over acquisition
Actions:
Behavioral segmentation
Lifecycle marketing
Upsell/cross-sell strategies

3. Investigate 2023–2024 Drop (Priority)
Immediate deep-dive required into:
Channel performance
Customer churn rates
Product changes
Market conditions

4. Cohort Retention Analysis (Next Step)
This dataset shows acquisition performance, but missing:
Retention curves
Repeat purchase behavior
👉 Recommend:
Build retention cohorts (Month 0, Month 1, Month 3…)
Identify where drop-offs occur

📈 Business Framing
If current trend continues:
Increasing customers will not translate into revenue growth
Margins will shrink due to low-value users

<img width="587" height="470" alt="output (1)" src="https://github.com/user-attachments/assets/ace07440-3391-4570-92c1-134832e31cf1" />




03 - Retention Analysis

🎯 Executive Summary
Across all cohorts (2015–2023), ~90–92% of customers churn, and only ~8–10% remain active.
This indicates:
A severe retention problem — the business is heavily dependent on constant new customer acquisition to sustain revenue.

--SELECT
    cohort_year,
    customer_status,
    COUNT(customerkey) AS num_customers,
    SUM(COUNT(customerkey)) OVER(PARTITION BY cohort_year) AS total_customers,
    ROUND(COUNT(customerkey) / SUM(COUNT(customerkey)) OVER(PARTITION BY cohort_year), 2) AS cohort_percentage
FROM churned_customers
GROUP BY
    cohort_year,
    customer_status

📊 Core Findings
1. Extremely High Churn Rate (Primary Insight)
Churn rate consistently: ~90–92%
Retention (Active): ~8–10%
👉 Interpretation:
This is not normal for most sustainable businesses
Indicates:
Weak product stickiness
Poor customer lifecycle engagement
Possibly transactional (one-time purchase behavior)

2. No Improvement Over Time
From 2015 → 2023:
Active %: only improved from 8% → ~10%
Churn still ~90%
👉 Insight:
Despite years of operation, retention strategy has not evolved effectively

3. Slight Improvement in Recent Cohorts
2022–2023:
Active increased to ~10%
Churn slightly reduced to ~90%
👉 Interpretation:
Some minor improvement in retention
But still critically low overall

4. Structural Business Issue
Combining this with your previous dataset:
👉 You now have a very strong combined insight:
Revenue depends on high-value customers
BUT overall customer base has massive churn
This means:
The business survives on a small loyal segment + constant new inflow

⚠️ Risk Assessment (Very Important for Stakeholders)
1. Unsustainable Growth Model
High churn → continuous need for acquisition spend
Leads to:
Increasing CAC (Customer Acquisition Cost)
Pressure on margins

2. Revenue Volatility
Since most users leave:
Revenue becomes unstable
Matches what we saw in previous dataset (drops in 2020, 2024)

3. Weak Customer Loyalty
Only ~10% retained
Indicates:
Low engagement
Low switching cost
Weak differentiation

🚀 Strategic Recommendations
1. Immediate Priority → Retention Strategy
Retention is the biggest lever for growth right now — not acquisition
Actions:
Lifecycle marketing (email, push, personalization)
Onboarding optimization
Engagement triggers

2. Identify Why Customers Churn
You need deeper analysis on:
Time-to-churn (when users drop)
Behavior before churn
Segment-wise churn (high vs low value)

3. Focus on High-Value Retention
From previous dataset:
High-value users = majority revenue
👉 Strategy:
Protect this segment aggressively
Even small retention improvement = huge revenue impact

4. Redesign Customer Journey
Potential issues:
Poor first experience
No habit formation
Lack of recurring value

📈 Business Framing
If retention improves from:
10% → 15%
👉 That’s a 50% improvement in retained users
Which can:
Significantly increase revenue
Reduce dependency on acquisition

<img width="567" height="455" alt="output (2)" src="https://github.com/user-attachments/assets/8e6e0e3a-2154-4966-bb0b-6a72f21b21db" />



🧠 Final Stakeholder Message
“The core issue is not just growth or revenue — it’s retention. We are losing ~90% of customers across every cohort, which makes the business heavily acquisition-dependent and structurally unstable.”

🧠 Final Business Insights
🎯 Overall Diagnosis

The business exhibits a structurally unstable growth model, driven by high churn, declining customer value, and heavy reliance on a small segment of high-value customers.

🔑 Key Insights
1. Revenue Concentration Risk
~65% of revenue comes from high-value customers
Business is highly dependent on a small customer segment

👉 Risk:
Loss of a small group of customers can significantly impact revenue

2. Declining Customer Quality
Revenue per customer has consistently decreased over time
Growth periods (e.g., 2022) were driven by volume, not value

👉 Insight:
Customer acquisition strategy is bringing in lower-value users

3. Extremely High Churn (~90%)
Only 8–10% of customers are retained
Consistent across all cohorts

👉 Insight:
The business lacks customer stickiness and long-term engagement

4. Acquisition-Dependent Growth Model
Due to high churn, business relies on:
Continuous new customer acquisition
Increased marketing spend

👉 Risk:
Rising CAC and declining profitability

⚠️ Core Problem Statement

This is not a growth problem — it is a retention and value optimization problem.

Increasing users alone will not drive sustainable revenue
Long-term growth depends on improving:
Retention
Customer value
🚀 Strategic Recommendations
1. Retention First Strategy
Improve onboarding and early user experience
Implement lifecycle marketing (email, personalization)
Focus on reducing churn in first few months
2. Monetization Optimization
Reduce reliance on discounts
Introduce upselling and cross-selling strategies
Target high-intent users
3. High-Value Customer Protection
Loyalty programs
Premium support
Personalized engagement
📈 Business Impact Opportunity

If the business:

Improves retention from 10% → 15%
Converts more mid-value users into high-value

👉 Expected Outcome:

Significant revenue growth
Reduced acquisition dependency
Improved profitability
🧠 Final Takeaway

Sustainable growth will come not from acquiring more customers, but from retaining and maximizing the value of existing ones.



