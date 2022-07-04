/* row check: creates snapshot records if a row had changed. */
{% snapshot inventory_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='order_id',

      strategy='check',
      check_cols=['status'],
    )
  }}

  SELECT * FROM {{ source('greenery', 'orders') }}

{% endsnapshot %}

