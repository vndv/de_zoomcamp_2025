--Create green_tripdata table

CREATE TABLE IF NOT EXISTS green_tripdata (
    VendorID String,
    lpep_pickup_datetime String,
    lpep_dropoff_datetime String,
    store_and_fwd_flag String,
    RatecodeID String,
    PULocationID String,
    DOLocationID String,
    passenger_count String,
    trip_distance String,
    fare_amount String,
    extra String,
    mta_tax String,
    tip_amount String,
    tolls_amount String,
    ehail_fee String,
    improvement_surcharge String,
    total_amount String,
    payment_type String,
    congestion_surcharge String,
    trip_type String
)
ENGINE = S3('http://object-store:9000/zoomcamp/zoomcamp_green_tripdata_2019-01.csv',
    'acces_key',
    'secret_key',
    'CSV')
SETTINGS 
    input_format_with_names_use_header = 1;


   
--Create yellow_tripdata table
CREATE TABLE IF NOT EXISTS yellow_tripdata (
    VendorID String,
    tpep_pickup_datetime String,
    tpep_dropoff_datetime String,
    passenger_count String,
    trip_distance String,
    RatecodeID String,
    store_and_fwd_flag String,
    PULocationID String,
    DOLocationID String,
    payment_type String,
    fare_amount String,
    extra String,
    mta_tax String,
    tip_amount String,
    tolls_amount String,
    improvement_surcharge String,
    total_amount String,
   congestion_surcharge String

)
ENGINE = S3('http://object-store:9000/zoomcamp/zoomcampyellow_tripdata_2019-01.csv',
    'acces_key',
    'secret_key',
    'CSV')
SETTINGS 
    input_format_with_names_use_header = 1;


   
SELECT * from s3('http://object-store:9000/zoomcamp/zoomcampyellow_tripdata_2019-01.csv', 'acces_key', 'secret_key' , 'CSV')