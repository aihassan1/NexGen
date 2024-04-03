#!/bin/bash

# Update the package list and install the necessary packages
sudo apt-get update
sudo apt-get install python3-pip -y
sudo pip3 install virtualenv
pip install flask_sqlalchemy
sudo apt-get install pkg-config -y
sudo apt-get install libmysqlclient-dev -y

# Install mysqlclient, a Python DB API-2.0 compliant interface to MySQL
pip install mysqlclient

# create the dirctiory and then the enviroment
mkdir NexGen || exit
cd NexGen || exit

# clone the repo from github
git clone https://github.com/aihassan1/NexGen

# create virtual enviroment to
virtualenv venv
# shellcheck disable=SC1091
source venv/bin/activate

pip install flask

sudo apt install npm -y
npm install
pip install uwsgi

# create NexGen.ini file to configure the uwsgi server
cat >NexGen.ini <<EOF
[uwsgi]
module = NexGen:app
master = true
processes = 5
socket = /tmp/app.sock
chmod-socket = 666
vacuum = true
die-on-term = true
EOF

# create the nginx_conf file
cat >/etc/nginx/sites-available/NexGen.conf <<EOF
server {
        listen 80;
        server_name nexgen.code-castle.tech;



location / {
    include uwsgi_params;
    uwsgi_pass unix:/tmp/app.sock;
}

location /static {
    alias /home/ubuntu/NexGen/NexGen/flask/static;
}

}
EOF

# Enable the Nginx Configuration
sudo ln -s /etc/nginx/sites-available/NexGen.conf /etc/nginx/sites-enabled

sudo systemctl restart nginx

# Run uWSGI
uwsgi --ini NexGen.ini
