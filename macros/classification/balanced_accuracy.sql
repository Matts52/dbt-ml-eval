{%- macro balanced_accuracy(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('balanced_accuracy', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__balanced_accuracy(actual, predicted, positive_label=1) -%}

    {{
        dbt_utils.safe_divide(
            "(" ~ recall(actual, predicted, positive_label) ~ " + " ~ specificity(actual, predicted, positive_label) ~ ")",
            2
        )
    }}

{%- endmacro -%}
