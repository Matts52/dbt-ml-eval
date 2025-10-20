with regression_25 as (
    select *
    from {{ ref('regression_25') }}
)

select
    {{ dbt_ml_eval.r2_score(actual='actual', predicted='predicted') }} as actual_25,
    0.9938 as expected_25 -- approximate R^2 computed by hand
from regression_25
