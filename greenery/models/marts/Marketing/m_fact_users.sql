{{
  config(
    materialized='view'
  )
}}


SELECT u.user_id,
u.first_name,
u.last_name,
u.email,
u.phone_number,
u.address_id,
a.country,
count(distinct o.order_id) as NumOfDistinctOrdersMade,
count(distinct oi.product_id) as NumOfDistinctProductsBought,
count(distinct o.promo_id) as NumOfDistinctPromoUsed,
sum(oi.quantity) as TotalNumOfItemsPurchased,
sum(o.order_cost) as TotalOrderCosts,
sum(o.shipping_cost) as TotalShippingCosts,
sum(o.order_total) as TotalOrderAmount
FROM  {{ ref('stg_users') }} U
LEFT JOIN {{ ref('stg_addresses') }} A
ON U.address_id = a.address_id
LEFT JOIN {{ ref('stg_orders') }} O
ON U.user_id = O.user_id
LEFT JOIN {{ ref('stg_order_items') }} OI
ON O.order_id = OI.order_ID
LEFT JOIN {{ ref('stg_products') }} P
ON OI.product_id = P.product_ID
group by 1,2,3,4,5,6,7
