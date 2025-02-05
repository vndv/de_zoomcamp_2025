MODEL (
  name silver.green_tripdata,
  kind INCREMENTAL_BY_TIME_RANGE (
    time_column pickup_date,
  ),
  cron '@daily',
  grain tripid,
  audits (
    UNIQUE_VALUES(columns = (tripid)),
    NOT_NULL(columns = (vendorid))
  ),
  owner 'imatveev',
  start '2023-01-01',
  tags ['green']
);



SELECT
    -- identifiers
    cityHash64(VendorID, lpep_pickup_datetime) AS tripid,  -- Use ClickHouse's cityHash64
    CAST(VendorID AS Int32) AS vendorid,
    CAST(RatecodeID AS Int32) AS ratecodeid,
    CAST(PULocationID AS Int32) AS pickup_locationid,
    CAST(DOLocationID AS Int32) AS dropoff_locationid,
    
    -- timestamps
    parseDateTimeBestEffort(lpep_pickup_datetime) AS pickup_datetime,
    parseDateTimeBestEffort(lpep_dropoff_datetime) AS dropoff_datetime,
    
    -- trip info
    store_and_fwd_flag,
    CAST(passenger_count AS Int32) AS passenger_count,
    CAST(trip_distance AS Float64) AS trip_distance,
    CAST(trip_type AS Int32) AS trip_type,

    -- payment info
    CAST(fare_amount AS Float64) AS fare_amount,
    CAST(extra AS Float64) AS extra,
    CAST(mta_tax AS Float64) AS mta_tax,
    CAST(tip_amount AS Float64) AS tip_amount,
    CAST(tolls_amount AS Float64) AS tolls_amount,
    CAST(ehail_fee AS Float64) AS ehail_fee,
    CAST(improvement_surcharge AS Float64) AS improvement_surcharge,
    CAST(total_amount AS Float64) AS total_amount,
    coalesce(CAST(payment_type AS Int32), 0) AS payment_type,
    CASE 
        WHEN payment_type = 1 THEN 'Credit Card'
        WHEN payment_type = 2 THEN 'Cash'
        WHEN payment_type = 3 THEN 'No Charge'
        WHEN payment_type = 4 THEN 'Dispute'
        WHEN payment_type = 5 THEN 'Unknown'
        WHEN payment_type = 6 THEN 'Voided Trip'
        ELSE 'Unknown'
    END AS payment_type_description,
    toDate(lpep_pickup_datetime) as pickup_date
FROM bronze.green_tripdata
WHERE toDate(lpep_pickup_datetime) BETWEEN @start_ds AND @end_ds 