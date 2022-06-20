--How many users do we have?

SELECT count(distinct user_id)
FROM dbt_ken_c.users_table

--There are 130 users

--On average, how many orders do we receive per hour?

SELECT round(avg(NumofOrders),2)
from (
SELECT extract(year from created_at) as orderyear
,extract(month from created_at) as ordermonth
,extract(day from created_at) as orderday
,extract(hour from created_at) as orderhour
, count(*) as numoforders
from dbt_ken_c.orders_table
group by extract(year from created_at)
,extract(month from created_at)
,extract(day from created_at)
,extract(hour from created_at)
) A

-- 7.52 orders per hour

--On average, how long does an order take from being placed to being delivered?

SELECT avg(delivered_at - created_at)
from dbt_ken_c.orders_table
where delivered_at is not null

-- 3 days, 21 hours, 24mins, 11secs

SELECT *
from dbt_ken_c.orders_table


--How many users have only made one purchase? Two purchases? Three+ purchases?
--Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

SELECT count(*)
from (
SELECT user_id,count(*)
from dbt_ken_c.orders_table
group by user_id
HAVING COUNT(user_id) = 1
) A
union
SELECT count(*)
from (
SELECT user_id,count(*)
from dbt_ken_c.orders_table
group by user_id
HAVING COUNT(user_id) = 2
) A
union
SELECT count(*)
from (
SELECT user_id,count(*)
from dbt_ken_c.orders_table
group by user_id
HAVING COUNT(user_id) >= 3 
) A

-- 25 users had one order, 71 users had two orders and 28 users had three or more orders.

--On average, how many unique sessions do we have per hour?

SELECT round(avg(sessionperhour),2)
FROM
(
SELECT extract(year from created_at) as sessionyear
,extract(month from created_at) as sessionmonth
,extract(day from created_at) as sessionday
,extract(hour from created_at) as sessionhour
, count (distinct session_id) as sessionperhour
from dbt_ken_c.events_table
group by extract(year from created_at)
,extract(month from created_at)
,extract(day from created_at)
,extract(hour from created_at)
) A

-- 16.33
