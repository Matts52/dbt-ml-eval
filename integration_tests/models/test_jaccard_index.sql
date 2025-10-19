with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.jaccard_index(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.625 as expected_25 -- calculated by hand (TP/(TP+FP+FN) = 10/16)
from classification_25