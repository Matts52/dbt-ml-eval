{%- macro positive_likelihood_ratio(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('positive_likelihood_ratio', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__positive_likelihood_ratio(actual, predicted, positive_label=1) -%}

    (
        {{ true_positive_rate(actual, predicted, positive_label) }}
        /
        {{ false_positive_rate(actual, predicted, positive_label) }}
    )

{%- endmacro -%}
