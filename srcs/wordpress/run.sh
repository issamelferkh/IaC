#!/bin/bash

mkdir -p /home/issam/data/DB
mkdir -p /home/issam/data/WordPress
sudo docker-compose up --build
sudo docker-compose down -v
sudo rm -rf /home/issam/data