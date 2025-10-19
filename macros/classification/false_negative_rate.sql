{%- macro false_negative_rate(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('false_negative_rate', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__false_negative_rate(actual, predicted, positive_label=1) -%}

    {{
        dbt_utils.safe_divide(
            "sum(case when " ~ predicted ~ " != " ~ positive_label ~ " and " ~ actual ~ " = " ~ positive_label ~ " then 1 else 0 end)",
            "sum(case when " ~ actual ~ " = " ~ positive_label ~ " then 1 else 0 end)"
        )
    }}

{%- endmacro -%}
