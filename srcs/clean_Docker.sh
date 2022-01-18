sudo docker stop $(sudo docker ps -aq)
sudo docker rm $(sudo docker ps -aq)
sudo docker rmi wordpress_nginx -f
sudo docker rmi wordpress_adminer -f
sudo docker rmi wordpress_wordpress -f
sudo docker rmi wordpress_mariadb -f
sudo docker rmi $(sudo docker images -aq)
sudo docker system prune -a --force
sudo docker volume rm $(sudo docker volume ls -q)
sudo rm -rf /home/issam/data
