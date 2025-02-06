MODEL (
  name silver.green_tripdata,
  kind INCREMENTAL_BY_TIME_RANGE (
    time_column pickup_date
  ),
  storage_format ReplacingMergeTree,
  physical_properties (
        order_by = (tripid)
    ),
  cron '@daily',
  grain tripid,
  audits (UNIQUE_VALUES(columns = (
      tripid
    )), NOT_NULL(columns = (
      vendorid
  ))),
  owner 'imatveev',
  start '2023-01-01',
  tags ['green']
);


SELECT
  cityHash64(VendorID, lpep_pickup_datetime) AS tripid, /* identifiers */ /* Use ClickHouse's cityHash64 */
  VendorID::Int32 AS vendorid,
  RatecodeID::Int32 AS ratecodeid,
  PULocationID::Int32 AS pickup_locationid,
  DOLocationID::Int32 AS dropoff_locationid,
  parseDateTimeBestEffort(lpep_pickup_datetime) AS pickup_datetime, /* timestamps */
  parseDateTimeBestEffort(lpep_dropoff_datetime) AS dropoff_datetime,
  store_and_fwd_flag, /* trip info */
  passenger_count::Int32 AS passenger_count,
  trip_distance::Float64 AS trip_distance,
  trip_type::Int32 AS trip_type,
  fare_amount::Float64 AS fare_amount, /* payment info */
  extra::Float64 AS extra,
  mta_tax::Float64 AS mta_tax,
  tip_amount::Float64 AS tip_amount,
  tolls_amount::Float64 AS tolls_amount,
  ehail_fee::Float64 AS ehail_fee,
  improvement_surcharge::Float64 AS improvement_surcharge,
  total_amount::Float64 AS total_amount,
  coalesce(payment_type::Int32, 0) AS payment_type,
  CASE
    WHEN payment_type = 1
    THEN 'Credit Card'
    WHEN payment_type = 2
    THEN 'Cash'
    WHEN payment_type = 3
    THEN 'No Charge'
    WHEN payment_type = 4
    THEN 'Dispute'
    WHEN payment_type = 5
    THEN 'Unknown'
    WHEN payment_type = 6
    THEN 'Voided Trip'
    ELSE 'Unknown'
  END AS payment_type_description,
  toDate(lpep_pickup_datetime) AS pickup_date
FROM bronze.green_tripdata
WHERE
toDate(lpep_pickup_datetime) BETWEEN @start_ds AND @end_ds