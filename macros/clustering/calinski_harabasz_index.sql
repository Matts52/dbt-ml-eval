{%- macro calinski_harabasz_index(table, feature_columns, cluster_column) -%}
    {{ adapter.dispatch('calinski_harabasz_index', 'dbt_ml_eval')(table, feature_columns, cluster_column) }}
{%- endmacro -%}

{%- macro default__calinski_harabasz_index(table, feature_columns, cluster_column) -%}

(
    with _global as (
        select
            {% for col in feature_columns %}avg({{ col }}) as _g_{{ col }}{% if not loop.last %}, {% endif %}{% endfor %},
            count(*) as _n
        from {{ table }}
    ),
    _cluster_stats as (
        select
            {{ cluster_column }},
            {% for col in feature_columns %}avg({{ col }}) as _c_{{ col }}{% if not loop.last %}, {% endif %}{% endfor %},
            count(*) as _n_k
        from {{ table }}
        group by {{ cluster_column }}
    ),
    _k as (
        select count(distinct {{ cluster_column }}) as _k
        from {{ table }}
    ),
    _bcss as (
        select sum(_n_k * ({% for col in feature_columns %}power(_c_{{ col }} - _g_{{ col }}, 2){% if not loop.last %} + {% endif %}{% endfor %})) as _bcss
        from _cluster_stats
        cross join _global
    ),
    _wcss as (
        select sum({% for col in feature_columns %}power(p.{{ col }} - c._c_{{ col }}, 2){% if not loop.last %} + {% endif %}{% endfor %}) as _wcss
        from {{ table }} p
        join _cluster_stats c on p.{{ cluster_column }} = c.{{ cluster_column }}
    )
    select
        {{ dbt_utils.safe_divide(
            "(_bcss / nullif(_k - 1, 0))",
            "(_wcss / nullif(_n - _k, 0))"
        ) }}
    from _bcss, _wcss, _k, _global
)

{%- endmacro -%}
