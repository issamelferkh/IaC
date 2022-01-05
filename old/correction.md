## Overview
### Website is working
Go to the student's website:
- Is this site running under WordPress? If you Refresh the page multiple times, does the content of the page remains the same (except for the visual identification of the server we are on)?
- Take a walk in the pages, refresh the content, does it works?
- Is the IP of the current server listed in the page somewhere, and can each server be accessed by using this IP? 

### Web security basics
What arrangements have been made by the user to secure its content?
- Only the ports 80/443 (HTTP/HTTPS) should be accessible from the outside of the instances.
- The database must be accessible only on the port necessary for its operation and only in local.
- If other security mechanisms are present, it's cool, talk about it.


## Infrastructure as code (Iaac)
### [ ] Deployment
- Verify that the Ansible deployment script works by deploying the student code on another machine.
- It must be possible to get the same site by executing the same script.
  - So need one Script!

### Idempotency of deployment
- Check that you can apply the same script several times and get a site that works.

### Modular architecture
- Is the student's code broken down into several relevant roles?
- Typically the web server in one role, the database in another role, etc.
The goal is to be able to deploy the parts independently of each other.
  - Plusieur Containers

### Secrets managements
- Does the code contain hard-coded secrets? Like a password to connect to the database hard-coded in the code.
- Be ruthless about it. People get fired for this kind of neglect.
  - dont use secrects!

## Containers
### Containers best practices
Are the Dockerfile organized to benefit from the cache?
Having the part that often changes at the END of the Dockerfile and the part that does not change a lot (system dependencies) at the beginning?
Are the containers as small as possible?

### Modular containers
Are the containers well separated from each other?
Is there one container for the database, one for the PHP run time, one for the web proxy etc.?
It must be possible for these containers to communicate with each other.

### Container and storage
Is the site data stored in mounted volumes?
Is it possible to view these volumes for an administrator?
using the docker commands?

### Orchestration
Is it possible to launch all containers in one go? 
Is it possible to restart them individually?








## Remarques
- push script