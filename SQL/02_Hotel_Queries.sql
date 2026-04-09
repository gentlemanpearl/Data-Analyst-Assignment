WITH RankedBookings AS (
    SELECT user_id, room_no,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY booking_date DESC) as rn
    FROM bookings
)
SELECT user_id, room_no
FROM RankedBookings
WHERE rn = 1;

SELECT b.booking_id, SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE b.booking_date >= '2021-11-01' AND b.booking_date < '2021-12-01'
GROUP BY b.booking_id;

SELECT bc.bill_id, SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE bc.bill_date >= '2021-10-01' AND bc.bill_date < '2021-11-01'
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;

WITH ItemQuantities AS (
    SELECT 
        DATE_FORMAT(bill_date, '%Y-%m') as bill_month,
        item_id,
        SUM(item_quantity) as total_quantity
    FROM booking_commercials
    WHERE YEAR(bill_date) = 2021
    GROUP BY DATE_FORMAT(bill_date, '%Y-%m'), item_id
),
RankedItems AS (
    SELECT 
        bill_month, 
        item_id, 
        total_quantity,
        RANK() OVER(PARTITION BY bill_month ORDER BY total_quantity DESC) as rank_most,
        RANK() OVER(PARTITION BY bill_month ORDER BY total_quantity ASC) as rank_least
    FROM ItemQuantities
)
SELECT 
    bill_month,
    MAX(CASE WHEN rank_most = 1 THEN i.item_name END) as most_ordered_item,
    MAX(CASE WHEN rank_least = 1 THEN i.item_name END) as least_ordered_item
FROM RankedItems ri
JOIN items i ON ri.item_id = i.item_id
GROUP BY bill_month;

WITH MonthlyCustomerBills AS (
    SELECT 
        DATE_FORMAT(bc.bill_date, '%Y-%m') as bill_month,
        b.user_id,
        u.name,
        SUM(bc.item_quantity * i.item_rate) as total_bill_value
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN users u ON b.user_id = u.user_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY DATE_FORMAT(bc.bill_date, '%Y-%m'), b.user_id, u.name
),
RankedCustomerBills AS (
    SELECT 
        bill_month, 
        user_id, 
        name, 
        total_bill_value,
        DENSE_RANK() OVER(PARTITION BY bill_month ORDER BY total_bill_value DESC) as rnk
    FROM MonthlyCustomerBills
)
SELECT bill_month, user_id, name, total_bill_value
FROM RankedCustomerBills
WHERE rnk = 2;
