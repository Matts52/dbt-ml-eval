{%- macro jaccard_index(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('jaccard_index', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__jaccard_index(actual, predicted, positive_label=1) -%}

    {{
        dbt_utils.safe_divide(
            "sum(case when " ~ predicted ~ " = " ~ positive_label ~ " and " ~ actual ~ " = " ~ positive_label ~ " then 1 else 0 end)",
            "sum(case when " ~ predicted ~ " = " ~ positive_label ~ " or " ~ actual ~ " = " ~ positive_label ~ " then 1 else 0 end)"
        )
    }}

{%- endmacro -%}
