# Evaluating Kong Enterprise using Docker Compose

### Prerequisites

1. [Docker](https://docs.docker.com/get-docker/)
2. [Docker Compose](https://docs.docker.com/compose/install/)

## Installation procedure

1. `export KONG_LICENSE_DATA='<JSON_STRING>'`. You will have received your license string from your Kong representative.

2. To install the database, init it, and start Kong:

   a. non-tls: `docker-compose up -d`

   b. tls: `docker-compose -f docker-compose-tls.yaml up -d`

   c. hybrid (separate control and data plane): `docker-compose -f docker-compose-hybrid.yaml up -d`

3. In your browser, open either:

   a. for non-tls: `http://localhost:8002`

   b. for tls: `https://localhost:8445`

4. If you want to evaluate Role Based Access Control (RBAC), uncomment the commented out four lines in the respective YAML file. You will initially login with `kong_admin / KingKong`

5. Once the software is installed, head over to the [Getting Started Guide](../README.md) for next steps.

## Cleanup

Run `docker-compose down` to stop and remove all containers and the docker network created by the installation procedure.



##### _NOTE: Apple Silicon users_

You will likely receive a `qemu ... core dumped` error when running caused by the image not yet being compiled for ARM64. We are aware and will have those soon.

