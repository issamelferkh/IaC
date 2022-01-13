# Cloud-1 Todo

## 1. Setup Ansible on VM on Azure

## WordPress Resource Groupe
### Create WordPressResourceGroup

### Create wordpress App


## 2. Deploy WP 





- [x] 1. Setup Ansible on VM on Azure
  - [x] 1. Install AnsibleMaster VM on Azure
  - [x] 2. Install Azure CLI on Linux
  - [x] 3. Setup Ansible on AnsibleMaster VM - Connet to az - test fisrt playbook
  - [x] 4. Create an Azure service principal for Ansible
  - [x] 5. Create Azure credentials
  - [x] 6. Test Ansible installation

- [x] 2. Demo: Azure App Service WordPress Site | MySQL Container Instance
https://www.youtube.com/watch?v=OkPBtWzdfSk

- [ ] 3. Migrate custom software to Azure App Service using a custom container +++
  - https://docs.microsoft.com/en-us/azure/app-service/tutorial-custom-container?pivots=container-linux

- config env var in wordpress - mysql
  - https://www.youtube.com/watch?v=qxFgeTM9zOY

- Deploy existing Wordpress
  - https://www.youtube.com/watch?v=DDgeZ_J6fvw

- +++ Use persistent storage in Docker Compose +++
  - https://docs.microsoft.com/en-us/azure/app-service/configure-custom-container?pivots=container-linux#use-persistent-storage-in-docker-compose


- https://semaphoreci.com/community/tutorials/dockerizing-a-php-application#dockerfiles

# ##########################################################################
- Create clean playbook 
  - [x] Create resource group
  - [x] Create virtual network
  - [x] Add subnet
  - [x] Create public IP address
  - [x] Public IP of VM
  - [x] Create Network Security Group that allows SSH
  - [x] Create virtual network interface card
  - [x] Create VM
  - [x] Update VM
  - [x] Install Docker -> docker.yml
  - [x] Install python -> docker.yml

- look at ansible tree !

  - wordpress containers

- Create clean main playbook 

# ##########################################################################

## Correction

### Todo
- vm_playbook
  - Creat WP Resource Groupe
  - Create WPVM
    - Add port rules

- wp_playbook
  - Create hosts in WPVM
  - Install Docker, python and update


- deploy docker !!!



### Structure
- playbook
/home/issam/playbooks/hosts
  - hosts
  - vim secret.yml
  - vm_playbook.yml


20.127.25.229


52.168.80.224