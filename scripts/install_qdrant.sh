QDRANT_TGZ=qdrant.tar.gz
DL_URL="https://github.com/qdrant/qdrant/releases/download/v1.11.3/qdrant-x86_64-unknown-linux-musl.tar.gz"

mkdir qdrant 2>/dev/null
cd qdrant

## Install Qdrant ##
wget --no-verbose -O ${QDRANT_TGZ} ${DL_URL}
tar xzf ${QDRANT_TGZ} && rm ${QDRANT_TGZ}

