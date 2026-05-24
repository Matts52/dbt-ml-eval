{%- macro inertia(table, feature_columns, cluster_column) -%}
    {{ adapter.dispatch('inertia', 'dbt_ml_eval')(table, feature_columns, cluster_column) }}
{%- endmacro -%}

{%- macro default__inertia(table, feature_columns, cluster_column) -%}

(
    with _centroids as (
        select
            {{ cluster_column }},
            {% for col in feature_columns %}avg({{ col }}) as _c_{{ col }}{% if not loop.last %}, {% endif %}{% endfor %}
        from {{ table }}
        group by {{ cluster_column }}
    )
    select sum({% for col in feature_columns %}power(p.{{ col }} - c._c_{{ col }}, 2){% if not loop.last %} + {% endif %}{% endfor %})
    from {{ table }} p
    join _centroids c on p.{{ cluster_column }} = c.{{ cluster_column }}
)

{%- endmacro -%}
