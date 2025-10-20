{%- macro true_positives(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('true_positives', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__true_positives(actual, predicted, positive_label=1) -%}

    (
        sum(
            case
                when {{ predicted }} = {{ positive_label }}
                and {{ actual }} = {{ positive_label }} then 1
                else 0
            end
        )
    )

{%- endmacro -%}
