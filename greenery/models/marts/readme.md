-- week2 questions:
/*
What is our user repeat rate?
Repeat Rate = Users who purchased 2 or more times / users who purchased
*/
SELECT count(*)
from (
SELECT DISTINCT user_id
FROM dbt_ken_c.stg_orders
group by user_id
HAVING COUNT(user_id) >= 2  
) A

SELECT count(*)
from (
SELECT DISTINCT user_id
FROM dbt_ken_c.stg_orders
) A

-- 99/124 is the user repeat rate.


/*
What are good indicators of a user who will likely purchase again? 
What about indicators of users who are likely NOT to purchase again? 
If you had more data, what features would you want to look into to answer this question?

NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set.
Think about what exploratory analysis you would do to approach this question.
*/

/*
This is open ended question. 

For me, "age", "gender" and "discounts" (or a combination of three) can be used to create key performance indicator (KPI) metrics
to identify if a person is likely to become a "repeat user" vs "user with single purchase"

Since we have "promo_id", we can compare if promos for products have an impact on purchage behavior. For example:
    % users who have used a promo in the "repeat user" group 
    vs 
    % users who have used a promo in the "user with single purchase" group

For "age" and "gender", I would request for additional fields (like "gender" and "birthdate") to be 
tracked or imported into the user table. If I have these fields available, I can then generate tables or graphs to 
get an general overview population groups (by age bands and gender) who are utilizing Greenery's services/products.

Lastly, I see in the users table, each user has a email for point of contact/send receipts. From the emails here, 
we can probably label users as "casual" or "commerce".  People who uses free email sign up are likely to make purchases 
for personal use. (i.e. casual)  Those with company emails (i.e. nationalgeographic.) are likely to make purchases 
for commerce uses.

I'll stop right here, but my ideals for measuring KPIs can be endless if we are able to track more data for Greenery.
*/
