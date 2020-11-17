t can sometimes be useful to populate a Node-RED Docker image with files from a local directory (for example, if you want a whole project to be kept in a git repo). To do this, you’ll want your local directory to look like this:

Dockerfile
README.md
package.json     # add any extra nodes your flow needs into your own package.json.
flows.json       # the normal place Node-RED store your flows
flows_cred.json  # credentials your flows may need
settings.js      # your settings file
NOTE: This method is NOT suitable if you want to mount the /data volume externally. If you need to use an external volume for persistence then copy your settings and flows files to that volume instead.

The following Dockerfile builds on the base Node-RED Docker image, but additionally moves your own files into place into that image:

FROM nodered/node-red

# Copy package.json to the WORKDIR so npm builds all
# of your added nodes modules for Node-RED
COPY package.json .
RUN npm install --unsafe-perm --no-update-notifier --no-fund --only=production

# Copy _your_ Node-RED project files into place
# NOTE: This will only work if you DO NOT later mount /data as an external volume.
#       If you need to use an external volume for persistence then
#       copy your settings and flows files to that volume instead.
COPY settings.js /data/settings.js
COPY flows_cred.json /data/flows_cred.json
COPY flows.json /data/flows.json

# You should add extra nodes via your package.json file but you can also add them here:
#WORKDIR /usr/src/node-red
#RUN npm install node-red-node-smooth
Dockerfile order and build speed
While not necessary, it’s a good idea to do the COPY package... npm install... steps early because, although the flows.json changes frequently as you work in Node-RED, your package.json will only change when you change what modules are part of your project. And since the npm install step that needs to happen when package.json changes can sometimes be time consuming, it’s better to do the time-consuming, generally-unchanging steps earlier in a Dockerfile so those build images can be reused, making subsequent overall builds much faster.

Credentials, secrets, and environment variables
Of course you never want to hard-code credentials anywhere, so if you need to use credentials with your Node-RED project, the above Dockerfile will let you have this in your settings.js…

module.exports = {
  credentialSecret: process.env.NODE_RED_CREDENTIAL_SECRET // add exactly this
}
…and then when you run in Docker, you add an environment variable to your run command…

docker run -e "NODE_RED_CREDENTIAL_SECRET=your_secret_goes_here"

Building and running
You build this Dockerfile normally:

docker build -t your-image-name:your-tag .
To run locally for development where changes are written immediately and only the local directory that you are working from, cd into the project’s directory and then run:

docker run --rm -e "NODE_RED_CREDENTIAL_SECRET=your_secret_goes_here" -p 1880:1880 -v `pwd`:/data --name a-container-name your-image-name