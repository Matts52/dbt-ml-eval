with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.true_negative_rate(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.75 as expected_25 -- calculated by hand (same as specificity)
from classification_25