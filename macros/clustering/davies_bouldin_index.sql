{%- macro davies_bouldin_index(table, feature_columns, cluster_column) -%}
    {{ adapter.dispatch('davies_bouldin_index', 'dbt_ml_eval')(table, feature_columns, cluster_column) }}
{%- endmacro -%}

{%- macro default__davies_bouldin_index(table, feature_columns, cluster_column) -%}

(
    with _centroids as (
        select
            {{ cluster_column }},
            {% for col in feature_columns %}avg({{ col }}) as _c_{{ col }}{% if not loop.last %}, {% endif %}{% endfor %}
        from {{ table }}
        group by {{ cluster_column }}
    ),
    _scatter as (
        select
            p.{{ cluster_column }},
            avg(sqrt({% for col in feature_columns %}power(p.{{ col }} - c._c_{{ col }}, 2){% if not loop.last %} + {% endif %}{% endfor %})) as _s
        from {{ table }} p
        join _centroids c on p.{{ cluster_column }} = c.{{ cluster_column }}
        group by p.{{ cluster_column }}
    ),
    _pairs as (
        select
            a.{{ cluster_column }} as _ci,
            (sa._s + sb._s) / nullif(sqrt({% for col in feature_columns %}power(a._c_{{ col }} - b._c_{{ col }}, 2){% if not loop.last %} + {% endif %}{% endfor %}), 0) as _r
        from _centroids a
        cross join _centroids b
        join _scatter sa on a.{{ cluster_column }} = sa.{{ cluster_column }}
        join _scatter sb on b.{{ cluster_column }} = sb.{{ cluster_column }}
        where a.{{ cluster_column }} != b.{{ cluster_column }}
    ),
    _max_r as (
        select _ci, max(_r) as _max_r
        from _pairs
        group by _ci
    )
    select avg(_max_r) from _max_r
)

{%- endmacro -%}
