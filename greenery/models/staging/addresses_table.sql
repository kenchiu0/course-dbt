{{
  config(
    materialized='view'
  )
}}

SELECT address_id
,zipcode
,state
,country
FROM {{ source('greenery', 'addresses') }}