{%- macro matthews_correlation(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('matthews_correlation', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__matthews_correlation(actual, predicted, positive_label=1) -%}

    sqrt(
        (
            {{ true_positive_rate(actual, predicted, positive_label) }}
            * {{ true_negative_rate(actual, predicted, positive_label) }}
            * {{ positive_predictive_value(actual, predicted, positive_label) }}
            * {{ negative_predictive_value(actual, predicted, positive_label) }}
            -
            {{ false_negative_rate(actual, predicted, positive_label) }}
            * {{ false_positive_rate(actual, predicted, positive_label) }}
            * {{ false_omission_rate(actual, predicted, positive_label) }}
            * {{ false_discovery_rate(actual, predicted, positive_label) }}
        )
    )

{%- endmacro -%}
