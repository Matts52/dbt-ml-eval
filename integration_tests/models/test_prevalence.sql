with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)

select
    {{
        dbt_ml_eval.prevalence(
            actual = 'actual'
        )
    }}
    as actual_25,
    0.52 as expected_25 -- calculated by hand ((TP+FN)/total = 13/25)
from classification_25
