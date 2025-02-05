-- Macro for payment type description
{% macro get_payment_type_description(payment_type) %}
    CASE 
        WHEN {{ payment_type }} = 1 THEN 'Credit Card'
        WHEN {{ payment_type }} = 2 THEN 'Cash'
        WHEN {{ payment_type }} = 3 THEN 'No Charge'
        WHEN {{ payment_type }} = 4 THEN 'Dispute'
        WHEN {{ payment_type }} = 5 THEN 'Unknown'
        WHEN {{ payment_type }} = 6 THEN 'Voided Trip'
        ELSE 'Unknown'
    END
{% endmacro %}