{{
  config(
    materialized='view'
  )
}}

/*
SELECT session_id,
sum(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) as page_view_count,
sum(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) as add_to_cart_count,
sum(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) as checkout_count,
sum(CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END) as package_shipped_count
FROM {{ ref('stg_events') }}
group by session_id
*/
with session_et_counts as
(
SELECT DISTINCT session_id,
{{agg_event('page_view')}} as page_view_count,
{{agg_event('add_to_cart')}} as add_to_cart_count,
{{agg_event('checkout')}} as checkout_count,
{{agg_event('package_shipped')}} as package_shipped_count
FROM {{ ref('stg_events') }}
group by session_id
)

SELECT *
FROM session_et_counts
