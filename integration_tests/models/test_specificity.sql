with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.specificity(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.75 as expected_25 -- calculated by hand (TN/(TN+FP) = 9/12)
from classification_25