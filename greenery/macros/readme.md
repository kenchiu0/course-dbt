/*PART 1: Create new models to answer the first two questions (answer questions in README file)

What is our overall conversion rate?

What is our conversion rate by product?

NOTE: conversion rate is defined as the # of unique sessions with a purchase event / total number of unique sessions. Conversion rate by product is defined as the # of unique sessions with a purchase event of that product / total number of unique sessions that viewed that product

A question to think about: Why might certain products be converting at higher/lower rates than others? Note: we don't actually have data to properly dig into this, but we can make some hypotheses. 
*/


SELECT product_id, name, NumberOfUniqueSessions, NumberOfPurchases, round(cast(NumberOfPurchases as decimal (7,2))/cast(NumberOfUniqueSessions as decimal (7,2)),2) as ConversionRate
FROM (
SELECT DISTINCT p.product_id,p.name, count(distinct e.session_id) as NumberOfUniqueSessions,count(distinct o.order_id) as NumberOfPurchases, cast(count(distinct o.order_id) / count(distinct e.session_id) as decimal (7,2))
FROM dbt_ken_c.dim_products p
LEFT JOIN dbt_ken_c.dim_order_items oi on p.product_id  = oi.product_id
LEFT JOIN dbt_ken_c.dim_orders o ON oi.order_id = o.order_id
LEFT JOIN dbt_ken_c.dim_events e ON p.product_id = e.product_id
group by p.product_id, p.name
) A
ORDER BY name

/*
Overall conversion rate is 862/ 1845 = 46.72%

Per Product conversion rate is:
Alocasia Polly = 41%
Aloe Vera = 49%
Angel Wings Begonia = 39%
Arrow head = 56%
Bamboo = 54%
Bird of Paradise = 45%
Birds Nest fern = 42%
Boston fern = 41%
Cactus = 55%
Calathen Makoyana = 51%
Devil's Ivy = 49%
Dragon Tree = 47%
Ficus = 43%
Fiddle Leaf Fig = 50%
Jade plant = 48%
Majesty Palm = 49%
Money Tree = 46%
Monstera = 51%
Orchid = 45%
Peace lily = 41%
Philodendron = 48%
Pilea Peperomioides = 47%
Pink Anthurium = 42%
Ponytail Palm = 40%
Pothos = 34%
Rubber Plant = 52%
Snake Plant = 40%
Spider Plant = 47%
String of Pearls = 61%
ZZ Plant = 54%
*/

