{{
  config(
    materialized='view'
  )
}}


SELECT count(*) as TotalSessions,
sum(CASE WHEN page_view_count > 0 THEN 1 ELSE 0 END) as NumOfSessionWith_PV,
sum(CASE WHEN add_to_cart_count > 0 THEN 1 ELSE 0 END) as NumOfSessionWith_ATC,
sum(CASE WHEN checkout_count > 0 THEN 1 ELSE 0 END) as NumOfSessionWith_CO
FROM {{ ref('fact_sessions') }}


