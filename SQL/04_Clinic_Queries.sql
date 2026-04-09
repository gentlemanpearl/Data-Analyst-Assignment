SELECT sales_channel, SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;

SELECT c.uid, c.name, SUM(cs.amount) AS total_spend
FROM customer c
JOIN clinic_sales cs ON c.uid = cs.uid
WHERE YEAR(cs.datetime) = 2021
GROUP BY c.uid, c.name
ORDER BY total_spend DESC
LIMIT 10;

WITH MonthlyData AS (
    SELECT DATE_FORMAT(datetime, '%Y-%m') as month, amount as revenue, 0 as expense
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    
    UNION ALL
    
    SELECT DATE_FORMAT(datetime, '%Y-%m') as month, 0 as revenue, amount as expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
),
AggregatedData AS (
    SELECT 
        month,
        SUM(revenue) as revenue,
        SUM(expense) as expense,
        SUM(revenue) - SUM(expense) as profit
    FROM MonthlyData
    GROUP BY month
)
SELECT 
    month, 
    revenue, 
    expense, 
    profit,
    CASE WHEN profit > 0 THEN 'Profitable' ELSE 'Not-Profitable' END as status
FROM AggregatedData
ORDER BY month;

WITH ClinicProfits AS (
    SELECT 
        c.city,
        c.cid,
        c.clinic_name,
        (
            COALESCE((SELECT SUM(amount) FROM clinic_sales cs WHERE cs.cid = c.cid AND DATE_FORMAT(cs.datetime, '%Y-%m') = '2021-09'), 0)
            -
            COALESCE((SELECT SUM(amount) FROM expenses e WHERE e.cid = c.cid AND DATE_FORMAT(e.datetime, '%Y-%m') = '2021-09'), 0)
        ) as profit
    FROM clinics c
),
RankedProfits AS (
    SELECT 
        city, cid, clinic_name, profit,
        RANK() OVER(PARTITION BY city ORDER BY profit DESC) as rnk
    FROM ClinicProfits
)
SELECT city, cid, clinic_name, profit
FROM RankedProfits
WHERE rnk = 1;

WITH ClinicProfits AS (
    SELECT 
        c.state,
        c.cid,
        c.clinic_name,
        (
            COALESCE((SELECT SUM(amount) FROM clinic_sales cs WHERE cs.cid = c.cid AND DATE_FORMAT(cs.datetime, '%Y-%m') = '2021-09'), 0)
            -
            COALESCE((SELECT SUM(amount) FROM expenses e WHERE e.cid = c.cid AND DATE_FORMAT(e.datetime, '%Y-%m') = '2021-09'), 0)
        ) as profit
    FROM clinics c
),
RankedProfits AS (
    SELECT 
        state, cid, clinic_name, profit,
        DENSE_RANK() OVER(PARTITION BY state ORDER BY profit ASC) as rnk
    FROM ClinicProfits
)
SELECT state, cid, clinic_name, profit
FROM RankedProfits
WHERE rnk = 2;
