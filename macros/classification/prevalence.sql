{%- macro prevalence(actual, positive_label=1) -%}
    {{ adapter.dispatch('prevalence', 'dbt_ml_eval')(actual, positive_label) }}
{%- endmacro -%}

{%- macro default__prevalence(actual, positive_label=1) -%}

    {{
        dbt_utils.safe_divide(
            "sum(case when " ~ actual ~ " = " ~ positive_label ~ " then 1 else 0 end)",
            "count(" ~ actual ~ ")"
        )
    }}

{%- endmacro -%}
