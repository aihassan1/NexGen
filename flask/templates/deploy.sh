#!/bin/bash
sudo apt-get update
sudo apt-get install python3-pip
sudo pip3 install virtualenv

# create the dirctiory and then the enviroment 
# mkdir NexGen -> cd NexGen

virtualenv venv
source venv/bin/activate
pip install flask
