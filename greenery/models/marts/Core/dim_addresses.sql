{{
  config(
    materialized='view'
  )
}}

SELECT address_id
,zipcode
,state
,country
FROM {{ ref('stg_addresses') }}