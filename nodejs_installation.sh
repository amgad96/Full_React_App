#!/bin/bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
nvm install v20.15.1
node -v
npm -v
nvm use v20.15.1
