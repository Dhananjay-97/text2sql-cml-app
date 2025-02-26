set -ox pipefail

RAG_STUDIO_INSTALL_DIR="/home/cdsw/rag-studio"
DB_URL_LOCATION="jdbc:h2:file:~/rag-studio/databases/rag"
if [ -z "$IS_COMPOSABLE" ]; then
  RAG_STUDIO_INSTALL_DIR="/home/cdsw"
  DB_URL_LOCATION="jdbc:h2:file:~/databases/rag"
fi

export DB_URL=$DB_URL_LOCATION
export JAVA_ROOT=`ls ${RAG_STUDIO_INSTALL_DIR}/java-home`
export JAVA_HOME="${RAG_STUDIO_INSTALL_DIR}/java-home/${JAVA_ROOT}"

for i in {1..3}; do
  echo "Starting Java application..."
  "$JAVA_HOME"/bin/java -jar artifacts/rag-api.jar
  echo "Java application crashed, retrying ($i/3)..."
  sleep 5
done
#while ! curl --output /dev/null --silent --fail http://localhost:8080/api/v1/rag/dataSources; do
#    echo "Waiting for the Java backend to be ready..."
#    sleep 4
#done
