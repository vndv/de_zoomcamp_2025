KAFKA=kafka-compose.yml
PANDA=redpanda-compose.yml
COMPOSE=docker compose -f docker-compose.yml -f

.PHONY: produce
produce:
	python3 scripts/producer.py

.PHONY: consume
consume:
	python3 scripts/consumer.py

.PHONY: kafka-up
kafka-up:
	@ ${COMPOSE} ${KAFKA} up -d

.PHONY: kafka-down
kafka-down:
	@ ${COMPOSE} ${KAFKA} down

.PHONY: kafka-data-down
kafka-data-down:
	@ ${COMPOSE} ${KAFKA} down -v

.PHONY: redpanda-up
redpanda-up:
	@ ${COMPOSE} ${PANDA} up -d

.PHONY: redpanda-down
redpanda-down:
	@ ${COMPOSE} ${PANDA} down

.PHONY: redpanda-data-down
redpanda-data-down:
	@ ${COMPOSE} ${PANDA} down -v