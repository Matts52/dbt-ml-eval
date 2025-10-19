with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.positive_predictive_value(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.7692307692307693 as expected_25 -- calculated by hand (TP/(TP+FP) = 10/13)
from classification_25