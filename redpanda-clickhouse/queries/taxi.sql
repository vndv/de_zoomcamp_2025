CREATE database redpanda;


CREATE TABLE redpanda.trips (
    vendor_id String,
    tpep_pickup_datetime DateTime,
    tpep_dropoff_datetime DateTime,
    passenger_count UInt8,
    trip_distance Float32,
    rate_code_id UInt8,
    store_and_fwd_flag String,
    pu_location_id UInt16,
    do_location_id UInt16,
    payment_type String,
    fare_amount Float32,
    extra Float32,
    mta_tax Float32,
    tip_amount Float32,
    tolls_amount Float32,
    improvement_surcharge Float32,
    total_amount Float32,
    congestion_surcharge Float32
) ENGINE = MergeTree()
ORDER BY (vendor_id, tpep_pickup_datetime);


CREATE TABLE redpanda.trips_in (
    vendor_id String,
    tpep_pickup_datetime DateTime,
    tpep_dropoff_datetime DateTime,
    passenger_count UInt8,
    trip_distance Float32,
    rate_code_id UInt8,
    store_and_fwd_flag String,
    pu_location_id UInt16,
    do_location_id UInt16,
    payment_type String,
    fare_amount Float32,
    extra Float32,
    mta_tax Float32,
    tip_amount Float32,
    tolls_amount Float32,
    improvement_surcharge Float32,
    total_amount Float32,
    congestion_surcharge Float32
) ENGINE = Kafka() 
SETTINGS 
kafka_broker_list = 'kafka:9092',
kafka_topic_list = 'rides_json',
kafka_group_name = 'json-example',
kafka_format = 'JSONEachRow';


CREATE MATERIALIZED VIEW redpanda.trips_in_mv TO redpanda.trips
AS
SELECT *
FROM redpanda.trips_in
SETTINGS
materialized_views_ignore_errors = false;