{% macro generate_surrogate_key(fields) %}
    cityHash64({{ fields | join(', ') }})
{% endmacro %}