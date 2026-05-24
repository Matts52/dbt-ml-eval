{%- set clustering_data = ref('clustering_25') -%}

select
    {{ dbt_ml_eval.dunn_index(
        table=clustering_data,
        feature_columns=['x', 'y'],
        cluster_column='cluster'
    ) }} as actual_25,
    14.71 as expected_25  -- two well-separated clusters yield very high Dunn Index (~14.71)
