# Migrate custom software to Azure App Service using a custom container
- Resource: https://docs.microsoft.com/en-us/azure/app-service/tutorial-custom-container?pivots=container-linux

## Locally
1. Setup environment:
- Azure Cloud Shell
- Azure CLI
- Docker
  - `docker --version`

2. Clone Sample App
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
1. Create a resource group

2. Push the image to Azure Container Registry

3. Configure App Service to deploy the image from the registry (ACR)

4. Deploy the image and test the app

5. Access diagnostic logs
6. Configure continuous deployment
  7. Modify the app code and redeploy
8. Connect to the container using SSH
9. Clean up resources

- Use persistent shared storage: https://docs.microsoft.com/en-us/azure/app-service/configure-custom-container?pivots=container-linux#use-persistent-shared-storage





