{{
  config(
    materialized='view'
  )
}}


SELECT u.user_id,
u.address_id,
order_id
FROM  {{ ref('m_dim_users') }} U
LEFT JOIN {{ ref('m_dim_addresses') }} A
ON U.address_id = a.address_id
LEFT JOIN {{ ref('m_dim_orders') }} O
ON U.user_id = O.user_id
LEFT JOIN {{ ref('m_dim_order_items') }} OI
ON O.order_id = OI.order_ID
LEFT JOIN {{ ref('m_dim_products') }} P
ON OI.product_id = P.product_ID