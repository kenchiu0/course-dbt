{{
  config(
    materialized='view'
  )
}}

SELECT event_id
,session_id
,user_id
,event_type
,page_url
,created_at
,order_id
,product_id
FROM {{ ref('stg_events') }}