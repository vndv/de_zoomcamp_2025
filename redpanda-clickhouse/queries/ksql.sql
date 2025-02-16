CREATE STREAM ride_streams (
    VENDOR_ID varchar, 
    trip_distance double,
    payment_type varchar
)  WITH (KAFKA_TOPIC='rides_json',
        VALUE_FORMAT='JSON');

select * from RIDE_STREAMS 
EMIT CHANGES;

SELECT VENDOR_ID, count(*) FROM RIDE_STREAMS 
GROUP BY VENDOR_ID
EMIT CHANGES;

CREATE TABLE payment_type_sessions AS
  SELECT payment_type,
         count(*)
  FROM  RIDE_STREAMS 
  WINDOW SESSION (60 SECONDS)
  GROUP BY payment_type
  EMIT CHANGES;


select * from PAYMENT_TYPE_SESSIONS EMIT CHANGES;
