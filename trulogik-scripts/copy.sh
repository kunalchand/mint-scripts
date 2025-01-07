# copy docker-compose.yml
scp /home/kunalchand/Desktop/Projects/trulogik-company/kafka-integration/docker-compose.yml postgresadmin@20.102.88.201:/home/postgresadmin/kafka/

# copy postgres-sink-connector.json
scp /home/kunalchand/Desktop/Projects/trulogik-company/kafka-integration/postgres-sink-connector.json postgresadmin@20.102.88.201:/home/postgresadmin/kafka/

# # go to kafka-integration and build the project
cd /home/kunalchand/Desktop/Projects/trulogik-company/kafka-integration/
mvn clean package

# copy bundled jars
scp /home/kunalchand/Desktop/Projects/trulogik-company/kafka-integration/target/*.jar postgresadmin@20.102.88.201:/home/postgresadmin/kafka/kafka-connect-jars/
