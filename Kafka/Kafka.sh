# Kafka

git clone https://github.com/wurstmeister/kafka-docker.git
docker-compose up -d
docker-compose scale kafka=3


docker pull kafkamanager/kafka-manager
docker run -d --network kafkadocker_default -e ZK_HOSTS=172.18.0.3 -p 9000:9000 kafkamanager/kafka-manager


