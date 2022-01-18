# Cloud-1
Automated deployment of WP App on a remote server

## Introduction
The goal is to deploy a wordpress application and the necessary docker infrastructure on an instance provided by a cloud provider.

## Infrastructure as Code
- IaC use Ansible
- Cloud provider choose Azure

### Setup Ansible VM on Azure
#### 1. Install VM named AnsibleMaster on Azure
- Resource: https://docs.microsoft.com/en-us/azure/developer/ansible/install-on-linux-vm?tabs=azure-cli

1. Create an Azure resource group
`az group create --name AnsibleResourceGroup-rg --location eastus`

2. Create the Azure virtual machine for to setup Ansible named `AnsibleMaster`
``` bash
az vm create \
--resource-group AnsibleResourceGroup-rg \
--name AnsibleResourceGroup-vm \
--image OpenLogic:CentOS:7.7:latest \
--admin-username azureuser \
--admin-password <password>
```

3. Get the public Ip address of the Azure virtual machine
`az vm show -d -g AnsibleResourceGroup-rg -n AnsibleResourceGroup-vm --query publicIps -o tsv`

4. Connect to your virtual machine via SSH
`ssh -i AnsibleMasterKey.pem username@X.X.X.X`

#### 2. Install Azure CLI on Linux
- Resource: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt

1. Get packages needed for the install process
`sudo apt-get update`
`sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg`

2. Download and install the Microsoft signing key
`curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null`

3. Add the Azure CLI software repository
`AZ_REPO=$(lsb_release -cs)`
`echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list`

4. Update repository information and install the azure-cli package
`sudo apt-get update`
`sudo apt-get install azure-cli`

#### 3. Setup Ansible on AnsibleMaster VM - Connet to az - test fisrt playbook
- Resource: https://docs.microsoft.com/en-us/azure/developer/ansible/install-on-linux-vm?tabs=azure-cli

1. Update all packages that have available updates
`sudo apt update -y`

2. Install Python 3 and pip.
`sudo apt install python3-pip`

3. Upgrade pip3.
`sudo pip3 install --upgrade pip`

4. Install Ansible.
`sudo apt install ansible`

5. Install Ansible azure_rm module for interacting with Azure.
`pip3 install ansible[azure]`

#### 4. Create an Azure service principal for Ansible
- Resource: https://docs.microsoft.com/en-us/azure/developer/ansible/create-ansible-service-principal?tabs=azure-cli
1. login to az using browser
`az login`
  - output
  {
    "cloudName": "...",
    "homeTenantId": "...",
    "id": "...",
    "isDefault": true,
    "managedByTenants": [],
    "name": "...",
    "state": "Enabled",
    "tenantId": "...",
    "user": {
      "name": "...",
      "type": "user"
    }
  }

2. Create an Azure service principal

` az ad sp create-for-rbac --name ansible `
  - output
  {
    "appId": "...",
    "displayName": "ansible",
    "name": "...",
    "password": "...",
    "tenant": "..."
  }

3. Assign a role to the Azure service principal

`az role assignment create --assignee <appID> --role Contributor`
  - output 
  {
    "canDelegate": null,
    "condition": null,
    "conditionVersion": null,
    "description": null,
    "id": "...",
    "name": "...",
    "principalId": "...",
    "principalName": "...",
    "principalType": "ServicePrincipal",
    "roleDefinitionId": "...",
    "roleDefinitionName": "Contributor",
    "scope": "...",
    "type": "..."
  }

4. Get Azure service principal information

`az account show --query '{tenantId:tenantId,subscriptionid:id}';`
  - output
  {
    "subscriptionid": "...",
    "tenantId": "..."
  }

`az ad sp list --display-name ansible --query '{clientId:[0].appId}'`
  - output
  {
    "clientId": "..."
  }

#### 5. Create Azure credentials
- Resource: https://docs.microsoft.com/en-us/azure/developer/ansible/install-on-linux-vm?tabs=azure-powershell%2Cansible%2Cazure-cli#create-azure-credentials

1. Create Ansible credentials file named `credentials`
`vim ~/.azure/credentials`
2. Insert the following lines into the file, 
```
  [default]
  subscription_id=<your-subscription_id>
  client_id=<security-principal-appid>
  secret=<security-principal-password>
  tenant=<security-principal-tenant>
```

#### 6. Test Ansible installation
Resource: https://docs.microsoft.com/en-us/azure/developer/ansible/install-on-linux-vm?tabs=azure-cli#test-ansible-installation

1. Option 1: Use an ad-hoc ansible command
- Create Azure Resource Groupe
`ansible localhost -m azure_rm_resourcegroup -a "name=test1234 location=uksouth"`

- Delete Azure Resource Groupe
`ansible localhost -m azure_rm_resourcegroup -a "name=test1234 location=uksouth state=absent"`

2. Option 2: Write and run an Ansible playbook
- create Azure Resource Group
`ansible localhost -m azure_rm_resourcegroup -a "name=Testing location=uksouth"`

- Create Ansible Playbook file to create new VM on Azure
- vim `azure_vm.yml`






## Create VM on Azure Cloud to deploy WordPress using Ansible Playbook

```yml
- name: Automated Deployment of WordPress WebSite
  hosts: localhost
  gather_facts: no
  tasks:

  - name: Create Resource Group named WordPressResourceGroup (ARG)
    azure_rm_resourcegroup:
      name: "{{ WordPressResourceGroupName }}"
      location: eastus

  - name: Create Virtual Network (VNet)
    azure_rm_virtualnetwork:
      resource_group: "{{ WordPressResourceGroupName }}"
      name: "{{ WP_VnetName }}"
      address_prefixes: "10.0.0.0/16"

  - name: Add subnet (VSubNet)
    azure_rm_subnet:
      resource_group: "{{ WordPressResourceGroupName }}"
      name: "{{ WP_SubnetName }}"
      address_prefix: "10.0.1.0/24"
      virtual_network: "{{ WP_VnetName }}"
 
  - name: Create Network Security Group that allows HTTP & HTTPs
    azure_rm_securitygroup:
      resource_group: "{{ WordPressResourceGroupName }}"
      name: "{{ WP_NSGName }}"
      rules:
        - name: HTTP
          protocol: Tcp
          destination_port_range: 80
          access: Allow
          priority: 1002
          direction: Inbound
        - name: HTTPs
          protocol: Tcp
          destination_port_range: 443
          access: Allow
          priority: 1003
          direction: Inbound

  - name: Create Virtual Network Interface Card (NIC)
    azure_rm_networkinterface:
      resource_group: "{{ WordPressResourceGroupName }}"
      name: "{{ WP_NICName }}"
      virtual_network: "{{ WP_VnetName }}"
      subnet: "{{ WP_SubnetName }}"
      public_ip_name: "{{ WP_PublicIPName }}"
      security_group: "{{ WP_NSGName }}"

  - name: Create Virtual Machine (VM)
    azure_rm_virtualmachine:
      resource_group: "{{ WordPressResourceGroupName }}"
      name: "{{ VMname }}"
      vm_size: Standard_DS1_v2
      admin_username: "{{ VM_admin_username }}"
      admin_password: "{{ VM_admin_password }}"
      ssh_password_enabled: true
      network_interfaces: "{{ WP_NICName }}"
      image:
        offer: 0001-com-ubuntu-server-focal
        publisher: canonical
        sku: '20_04-lts'
        version: latest
```

- Save and run `vm_playbook.yml` playbook using ansible vault to avoid hardcoded sensitive content
`ansible-playbook -e @secret.yml --ask-vault-pass vm_playbook.yml`

## Deploy WP app using Docker containers
### Clone WP app repo
- srcs
  - wordpress
    - adminer: (managing database content)
      - dockerfile: (adminer docker image)

    - mariadb: (database)
      - conf:
        - wp.sql: (exported db)
      - tools
        - script.sh: (setup db)
      Dockerfile: (mariadb docker image)

    - nginx (web server)
      - default.conf: (nginex config file)
      - Dockerfile: (nginx docekr image)

    - wordpress (App config)
      - conf:
        - wp-config.php: (config file)
      - tools:
        - script.sh:
      - dockerfile
    - docker-compose.yml: (build and run all containers)

### Config Inventory file
```
[WPVM]
@IP   ansible_ssh_user=usename    ansible_ssh_pass=password
```
### Create WP deploy playbook
``` yml
- name: Allow SSH
  hosts: localhost
  gather_facts: no
  tasks:

  - name: Create Network Security Group that allows SSH (NSG)
    azure_rm_securitygroup:
      resource_group: "{{ WordPressResourceGroupName }}"
      name: "{{ WP_NSGName }}"
      rules:
        - name: SSH
          protocol: Tcp
          destination_port_range: 22
          access: Allow
          priority: 1001
          direction: Inbound

- name: Auto Deploy WP
  hosts: [WPVM]
  gather_facts: no
  become: yes
  tasks:
    - name: Update WPVM OS
      command: apt update -y 

    - name: Install python3
      package:
       name: python3
       state: present

    - name: Install docker
      apt:
        name: python3-pip, docker.io, docker-compose
        state: present

    - name: Start docker service
      service:
        name: docker
        state: started

    - name: Install docker python module
      pip:
        name: docker

    - name: Clone WordPress repo
      ansible.builtin.git:
        repo: https://github.com/issamelferkh/wp_auto_deploy.git
        dest: /home/issam/cloud_1

    - name: Create Data folder for volumes if not exist
      ansible.builtin.file:
        path: /home/issam/data
        owner: issam
        group: issam
        state: directory
        mode: '0755'

    - name: Create Data folder for volumes if not exist
      ansible.builtin.file:
        path: /home/issam/data/DB
        owner: issam
        group: issam
        state: directory
        mode: '0755'

    - name: Create Data folder for volumes if not exist
      ansible.builtin.file:
        path: /home/issam/data/WordPress
        owner: issam
        group: issam
        state: directory
        mode: '0755'

    - name: Execute run script to deploy wp docker containers
      shell:
        chdir: /home/issam/cloud_1/wordpress/
        cmd: "docker-compose up -d --build"

- name: Deny SSH
  hosts: localhost
  gather_facts: no
  tasks:

  - name: Create Network Security Group that Denys SSH (NSG)
    azure_rm_securitygroup:
      resource_group: "{{ WordPressResourceGroupName }}"
      name: "{{ WP_NSGName }}"
      rules:
        - name: SSH
          protocol: Tcp
          destination_port_range: 22
          access: Deny
          priority: 1001
          direction: Inbound
```

- Lunch wp_playbook.yml playbook using ansible vault
`ansible-playbook -e @secret.yml --ask-vault-pass wp_playbook.yml`

