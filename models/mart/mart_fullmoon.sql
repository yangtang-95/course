{{
    config(
        materialized = 'table'
    )
}}

with 
fct_review as 
(
    select * from {{ref('fct_reviews')}}
),
full_moon as 
(
    select * from {{ref('seed_full_moon_dates')}}
)

select
    r.*,
    case 
        when f.full_moon_date is null then 'not full_moon'
        else 'full_moon'
    end as is_full_moon
from fct_review r
left join full_moon f
on to_date(r.review_date) = dateadd (day, 1, f.full_moon_date)