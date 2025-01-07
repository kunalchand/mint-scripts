# copy docker-compose.yml
scp /home/kunalchand/Desktop/Projects/trulogik-company/kafka-integration/docker-compose.yml postgresadmin@20.102.88.201:/home/postgresadmin/kafka/

# copy postgres-sink-connector.json
scp /home/kunalchand/Desktop/Projects/trulogik-company/kafka-integration/postgres-sink-connector.json postgresadmin@20.102.88.201:/home/postgresadmin/kafka/

# Check for "nobuild" argument (exact match)
nobuild_found=false
for arg in "$@"; do
  if [[ "$arg" == "nobuild" ]]; then
    nobuild_found=true
    break
  fi
done

if $nobuild_found; then
    echo "Skipping build process..."
else
    # go to kafka-integration and build the project
    cd /home/kunalchand/Desktop/Projects/trulogik-company/kafka-integration/
    mvn clean package
fi

# copy bundled jars
scp /home/kunalchand/Desktop/Projects/trulogik-company/kafka-integration/target/*.jar postgresadmin@20.102.88.201:/home/postgresadmin/kafka/kafka-connect-jars/

# Check for "keepopen" argument (exact match)
keepopen_found=false
for arg in "$@"; do
  if [[ "$arg" == "keepopen" ]]; then
    keepopen_found=true
    break
  fi
done

# Close terminal only if "keepopen" is NOT found
if ! $keepopen_found; then
    # get the PID of the terminal
    TERMINAL_PID=$(ps -o ppid= -p $$)
    # close terminal
    kill -9 "$TERMINAL_PID"
fi