{{
  config(
    materialized='view'
  )
}}

SELECT product_id, 
name, 
NumberOfUniqueSessions, 
NumberOfPurchases, 
round(cast(NumberOfPurchases as decimal (7,2))/cast(NumberOfUniqueSessions as decimal (7,2)),2) as ConversionRate
FROM (
SELECT DISTINCT p.product_id,
p.name, 
count(distinct e.session_id) as NumberOfUniqueSessions,
count(distinct o.order_id) as NumberOfPurchases 
FROM {{ ref('stg_products') }} p
LEFT JOIN {{ ref('stg_order_items') }} oi on p.product_id  = oi.product_id
LEFT JOIN {{ ref('stg_orders') }} o ON oi.order_id = o.order_id
LEFT JOIN {{ ref('stg_events') }} e ON p.product_id = e.product_id
group by p.product_id, p.name
) A
ORDER BY name