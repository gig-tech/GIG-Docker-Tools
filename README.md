# Virtual Cloud Operator Tools in Docker Image

Build a Docker image for a Virtual Cloud Operator with the VCO Terraform plugin and Commandline interface tools to manage resources in the VCO.

## Setup and Deployment
This repository provides a Dockerfile and accompanying scripts to build an image that will contain relevant tools to manage your resources in a VCO portal. One must have access to their customer account in the VCO portal to be able to build this image and obtain a valid JWT from the API page in the VCO portal. The URL for the VCO is also passed as an environment variable.

## Prerequisites

Docker container runtime must be installed on the machine from which this build will be done, valid JWT and URL for VCO portal.

## Build steps

### Clone repository

Clone the repository and switch to the directory with Dockerfile

```bash
git clone https://git.gig.tech/gigimages/images/docker/gig_tools

cd gig_tools/cli_terraform/
```

### Set environment variables to pass to image during build

```bash
ARG_JWT=

ARG_VCO_API_URL=

export ARG_JWT

export ARG_VCO_API_URL
```

### Run docker build

Run the command to build a docker image from Dockerfile

```bash
docker build --build-arg ARG_JWT --build-arg ARG_VCO_API_URL -t <VCO_NAME> .
```

### Container run

To use the build image, run the command below to access the container.

```bash
docker run -w /root/home/ -i -t <VCO_NAME> /bin/bash
```

### setup JWT if expired

JWT is set during the image built but after a while, the token expires. To renew the token in the container run the command below

```bash
echo $JWT | <VCO_CLI_NAME> config auth-token update
or
echo $JWT | ateam config auth-token update
```