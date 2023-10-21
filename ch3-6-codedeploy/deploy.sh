#!/bin/bash

export NVM_DIR=$HOME/.nvm;
. $NVM_DIR/nvm.sh;

cd /home/ec2-user/amplify-cli
git pull origin main
npm install &&
npm run build &&
pm2 restart nextjs