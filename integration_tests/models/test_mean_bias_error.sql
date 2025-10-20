with regression_25 as (
    select *
    from {{ ref('regression_25') }}
)

select
    {{ dbt_ml_eval.mean_bias_error(actual='actual', predicted='predicted') }} as actual_25,
    -0.004 as expected_25 -- approximate mean(predicted-actual) = -0.004
from regression_25
