{%- macro matthews_correlation(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('matthews_correlation', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__matthews_correlation(actual, predicted, positive_label=1) -%}

    {%- set TP -%}
        (sum(case when {{ predicted }} = {{ positive_label }} and {{ actual }} = {{ positive_label }} then 1 else 0 end))
    {%- endset -%}

    {%- set TN -%}
        (sum(case when {{ predicted }} != {{ positive_label }} and {{ actual }} != {{ positive_label }} then 1 else 0 end))
    {%- endset -%}

    {%- set FP -%}
        (sum(case when {{ predicted }} = {{ positive_label }} and {{ actual }} != {{ positive_label }} then 1 else 0 end))
    {%- endset -%}

    {%- set FN -%}
        (sum(case when {{ predicted }} != {{ positive_label }} and {{ actual }} = {{ positive_label }} then 1 else 0 end))
    {%- endset -%}

    {{
        dbt_utils.safe_divide(
            "(" ~ TP ~ " * " ~ TN ~ " - " ~ FP ~ " * " ~ FN ~ ")",
            "sqrt((" ~ TP ~ " + " ~ FP ~ ") * (" ~ TP ~ " + " ~ FN ~ ") * (" ~ TN ~ " + " ~ FP ~ ") * (" ~ TN ~ " + " ~ FN ~ "))"
        )
    }}

{%- endmacro -%}
