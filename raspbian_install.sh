#!/bin/bash
apt-get update
apt-get upgrade
apt-get dist-upgrade
awk -F= '$1=="VERSION_CODENAME" { print $2 ;}' /etc/os-release
sudo apt-get -y install mosquitto mosquitto-clients 
cd /etc/mosquitto
sudo mosquitto_passwd -c /etc/mosquitto/pass mosquitto
# Enter password prompt
#https://bytesofgigabytes.com/mqtt/mqtt-username-password/ 
echo "allow_anonymous false" | sudo tee -a mosquitto.conf 
echo "password_file /etc/mosquitto/pass" | sudo tee -a mosquitto.conf
sudo service mosquitto stop
sudo service mosquitto start 
sudo apt install -y build-essential git
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
sudo systemctl enable nodered.service
cd $HOME/.node-red
npm i node-red-dashboard
curl https://raw.githubusercontent.com/robertmeisner/watering-machine-automation/main/node-red/data/flows.json > flows_raspberrypi.json
 
node-red-restart
echo "Please ..."
# jak znalezc logi?
#sudo find / -type d -name wateringStats 2>/dev/null