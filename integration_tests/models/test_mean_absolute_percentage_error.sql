with regression_25 as (
    select *
    from {{ ref('regression_25') }}
)

select
    {{ dbt_ml_eval.mean_absolute_percentage_error(actual='actual', predicted='predicted') }} as actual_25,
    8.47 as expected_25 -- approx MAPE (8.4%) calculated by hand
from regression_25
