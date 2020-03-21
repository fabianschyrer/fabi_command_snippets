# Confluent Kafka

git clone https://github.com/confluentinc/examples
cd examples
git checkout 5.3.1-post
cd cp-all-in-one/
docker-compose ps


# Clone the git repository
git clone https://github.com/confluentinc/kafka-streams-examples.git

# Change into the directory for this tutorial
cd kafka-streams-examples/

# Switch to the `5.3.1-post` branch
git checkout 5.3.1-post

docker-compose up -d

curl -sXGET http://localhost:7070/kafka-music/instances

# You should see output similar to following, though here
# the output is pretty-printed so that it's easier to read:
[
  {
    "host": "localhost",
    "port": 7070,
    "storeNames": [
      "all-songs",
      "song-play-count",
      "top-five-songs",
      "top-five-songs-by-genre"
    ]
  }
]




curl -sXGET http://localhost:7070/kafka-music/charts/top-five

# You should see output similar to following, though here
# the output is pretty-printed so that it's easier to read:
[
  {
    "artist": "Jello Biafra And The Guantanamo School Of Medicine",
    "album": "The Audacity Of Hype",
    "name": "Three Strikes",
    "plays": 70
  },
  {
    "artist": "Hilltop Hoods",
    "album": "The Calling",
    "name": "The Calling",
    "plays": 67
  },

  ... rest omitted...
]


docker-compose down




# Example: Launch the WordCount demo application (inside the `kafka-music-application` container)
docker-compose exec kafka-music-application \
        java -cp /usr/share/java/kafka-streams-examples/kafka-streams-examples-5.3.1-standalone.jar \
        io.confluent.examples.streams.WordCountLambdaExample \
        kafka:29092



# Use the kafka-avro-console-consumer to read the "play-events" topic
docker-compose exec schema-registry \
    kafka-avro-console-consumer \
        --bootstrap-server kafka:29092 \
        --topic play-events --from-beginning

# You should see output similar to:
{"song_id":11,"duration":60000}
{"song_id":10,"duration":60000}
{"song_id":12,"duration":60000}
{"song_id":2,"duration":60000}
{"song_id":1,"duration":60000}




# Use the kafka-avro-console-consumer to read the "song-feed" topic
docker-compose exec schema-registry \
    kafka-avro-console-consumer \
        --bootstrap-server kafka:29092 \
        --topic song-feed --from-beginning

# You should see output similar to:
{"id":1,"album":"Fresh Fruit For Rotting Vegetables","artist":"Dead Kennedys","name":"Chemical Warfare","genre":"Punk"}
{"id":2,"album":"We Are the League","artist":"Anti-Nowhere League","name":"Animal","genre":"Punk"}
{"id":3,"album":"Live In A Dive","artist":"Subhumans","name":"All Gone Dead","genre":"Punk"}
{"id":4,"album":"PSI","artist":"Wheres The Pope?","name":"Fear Of God","genre":"Punk"}



# Create a new topic named "my-new-topic", using the `kafka` container
docker-compose exec kafka kafka-topics \
     --zookeeper zookeeper:32181 \
     --create --topic my-new-topic --partitions 2 --replication-factor 1

# You should see a line similar to:
Created topic "my-new-topic".



# List available topics, using the `kafka` container
docker-compose exec kafka kafka-topics \
    --zookeeper zookeeper:32181 \
    --list









sudo sysctl -w vm.max_map_count=9000000
sudo sysctl -w vm.max_map_count=10485760




