{%- macro matthews_correlation(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('matthews_correlation', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__matthews_correlation(actual, predicted, positive_label=1) -%}

    {%- set TP -%}
        {{ dbt_ml_eval.true_positives(actual, predicted, positive_label=positive_label) }}
    {%- endset -%}

    {%- set TN -%}
        {{ dbt_ml_eval.true_negatives(actual, predicted, positive_label=positive_label) }}
    {%- endset -%}

    {%- set FP -%}
        {{ dbt_ml_eval.false_positives(actual, predicted, positive_label=positive_label) }}
    {%- endset -%}

    {%- set FN -%}
        {{ dbt_ml_eval.false_negatives(actual, predicted, positive_label=positive_label) }}
    {%- endset -%}

    {{
        dbt_utils.safe_divide(
            "(" ~ TP ~ " * " ~ TN ~ " - " ~ FP ~ " * " ~ FN ~ ")",
            "sqrt((" ~ TP ~ " + " ~ FP ~ ") * (" ~ TP ~ " + " ~ FN ~ ") * (" ~ TN ~ " + " ~ FP ~ ") * (" ~ TN ~ " + " ~ FN ~ "))"
        )
    }}

{%- endmacro -%}
