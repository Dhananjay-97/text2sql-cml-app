# Download and install nvm:
set +x

touch ~/.bashrc

# NVM installer updates bashrc if exists
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" > /dev/null  # This loads nvm
nvm install 22
nvm use 22

# Verify the Node.js version:
which node
node -v
nvm current

# Verify npm version:
which npm
npm -v
