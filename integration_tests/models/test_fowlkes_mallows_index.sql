with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.fowlkes_mallows_index(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.7692307692307693 as expected_25 -- calculated by hand (Fowlkes-Mallows = sqrt(precision*recall) = 10/13)
from classification_25