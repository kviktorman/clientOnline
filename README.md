# clientOnline general description

This is a simple client - server application. The client is running on a Linux distribution and executes a client deamon named "clientd". The daemon is starting after the network interface is ready. It sends the IP address and the MAC address of the client based on interface name.

The client side service and scripts are under the BashScript folder. The server side is under the php folder. Both side have log files under their log folder.

#Workflow 
Client sends the ip and mac to server as a JSON and server stores it into the log file.

# Server side installation
0. Pre requirements:
Installed and configured apache and php 

1. Copy the php folder content to your html webservice folder (from where you are going to host the page) 

2. Set script persmissions (php)

\> sudo chmod -R a+rw logs/

# Client side installation

0. Pre requirements:
Installed packages: curl, jq

Ubuntu: 

\> sudo apt install curl jq 

1. Create a folder : /opt/client-online 

\> sudo mkdir -p "/opt/client-online"

2. add rwx for the folder

\> sudo chmod -R a+rwx "/opt/client-online"

3. copy the whole BashScripts content to this folder.

4. Update the maintainerURL in the configuration file /opt/client-online/configuration/server.json

5. Give the required permissions

Set script persmissions (BashScripts)

\> sudo chmod a+x clientd.sh

\> sudo chmod a+x client-online.sh

\> sudo chmod a+rw logs/petia.out

6. From the /opt/client-online/etc folder move the service file where your distribution has the service files.

On Ubuntu 16.04 usually its /etc/systemd/system/

6. enable the daemon as a service

\> sudo systemctl enable clientd.service
