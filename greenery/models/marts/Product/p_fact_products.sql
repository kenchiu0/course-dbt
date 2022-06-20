{{
  config(
    materialized='view'
  )
}}

SELECT p.product_id
,name
,o.order_id
,user_id
,o.address_id
,o.promo_id
,order_cost
FROM {{ ref('p_dim_products') }} P

LEFT JOIN {{ ref('p_dim_order_items') }} OI
ON P.product_id = OI.product_id

LEFT JOIN {{ ref('p_dim_orders') }} O 
ON OI.order_id = O.order_id

LEFT JOIN {{ ref('p_dim_addresses') }} A 
ON O.address_id = A.address_id

LEFT JOIN {{ ref('p_dim_promos') }} PR 
ON O.promo_id = PR.promo_id
