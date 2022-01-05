# Migrate custom software to Azure App Service using a custom container
- Resource: https://docs.microsoft.com/en-us/azure/app-service/tutorial-custom-container?pivots=container-linux

## Locally
1. Setup environment:
- Azure Cloud Shell
- Azure CLI
- Docker
  - `docker --version`

2. Clone App
- from github (code source + dockerfile)

3. Examine the Docker file
- A file that describe the docker image and contains config instructions.

4. Build and test the image locally
4. 1. Build image
- `docker build --tag appsvc-tutorial-custom-image .`

4. 2. Run Docker Container
- `docker run -it -p 8000:8000 appsvc-tutorial-custom-image`
4. 3. test in browser
- http://localhost:8000

## AZURE Cloud
### 1. Create a resource group
- `az group create --name myResourceGroup --location westeurope`
  - output 
  `
    {
      "id": "/subscriptions/6457318c-3043-4126-9d39-f782e3503899/resourceGroups/myResourceGroup",
      "location": "westeurope",
      "managedBy": null,
      "name": "myResourceGroup",
      "properties": {
        "provisioningState": "Succeeded"
      },
      "tags": null,
      "type": "Microsoft.Resources/resourceGroups"
    }
  `

### 2. Push the image to Azure Container Registry
2. 1. Create Azure Container Registry (ACR):
- `az acr create --name issamregistry --resource-group myResourceGroup --sku Basic --admin-enabled true`

2. 2. Retrieve credentials for the registry
- `az acr credential show --resource-group myResourceGroup --name issamregistry`
  - output
  `
    {
      "passwords": [
        {
          "name": "password",
          "value": "XByij4zYGO318XrJfBLqoim0KOZum=1O"
        },
        {
          "name": "password2",
          "value": "iBFJrGAfsQudteqk5HPneU6=YnoC5PBI"
        }
      ],
      "username": "issamregistry"
    }
  `

2. 3. Use the docker login command to sign in to the container registry:
- `docker login <registry-name>.azurecr.io --username <registry-username>`
- `docker login issamregistry.azurecr.io --username issamregistry`

2. 4. Once the login succeeds, tag your local Docker image for the registry:
- `docker tag appsvc-tutorial-custom-image <registry-name>.azurecr.io/appsvc-tutorial-custom-image:latest`
- `docker tag appsvc-tutorial-custom-image issamregistry.azurecr.io/appsvc-tutorial-custom-image:latest`

- ex: hello-world
  - Run the image in local, ex: hello-world
    - `docker run -it hello-world`
  - Login to your container registry
  - Tag local Docker image for the registry
    - `docker tag hello-world issamregistry.azurecr.io/hello-world`


  - Push to your registry
    - `docker push issamregistry.azurecr.io/hello-world`
  - Pull from your registry
    - `docker pull issamregistry.azurecr.io/hello-world`

2. 5. Use the docker push command to push the image to the registry:
- `docker push <registry-name>.azurecr.io/appsvc-tutorial-custom-image:latest`


### 3. Configure App Service to deploy the image from the registry (ACR)

### 4. Deploy the image and test the app







5. Access diagnostic logs
6. Configure continuous deployment
  7. Modify the app code and redeploy
8. Connect to the container using SSH
9. Clean up resources

- Use persistent shared storage: https://docs.microsoft.com/en-us/azure/app-service/configure-custom-container?pivots=container-linux#use-persistent-shared-storage





