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
- `ssh -i AnsibleMasterKey.pem issam@20.199.99.13`

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

### [x] 3. Setup Ansible on AnsibleMaster VM - Connet to az - test fisrt playbook
- Resource: https://docs.microsoft.com/en-us/azure/developer/ansible/install-on-linux-vm?tabs=azure-cli

1. Update all packages that have available updates
- `sudo apt update -y`

2. Install Python 3 and pip.
- `sudo apt install python3-pip`

3. Upgrade pip3.
- `sudo pip3 install --upgrade pip`

4. Install Ansible.
- `sudo apt install ansible`

5. Install Ansible azure_rm module for interacting with Azure.
- `pip3 install ansible[azure]`

### [x] 4. Create an Azure service principal for Ansible
- Resource: https://docs.microsoft.com/en-us/azure/developer/ansible/create-ansible-service-principal?tabs=azure-cli
1. login to az using browser
- `az login`
  - output
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "6c18d021-5aa7-47b1-9864-56bee5390cc9",
    "id": "6457318c-3043-4126-9d39-f782e3503899",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Azure for Students",
    "state": "Enabled",
    "tenantId": "6c18d021-5aa7-47b1-9864-56bee5390cc9",
    "user": {
      "name": "issam.elferkh@gmail.com",
      "type": "user"
    }
  }

2. Create an Azure service principal
- ` az ad sp create-for-rbac --name ansible `
  - output
  {
    "appId": "2694c38f-6fd6-4532-be62-da4eb14ce1b3",
    "displayName": "ansible",
    "name": "2694c38f-6fd6-4532-be62-da4eb14ce1b3",
    "password": "jeuHMuWEVjRwY~oCodHBXmX49~qX8mVyQW",
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
  - output
  {
    "subscriptionid": "6457318c-3043-4126-9d39-f782e3503899",
    "tenantId": "6c18d021-5aa7-47b1-9864-56bee5390cc9"
  }

- `az ad sp list --display-name ansible --query '{clientId:[0].appId}'`
  - output
  {
    "clientId": "2694c38f-6fd6-4532-be62-da4eb14ce1b3"
  }

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

[default]
subscription_id=6457318c-3043-4126-9d39-f782e3503899
client_id=2694c38f-6fd6-4532-be62-da4eb14ce1b3
secret=jeuHMuWEVjRwY~oCodHBXmX49~qX8mVyQW
tenant=6c18d021-5aa7-47b1-9864-56bee5390cc9

### [x] 6. Test Ansible installation
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

