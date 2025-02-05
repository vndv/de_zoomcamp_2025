-- SQLMesh model definition for ClickHouse

MODEL (
  name silver.yellow_tripdata,
  kind VIEW,
  cron '@daily',
  owner 'imatveev',
  start '2024-01-01',
  tags ['yellow']
);

WITH tripdata AS (
  SELECT 
    *,
    row_number() OVER (PARTITION BY VendorID, tpep_pickup_datetime) AS rn
  FROM bronze.yellow_tripdata
  WHERE VendorID IS NOT NULL
)

SELECT
    -- identifiers
    cityHash64(VendorID, tpep_pickup_datetime) AS tripid, -- Using ClickHouse's cityHash64 for surrogate key
    CAST(VendorID AS Int32) AS vendorid,
    CAST(RatecodeID AS Int32) AS ratecodeid,
    CAST(PULocationID AS Int32) AS pickup_locationid,
    CAST(DOLocationID AS Int32) AS dropoff_locationid,

    -- timestamps
    parseDateTimeBestEffort(tpep_pickup_datetime) AS pickup_datetime,
    parseDateTimeBestEffort(tpep_dropoff_datetime) AS dropoff_datetime,
    
    -- trip info
    store_and_fwd_flag,
    CAST(passenger_count AS Int32) AS passenger_count,
    CAST(trip_distance AS Float64) AS trip_distance,
    1 AS trip_type, -- yellow cabs are always street-hail
    
    -- payment info
    CAST(fare_amount AS Float64) AS fare_amount,
    CAST(extra AS Float64) AS extra,
    CAST(mta_tax AS Float64) AS mta_tax,
    CAST(tip_amount AS Float64) AS tip_amount,
    CAST(tolls_amount AS Float64) AS tolls_amount,
    CAST(0 AS Float64) AS ehail_fee, -- ehail_fee is always 0 for yellow cabs
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
    toDate(tpep_pickup_datetime) as pickup_date
FROM tripdata
WHERE rn = 1