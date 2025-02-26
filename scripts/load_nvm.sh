set -o pipefail
set +x

touch ~/.bashrc
# shellcheck disable=SC1090
source ~/.bashrc > /dev/null