# NiFi

---
version: '2'
services:
  zookeeper:
    image: confluentinc/cp-zookeeper:latest
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181
      ZOOKEEPER_TICK_TIME: 2000

  kafka:
    # "`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-
    # An important note about accessing Kafka from clients on other machines: 
    # -----------------------------------------------------------------------
    #
    # The config used here exposes port 9092 for _external_ connections to the broker
    # i.e. those from _outside_ the docker network. This could be from the host machine
    # running docker, or maybe further afield if you've got a more complicated setup. 
    # If the latter is true, you will need to change the value 'localhost' in 
    # KAFKA_ADVERTISED_LISTENERS to one that is resolvable to the docker host from those 
    # remote clients
    #
    # For connections _internal_ to the docker network, such as from other services
    # and components, use kafka:29092.
    #
    # See https://rmoff.net/2018/08/02/kafka-listeners-explained/ for details
    # "`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-'"`-._,-
    #
    image: confluentinc/cp-kafka:latest
    depends_on:
      - zookeeper
    ports:
      - 9092:9092
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:29092,PLAINTEXT_HOST://localhost:9092
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT
      KAFKA_INTER_BROKER_LISTENER_NAME: PLAINTEXT
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
  nifi:
    image: apache/nifi:latest
    ports:
      - 8080:8080


docker-compose up
localhost:8080/nifi

