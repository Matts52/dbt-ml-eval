with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.negative_likelihood_ratio(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.3076923076923077 as expected_25 -- calculated by hand ((1-TPR)/TNR = (FN/(TP+FN))/(TN/(TN+FP)) = 4/13)
from classification_25