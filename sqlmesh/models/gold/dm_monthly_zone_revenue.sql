MODEL (
  name gold.dm_monthly_zone_revenue,
  kind VIEW,
  cron '@daily',
  owner 'imatveev',
  start '2023-01-01',
  tags ['fact']
);

WITH trips_data AS (
  SELECT
    *
  FROM gold.fact_trips
)
SELECT
  pickup_zone AS revenue_zone, /* Reveneue grouping */
  toMonth(pickup_datetime) AS revenue_month,
  service_type,
  sum(fare_amount) AS revenue_monthly_fare, /* Revenue calculation */
  sum(extra) AS revenue_monthly_extra,
  sum(mta_tax) AS revenue_monthly_mta_tax,
  sum(tip_amount) AS revenue_monthly_tip_amount,
  sum(tolls_amount) AS revenue_monthly_tolls_amount,
  sum(ehail_fee) AS revenue_monthly_ehail_fee,
  sum(improvement_surcharge) AS revenue_monthly_improvement_surcharge,
  sum(total_amount) AS revenue_monthly_total_amount,
  count(tripid) AS total_monthly_trips, /* Additional calculations */
  avg(passenger_count) AS avg_monthly_passenger_count,
  avg(trip_distance) AS avg_monthly_trip_distance
FROM trips_data
GROUP BY
  1,
  2,
  3