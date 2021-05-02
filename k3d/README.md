# Evaluating Kong Enterprise using k3d

Run a local K8S cluster for POCs and quick sniff tests

### Prerequisites

1. Install [k3d](https://k3d.io) (assumes you already have [Docker](https://docs.docker.com/get-docker/) and [Helm](https://helm.sh/docs/intro/install/) installed as prerequisites for k3d)

## Installing

2. Into the `license.json` place your specific license data
3. `./install-kong-ent.sh` (this creates a k3s cluster named `mycluster`, adds the Kong helm chart repo, installs a Postgres DB, initializes its schema, and initializes and installs Kong Enterprise)
3. Once the software is installed, head over to the [Getting Started Guide](../README.md) for next steps.

## Cleanup

run `./delete-k3d.sh` to remove *all* your local K3D Kubernetes Cluster(s).



##### _NOTE: Apple Silicon Users_

You will likely receive a `qemu ... core dumped` error when running caused by the image not yet being compiled for ARM64. We are aware and will have those soon.