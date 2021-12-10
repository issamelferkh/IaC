# Cloud-1

## Setup Ansible VM on Azure
### [x] 1. Install AnsibleMaster VM on Azure
- Resource: https://docs.microsoft.com/en-us/azure/developer/ansible/install-on-linux-vm?tabs=azure-cli

1. Create an Azure resource group
- `az group create --name QuickstartAnsible-rg --location eastus`

2. Create the Azure virtual machine for Ansible named `AnsibleMaster`
``` bash
az vm create \
--resource-group QuickstartAnsible-rg \
--name QuickstartAnsible-vm \
--image OpenLogic:CentOS:7.7:latest \
--admin-username azureuser \
--admin-password <password>
```

3. Get the public Ip address of the Azure virtual machine
- `az vm show -d -g QuickstartAnsible-rg -n QuickstartAnsible-vm --query publicIps -o tsv`

4. Connect to your virtual machine via SSH
- `ssh -i AnsibleMaster_key.pem issam@104.40.216.202`

### [x] 2. Install Azure CLI on Linux
- Resource: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt

1. Get packages needed for the install process
- `sudo apt-get update`
- `sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg`

2. Download and install the Microsoft signing key
- `curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null`

3. Add the Azure CLI software repository
- `AZ_REPO=$(lsb_release -cs)`
- `echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list`

4. Update repository information and install the azure-cli package
- `sudo apt-get update`
- `sudo apt-get install azure-cli`

### [x] 3. Setup Ansible on an Azure VM - Connet to az - test fisrt playbook
- Resource: https://docs.microsoft.com/en-us/azure/developer/ansible/install-on-linux-vm?tabs=azure-cli

1. Update all packages that have available updates
- `sudo apt update -y`

2. Install Python 3 and pip.
- `sudo apt install python3-pip`

3. Upgrade pip3.
- `sudo pip3 install --upgrade pip`

4. Install Ansible.
sudo apt install ansible

5. Install Ansible azure_rm module for interacting with Azure.
- `pip3 install ansible[azure]`



### [x] 4. Create an Azure service principal for Ansible
- Resource: https://docs.microsoft.com/en-us/azure/developer/ansible/create-ansible-service-principal?tabs=azure-cli
1. login to az using browser
- `az login`

2. Create an Azure service principal
- ` az ad sp create-for-rbac --name ansible `
  - output
  {
    "appId": "2694c38f-6fd6-4532-be62-da4eb14ce1b3",
    "displayName": "ansible",
    "name": "2694c38f-6fd6-4532-be62-da4eb14ce1b3",
    "password": "9JKZ7GJp~q.qL4jHqI7aEUYVDhqdnOHP61",
    "tenant": "6c18d021-5aa7-47b1-9864-56bee5390cc9"
  }

3. Assign a role to the Azure service principal
- `az role assignment create --assignee <appID> --role Contributor`
  - output 
  {
    "canDelegate": null,
    "condition": null,
    "conditionVersion": null,
    "description": null,
    "id": "/subscriptions/6457318c-3043-4126-9d39-f782e3503899/providers/Microsoft.Authorization/roleAssignments/503ee595-865d-47e2-a776-69662046ac40",
    "name": "503ee595-865d-47e2-a776-69662046ac40",
    "principalId": "2e87b30a-b2af-427d-8b6f-16489813cbdb",
    "principalName": "2694c38f-6fd6-4532-be62-da4eb14ce1b3",
    "principalType": "ServicePrincipal",
    "roleDefinitionId": "/subscriptions/6457318c-3043-4126-9d39-f782e3503899/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c",
    "roleDefinitionName": "Contributor",
    "scope": "/subscriptions/6457318c-3043-4126-9d39-f782e3503899",
    "type": "Microsoft.Authorization/roleAssignments"
  }

4. Get Azure service principal information
- `az account show --query '{tenantId:tenantId,subscriptionid:id}';`
- `az ad sp list --display-name ansible --query '{clientId:[0].appId}'`

### [x] 5. Create Azure credentials
- Resource: https://docs.microsoft.com/en-us/azure/developer/ansible/install-on-linux-vm?tabs=azure-powershell%2Cansible%2Cazure-cli#create-azure-credentials

1. Create Ansible credentials file named `credentials`
- `vim ~/.azure/credentials`
2. Insert the following lines into the file, 
```
  [default]
  subscription_id=<your-subscription_id>
  client_id=<security-principal-appid>
  secret=<security-principal-password>
  tenant=<security-principal-tenant>
```

### [ ] 6. Test Ansible installation
Resource: https://docs.microsoft.com/en-us/azure/developer/ansible/install-on-linux-vm?tabs=azure-cli#test-ansible-installation

1. Option 1: Use an ad-hoc ansible command
- Create Azure Resource Groupe
- `ansible localhost -m azure_rm_resourcegroup -a "name=test1234 location=uksouth"`

- Delete Azure Resource Groupe
- `ansible localhost -m azure_rm_resourcegroup -a "name=test1234 location=uksouth state=absent"`

2. Option 2: Write and run an Ansible playbook
- create Azure Resource Group
- `ansible localhost -m azure_rm_resourcegroup -a "name=Testing location=uksouth"`

- Create Ansible Playbook file to create new VM on Azure
- vim `azure_vm.yml`



ansible-playbook azure_vm.yml
cat azure_vm.yml
ssh youtubedemo@IP_ADDRESS


## Create Containers with Ansible on Azure

https://docs.ansible.com/ansible/latest/collections/azure/azcollection/azure_rm_containerinstance_module.html
https://docs.microsoft.com/en-us/azure/app-service/tutorial-multi-container-app#code-try-5
https://www.youtube.com/watch?v=OkPBtWzdfSk
https://www.youtube.com/watch?v=nzyLC3ERPt8 +++ 




### ######################################################################################



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


if (NBR != 125)


if (!NBR)