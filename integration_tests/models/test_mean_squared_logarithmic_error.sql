with regression_25 as (
    select *
    from {{ ref('regression_25') }}
    where actual >= 0 and predicted >= 0  -- MSLE requires non-negative values
)

select
    {{ dbt_ml_eval.mean_squared_logarithmic_error(actual='actual', predicted='predicted') }} as actual_25,
    0.0047 as expected_25 -- calculated by hand for the 22 non-negative rows
from regression_25
