{%- macro prevalence_threshold(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('prevalence_threshold', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__prevalence_threshold(actual, predicted, positive_label=1) -%}

    (
        (
            {{ true_positive_rate(actual, predicted, positive_label) }}
            * {{ false_positive_rate(actual, predicted, positive_label) }}
            - {{ false_positive_rate(actual, predicted, positive_label) }}
        )
        /
        (
            {{ true_positive_rate(actual, predicted, positive_label) }}
            - {{ false_positive_rate(actual, predicted, positive_label) }}
        )
    )

{%- endmacro -%}
