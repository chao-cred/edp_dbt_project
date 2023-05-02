with cap_ex as (
    select * from {{ ref('edp_staging_capital_goods')}}
    where LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM {{ ref('edp_staging_capital_goods')}})
),

account_mapping as (
    select * from {{ ref('edp_staging_account_mapping')}}
    where LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM {{ ref('edp_staging_account_mapping')}})
),

org_mapping as (
    select * from {{ ref('edp_staging_org_mapping')}}
    where LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM {{ ref('edp_staging_org_mapping')}})
),

final as (
    select 
    year,
    month,
    date_type,
    country,
    account_code,
    a.description as account_description,
    sum(measure_amt) as spend_usd
    from cap_ex c left join org_mapping o on c.hyperion_id = o.hfm_name
    left join account_mapping a on c.account_code = o.hfm_name 
    group by year, month, date_type, country, account_code, a.description

)

select * 
from final