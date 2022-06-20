-- week2 questions:
/*-----------------------------------------------------------------------
What is our user repeat rate?
Repeat Rate = Users who purchased 2 or more times / users who purchased
-----------------------------------------------------------------------*/
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


/*-------------------------------------------------------------------------------------------
What are good indicators of a user who will likely purchase again? 
What about indicators of users who are likely NOT to purchase again? 
If you had more data, what features would you want to look into to answer this question?

NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set.
Think about what exploratory analysis you would do to approach this question.
-------------------------------------------------------------------------------------------*/

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


/*-------------------------------------------------------------------------------------------
Explain the marts models you added. Why did you organize the models in the way you did?
-------------------------------------------------------------------------------------------*/

I originally started creating a dim and fact tables for the CORE mart.  To me 'CORE' is the main area where greenery can answer any question related to the business. 

For "MARKETING" and "PRODUCT" marts, I've pre-fix the dim and fact files for organization purposes (i.e. with "M_" for marketing tables and "P_" for products tables.) This is me presuming that each department might have their own DBT engineer. 

However after creating the DAG image, I'm realizing that the models is not the most effecient since a few of the dim tables are repeated.

Lastly for "Marketing" mart, I think that department's main interest is "user related data". I'm using the STG_USERS to help create a main list of users, then LEFT JOIN the any relavent information that can be associated to a user. I'm assuming there might exist users who had signed up for Greenery service, but not neccessary had made a purchase. 

For "Products" mart, I think that department's main interest is "product related data".  I'm using the STG_PRODUCTS to help create a main list of products, then LEFT JOIN the any relavent information that can be associated to a product. I'm assuming there might exist products of which Greenery might not have sold yet to any user. 

/*-------------------------------------------------------------------------------------------
We added some more models and transformed some data! Now we need to make sure they’re accurately reflecting the data. Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above

What assumptions are you making about each model? (i.e. why are you adding each test?)

Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
-------------------------------------------------------------------------------------------*/
In all of the models, I've added basic test to ensure that the ids are not null.
