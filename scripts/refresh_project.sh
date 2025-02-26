set -eox pipefail

## set the RELEASE_TAG env var from the file, if it exists
source scripts/release_version.txt || true


set +e
source scripts/load_nvm.sh > /dev/null
nvm use 22
return_code=$?
set -e
if [ $return_code -ne 0 ]; then
    echo "NVM or required Node version not found.  Installing and using..."
    bash scripts/install_node.sh
    source scripts/load_nvm.sh > /dev/null

    nvm use 22
fi
# cd ui/express
# npm install

cd ../../llm-service

set +e
uv --version
return_code=$?
set -e
if [ $return_code -ne 0 ]; then
  pip install uv
fi
uv sync --no-dev

cd ..
mkdir -p artifacts

## Clone the new repository
REPO_URL="https://github.com/Dhananjay-97/cml-app.git"
TARGET_DIR="cml-app"

if [ -d "$TARGET_DIR" ]; then
    echo "Repository already exists. Pulling latest changes..."
    cd "$TARGET_DIR"
    git pull origin main
else
    echo "Cloning repository from $REPO_URL..."
    git clone "$REPO_URL"
fi

# RELEASE_URL=https://github.com/cloudera/CML_AMP_RAG_Studio/releases/latest/download
# if  [ -n "${RELEASE_TAG}" ] && [ "${RELEASE_TAG}" != "latest" ]; then
#     RELEASE_URL=https://github.com/cloudera/CML_AMP_RAG_Studio/releases/download/${RELEASE_TAG}
# fi

# echo "Downloading release artifacts from ${RELEASE_URL}"
# wget "${RELEASE_URL}/rag-api.jar" -O artifacts/rag-api.jar
# wget "${RELEASE_URL}/fe-dist.tar.gz" -O artifacts/fe-dist.tar.gz

# # unzip the frontend tarball
# cd ui
# tar -xzf ../artifacts/fe-dist.tar.gz
