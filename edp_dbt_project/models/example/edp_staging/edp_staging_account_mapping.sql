{{ config(materialized='table') }}

with source_account_mapping as (select *
from {{ ref('account_mapping')}}
),

final as (
    select *
    from source_account_mapping
)

select * from final
