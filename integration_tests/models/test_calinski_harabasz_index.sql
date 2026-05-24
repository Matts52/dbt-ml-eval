{%- set clustering_data = ref('clustering_25') -%}

select
    {{ dbt_ml_eval.calinski_harabasz_index(
        table=clustering_data,
        feature_columns=['x', 'y'],
        cluster_column='cluster'
    ) }} as actual_25,
    8880.25 as expected_25  -- two well-separated clusters yield very high CHI (~8880.25)
