import csv
import time
import json
from typing import List, Dict
from kafka import KafkaProducer
from kafka.errors import KafkaTimeoutError

from ride import Ride
from settings import BOOTSTRAP_SERVERS, INPUT_DATA_PATH, KAFKA_TOPIC


class JsonProducer(KafkaProducer):
    def __init__(self, props: Dict[str, str]) -> None:

        self.producer = KafkaProducer(**props)

    @staticmethod
    def read_records(resource_path: str) -> List[Ride]:
        records = []
        try:
            with open(resource_path, 'r') as f:
                reader = csv.reader(f)
                header = next(reader)
                for row in reader:
                    records.append(Ride(arr=row))
        except FileNotFoundError as e:
            print(f"Error: file not found - {e}")
        except Exception as e:
            print(f"Error: {e}")
        return records

    def publish_rides(self, topic: str, messages: List[Ride]) -> None:
        for ride in messages:
            try:
                time.sleep(1)
                record = self.producer.send(topic=topic, key=ride.pu_location_id, value=ride)
                print('Record {} successfully produced at offset {}'.format(ride.pu_location_id, record.get().offset))
            except KafkaTimeoutError as e:
                print(f"Kafka error: {e}")


if __name__ == '__main__':
    config = {
        'bootstrap_servers': BOOTSTRAP_SERVERS,
        'key_serializer': lambda key: str(key).encode(),
        'value_serializer': lambda x: json.dumps(x.__dict__, default=str).encode('utf-8')
    }
    producer = JsonProducer(props=config)
    rides = producer.read_records(resource_path=INPUT_DATA_PATH)
    producer.publish_rides(topic=KAFKA_TOPIC, messages=rides)