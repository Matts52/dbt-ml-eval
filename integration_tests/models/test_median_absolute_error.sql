with regression_25 as (
    select *
    from {{ ref('regression_25') }}
)

select
    {{ dbt_ml_eval.median_absolute_error(actual='actual', predicted='predicted') }} as actual_25,
    0.3 as expected_25 -- approximate median absolute error
from regression_25
