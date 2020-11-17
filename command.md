Node Red
docker run -it -p 1880:1880 -v c:\storage\node-red\data:/data --name mynodered nodered/node-red


Mosquitto
set up:
https://hometechhacker.com/mqtt-using-docker-and-home-assistant/
http://www.steves-internet-guide.com/mqtt-username-password-example/


sudo docker run -itd --name=mqtt --restart=always --net=host -v /storage/mosquitto/config:/mqtt/config:ro -v /storage/mosquitto/data:/mqtt/data -v /storage/mosquitto/log:/mqtt/log toke/mosquitto


Docker
https://stackoverflow.com/questions/46907558/docker-compose-relative-paths-vs-docker-volume

