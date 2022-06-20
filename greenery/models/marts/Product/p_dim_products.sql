{{
  config(
    materialized='view'
  )
}}

SELECT product_id
,name
,price
,inventory
FROM {{ ref('stg_products') }}