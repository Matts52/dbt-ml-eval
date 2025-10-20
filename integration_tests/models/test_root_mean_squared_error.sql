with regression_25 as (
    select *
    from {{ ref('regression_25') }}
)

select
    {{ dbt_ml_eval.root_mean_squared_error(actual='actual', predicted='predicted') }} as actual_25,
    0.378 as expected_25 -- by hand
from regression_25
