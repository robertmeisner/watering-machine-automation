#!/bin/bash
cd $HOME/.node-red
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
node-red-stop
curl https://raw.githubusercontent.com/robertmeisner/watering-machine-automation/main/node-red/data/flows.json > flows.json
node-red-restart
