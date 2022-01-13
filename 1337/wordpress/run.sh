#!/bin/bash

mkdir -p $HOME/data/DB
mkdir -p $HOME/data/WordPress
sudo docker-compose up --build
sudo docker-compose down -v
sudo rm -rf $HOME/data