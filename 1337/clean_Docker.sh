sudo docker stop $(sudo docker ps -a)
sudo docker rm $(sudo docker ps -a)
docker system prune -a --force
sudo docker volume rm $(sudo docker volume ls -q)
sudo rm -rf /home/issam/data
