# Cloud-1

## Introduction
- In this version, each process will have its container. 
- Deploy it using a container per process and automation.
- The deployment must be automated by Ansible.
- This complete web server must be able to run several services in parallels such as Wordpress, PHPmyadmin and a database.

## Mandatory part
https://www.youtube.com/watch?v=JZwHIytkyvI

1. Install the Azure CLI on Linux
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt

2. Setup Ansible on an Azure VM
https://docs.microsoft.com/en-us/azure/developer/ansible/install-on-linux-vm?tabs=azure-cli

3. Create an Azure service principal for Ansible
https://docs.microsoft.com/en-us/azure/developer/ansible/create-ansible-service-principal?tabs=azure-cli

https://docs.ansible.com/ansible/latest/scenario_guides/guide_azure.html

### ######################################################################################

1. install wordpress dockerfile
2. deploy wordpress + docker in azure with ansible 
3. wordpress in containers

### ######################################################################################

### Wordpress
- [ ] Install a simple WordPress site

- [ ] Your applications will run in separate containers that can communicate with each other (1 process = 1 container)
- [ ] The services will be the different components of a WordPress to install by yourself. For example Phpmyadmin, MySQL, ...
- [ ] You must therefore have a dedicated Dockerfile for each service

- [ ] Your site can restart automatically if the server is rebooted.
- [ ] In case of reboot all the data of the site are persisted (images, user accounts, articles, ...).
- [ ] You will need to ensure that your SQL database works with WordPress and PHPMyAdmin.
- [ ] Your server should be able, when possible, to use TLS.
- [ ] You will need to make sure that, depending on the URL requested, your server redirects to the correct site.
- [ ] Public access to your server must be limited and secure (for example, it is not possible to connect directly to your database from the internet).

### Deployment
- [ ] The deployment of your application must be fully automated.
- [ ] It is possible to deploy your site on several servers in parallel.
- [ ] The script must be able to function in an automated way with for only assumption an ubuntu 20.04 LTS like OS of the target instance running an SSH daemon and with Python installed.




### ######################################################################################

10. `hatchery` volume
```docker volume create --name hatchery```


12. `mysql` container
  - the container itself name -> `spawning-pool`
  - able to restart on its own in case of error
  - root password of the database -> `kerrigan`
  - that container create database named -> `zerglings`
  - database stored in the `hatchery` volume

```
docker run -d 
  --name spawning-pool 
  --restart=on-failure 
  -e MYSQL_ROOT_PASSWORD=Kerrigan 
  -e MYSQL_DATABASE=zerglings 
  -v hatchery:/var/lib/mysql
  --default-authentication-plugin=mysql_native_password
  mysql 
```
https://hub.docker.com/_/mysql

14. `wordpress` container
  - named -> `lair`
  - port 80 - 8080 VM
  - should use `spawning-pool` as a database service
  - try to access `lair` via URL

```
docker run -d 
  --name lair 
  -p 8080:80 
  --link spawning-pool:mysql
  wordpress
```
https://hub.docker.com/_/wordpress

15. `phpmyadmin` container
  - named -> `roach-warden`
  - port 80 - 8081 VM
  - able to explore database stored in `spowning-pool`

```
docker run -d
  --name roach-warden
  -p 8081:80 
  --link spawning-pool:db 
  phpmyadmin/phpmyadmin
```
https://hub.docker.com/r/phpmyadmin/phpmyadmin/
