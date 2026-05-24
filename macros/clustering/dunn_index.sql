{%- macro dunn_index(table, feature_columns, cluster_column) -%}
    {{ adapter.dispatch('dunn_index', 'dbt_ml_eval')(table, feature_columns, cluster_column) }}
{%- endmacro -%}

{%- macro default__dunn_index(table, feature_columns, cluster_column) -%}

(
    with _points as (
        select
            row_number() over () as _row_id,
            {{ cluster_column }},
            {{ feature_columns | join(', ') }}
        from {{ table }}
    ),
    _pairwise as (
        select
            p1.{{ cluster_column }} as _cluster_i,
            p2.{{ cluster_column }} as _cluster_j,
            sqrt({% for col in feature_columns %}power(p1.{{ col }} - p2.{{ col }}, 2){% if not loop.last %} + {% endif %}{% endfor %}) as _dist
        from _points p1
        cross join _points p2
        where p1._row_id < p2._row_id
    ),
    _max_diameter as (
        select max(_dist) as _max_d
        from _pairwise
        where _cluster_i = _cluster_j
    ),
    _min_inter as (
        select min(_dist) as _min_d
        from _pairwise
        where _cluster_i != _cluster_j
    )
    select _min_d / nullif(_max_d, 0)
    from _max_diameter, _min_inter
)

{%- endmacro -%}
