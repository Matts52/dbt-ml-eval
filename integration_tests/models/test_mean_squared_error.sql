with regression_25 as (
    select *
    from {{ ref('regression_25') }}
)

select
    {{ dbt_ml_eval.mean_squared_error(actual='actual', predicted='predicted') }} as actual_25,
    0.1428 as expected_25 -- calculated by hand
from regression_25
