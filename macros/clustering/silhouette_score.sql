{%- macro silhouette_score(table, feature_columns, cluster_column) -%}
    {{ adapter.dispatch('silhouette_score', 'dbt_ml_eval')(table, feature_columns, cluster_column) }}
{%- endmacro -%}

{%- macro default__silhouette_score(table, feature_columns, cluster_column) -%}

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
            p1._row_id as _i,
            p1.{{ cluster_column }} as _cluster_i,
            p2.{{ cluster_column }} as _cluster_j,
            sqrt({% for col in feature_columns %}power(p1.{{ col }} - p2.{{ col }}, 2){% if not loop.last %} + {% endif %}{% endfor %}) as _dist
        from _points p1
        cross join _points p2
        where p1._row_id != p2._row_id
    ),
    _intra as (
        select _i, avg(_dist) as _a
        from _pairwise
        where _cluster_i = _cluster_j
        group by _i
    ),
    _inter_cluster as (
        select _i, _cluster_j, avg(_dist) as _mean_dist
        from _pairwise
        where _cluster_i != _cluster_j
        group by _i, _cluster_j
    ),
    _b_vals as (
        select _i, min(_mean_dist) as _b
        from _inter_cluster
        group by _i
    ),
    _silhouette as (
        select
            (_b._b - _a._a) / nullif(greatest(_a._a, _b._b), 0) as _s
        from _intra _a
        join _b_vals _b on _a._i = _b._i
    )
    select avg(_s) from _silhouette
)

{%- endmacro -%}
