from typing import List, Dict
from decimal import Decimal
from datetime import datetime
import json


class Ride:
    def __init__(self, arr: List[str]):
        self.vendor_id = arr[0]
        self.tpep_pickup_datetime = datetime.strptime(arr[1], "%Y-%m-%d %H:%M:%S")
        self.tpep_dropoff_datetime = datetime.strptime(arr[2], "%Y-%m-%d %H:%M:%S")
        self.passenger_count = int(arr[3])
        self.trip_distance = Decimal(arr[4])
        self.rate_code_id = int(arr[5])
        self.store_and_fwd_flag = arr[6]
        self.pu_location_id = int(arr[7])
        self.do_location_id = int(arr[8])
        self.payment_type = arr[9]
        self.fare_amount = Decimal(arr[10])
        self.extra = Decimal(arr[11])
        self.mta_tax = Decimal(arr[12])
        self.tip_amount = Decimal(arr[13])
        self.tolls_amount = Decimal(arr[14])
        self.improvement_surcharge = Decimal(arr[15])
        self.total_amount = Decimal(arr[16])
        self.congestion_surcharge = Decimal(arr[17])

    @classmethod
    def from_dict(cls, d: Dict):
        return cls(arr=[
            d['vendor_id'],
            d['tpep_pickup_datetime'],
            d['tpep_dropoff_datetime'],
            str(d['passenger_count']),
            str(d['trip_distance']),
            str(d['rate_code_id']),
            d['store_and_fwd_flag'],
            str(d['pu_location_id']),
            str(d['do_location_id']),
            d['payment_type'],
            str(d['fare_amount']),
            str(d['extra']),
            str(d['mta_tax']),
            str(d['tip_amount']),
            str(d['tolls_amount']),
            str(d['improvement_surcharge']),
            str(d['total_amount']),
            str(d['congestion_surcharge']),
        ])

    def to_dict(self) -> Dict:
        """
        Преобразует объект Ride в словарь, пригодный для сериализации в JSON.
        """
        return {
            "vendor_id": self.vendor_id,
            "tpep_pickup_datetime": self.tpep_pickup_datetime.strftime("%Y-%m-%d %H:%M:%S"),
            "tpep_dropoff_datetime": self.tpep_dropoff_datetime.strftime("%Y-%m-%d %H:%M:%S"),
            "passenger_count": self.passenger_count,
            "trip_distance": float(self.trip_distance),
            "rate_code_id": self.rate_code_id,
            "store_and_fwd_flag": self.store_and_fwd_flag,
            "pu_location_id": self.pu_location_id,
            "do_location_id": self.do_location_id,
            "payment_type": self.payment_type,
            "fare_amount": float(self.fare_amount),
            "extra": float(self.extra),
            "mta_tax": float(self.mta_tax),
            "tip_amount": float(self.tip_amount),
            "tolls_amount": float(self.tolls_amount),
            "improvement_surcharge": float(self.improvement_surcharge),
            "total_amount": float(self.total_amount),
            "congestion_surcharge": float(self.congestion_surcharge),
        }

    def to_json(self) -> str:
        """
        Сериализует объект Ride в JSON-строку.
        """
        return json.dumps(self.to_dict(), indent=2)

    def __repr__(self):
        return f'{self.__class__.__name__}: {self.to_dict()}'