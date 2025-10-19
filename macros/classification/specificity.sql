{%- macro specificity(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('specificity', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__specificity(actual, predicted, positive_label=1) -%}

    {{
        dbt_utils.safe_divide(
            "sum(case when " ~ predicted ~ " = 0 and " ~ actual ~ " != " ~ positive_label ~ " then 1 else 0 end)",
            "sum(case when " ~ actual ~ " != " ~ positive_label ~ " then 1 else 0 end)"
        )
    }}

{%- endmacro -%}
