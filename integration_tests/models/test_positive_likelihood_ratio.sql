with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.positive_likelihood_ratio(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    3.076923076923077 as expected_25 -- calculated by hand (TPR/FPR = (10/13)/(1/4) = 40/13)
from classification_25