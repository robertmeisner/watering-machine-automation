#!/bin/bash
#https://www.noip.com/support/knowledgebase/install-ip-duc-onto-raspberry-pi/ 
mkdir /home/pi/noip
cd /home/pi/noip
wget https://www.noip.com/client/linux/noip-duc-linux.tar.gz
tar vzxf noip-duc-linux.tar.gz
cd noip-2.1.9-1
sudo make
#After typing “sudo make install” you will be prompted to login with your No-IP account username and password.
#After logging into the DUC answer the questions to proceed. When asked how often you want the update to happen you must choose 5 or more. The interval is listed in minutes, if you choose 5 the update interval will be 5 minutes. If you choose 30 the interval will be 30 minutes.
sudo make install
sudo /usr/local/bin/noip2
sudo noip2 ­-S (Capital “S”)