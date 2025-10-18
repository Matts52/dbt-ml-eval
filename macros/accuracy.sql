{%- macro accuracy(actual, predicted) -%} 
    {{ adapter.dispatch('accuracy', 'dbt_ml_eval')(actual, predicted) }}
{%- endmacro -%}

{%- macro default__accuracy(actual, predicted) -%}

    {{
        dbt_utils.safe_divide(
            "sum(case when " ~ actual ~ " = " ~ predicted ~ " then 1 else 0 end)",
            "count(" ~ actual ~ ")"
        )
    }}

{%- endmacro -%}
