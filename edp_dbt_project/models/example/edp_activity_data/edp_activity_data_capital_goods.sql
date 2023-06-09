with cap_ex as (
    select * from {{ ref('edp_staging_capital_goods')}}
    where LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM {{ ref('edp_staging_capital_goods')}})
),

account_mapping as (
    select * from {{ ref('edp_staging_account_mapping')}}
    where LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM {{ ref('edp_staging_account_mapping')}})
),


final as (
    select 
    year,
    month,
    date_type,
    country,
    c.account_code,
    a.description as account_description,
    sum(cast(spend_usd as decimal)) as spend_usd
    from cap_ex c 
    left join account_mapping a on c.account_code = a.account_code
    group by year, month, date_type, country, c.account_code, a.description

)

select * 
from final