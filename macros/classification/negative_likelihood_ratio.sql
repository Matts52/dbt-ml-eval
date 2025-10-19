{%- macro negative_likelihood_ratio(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('negative_likelihood_ratio', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__negative_likelihood_ratio(actual, predicted, positive_label=1) -%}

    (
        (1 - {{ true_positive_rate(actual, predicted, positive_label) }})
        /
        {{ true_negative_rate(actual, predicted, positive_label) }}
    )

{%- endmacro -%}
