{%- macro diagnostic_odds_ratio(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('diagnostic_odds_ratio', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__diagnostic_odds_ratio(actual, predicted, positive_label=1) -%}

    (
        (
            {{ dbt_ml_eval.positive_likelihood_ratio(actual, predicted, positive_label) }}
        )
        /
        (
            {{ dbt_ml_eval.negative_likelihood_ratio(actual, predicted, positive_label) }}
        )
    )

{%- endmacro -%}
