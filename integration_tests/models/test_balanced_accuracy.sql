with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.balanced_accuracy(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.7596153846153846 as expected_25 -- calculated by hand
from classification_25