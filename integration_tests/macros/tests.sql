{% test assert_close(model, actual, expected, decimal_place=2) %}
    select * from {{ model }} where round({{ actual }}::numeric, {{ decimal_place}}) != round({{ expected }}::numeric, {{ decimal_place }})
{% endtest %}
