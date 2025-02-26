set -eox pipefail

cleanup() {
    # kill all processes whose parent is this process
    pkill -P $$
}

for sig in INT QUIT HUP TERM; do
  trap "
    cleanup
    trap - $sig EXIT
    kill -s $sig "'"$$"' "$sig"
done
trap cleanup EXIT

export RAG_DATABASES_DIR=$(pwd)/databases
export LLM_SERVICE_URL="http://localhost:8081"
export API_URL="http://localhost:8080"
export MLFLOW_ENABLE_ARTIFACTS_PROGRESS_BAR=false
export MLFLOW_RECONCILER_DATA_PATH=$(pwd)/llm-service/reconciler/data

# start Qdrant vector DB
qdrant/qdrant & 2>&1

# start up the jarva
# scripts/startup_java.sh & 2>&1

# start Python backend
cd llm-service
mkdir -p $MLFLOW_RECONCILER_DATA_PATH
uv run fastapi run --reload --host 127.0.0.1 --port 8081 & 2>&1

# wait for the python backend to be ready
while ! curl --output /dev/null --silent --fail http://localhost:8081/amp-update; do
    echo "Waiting for the Python backend to be ready..."
    sleep 4
done

# start mlflow reconciler
uv run reconciler/mlflow_reconciler.py &

# start Node production server

cd ..

source scripts/load_nvm.sh > /dev/null

# cd ui
# node express/dist/index.js
