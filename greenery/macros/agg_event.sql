/*{{
  config(
    materialized='view'
  )
}}*/

/*
{% set event_types = ["page_view","add_to_cart","checkout","package_shipped"] %}

for 
    session_id
    {% for event_type in event_types %}
        , MAX(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}_present,
    {% endfor %}
from {{ref ('p_dim_events')}}
group by session_id



###-----------------------------------------------------###

{% set event_types = select distinct event_type from {{ref('p_dim_events')}} %}

for 
    session_id
    {% for event_type in event_types %}
        , MAX(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}_present,
    {% endfor %}
from {{ref ('p_dim_events')}}
group by session_id
*/


## macro example  - save into macro folder##
{% macro agg_event(event_type) %}
sum(CASE WHEN event_type = '{{event_type}}' THEN 1 ELSE 0 END)
{% endmacro %}


###-----------------------------------------------------###

## After creating a macro, this is a basic way of calling macro.

## SELECT {{agg_event ('checkout')}} as checkout_count
## from {{ref(p_dim_events)}}

## SELECT max(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END as checkout_count
## from {{ref(p_dim_events)}}


###-----------------------------------------------------###