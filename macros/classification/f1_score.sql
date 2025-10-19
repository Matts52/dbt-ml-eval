{%- macro f1_score(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('f1_score', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__f1_score(actual, predicted, positive_label=1) -%}

    {{
        dbt_utils.safe_divide(
            "2 * ((" ~ dbt_ml_eval.precision(actual, predicted, positive_label) ~ ") * (" ~ dbt_ml_eval.recall(actual, predicted, positive_label) ~ "))",
            "(" ~ dbt_ml_eval.precision(actual, predicted, positive_label) ~ " + " ~ dbt_ml_eval.recall(actual, predicted, positive_label) ~ ")"
        )
    }}

{%- endmacro -%}
