with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.true_positive_rate(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.7692307692307693 as expected_25 -- calculated by hand (same as recall)
from classification_25