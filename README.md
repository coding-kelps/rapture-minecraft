# Rapture - Minecraft

> [!NOTE]
> This repository is part of the Rapture project, which provides sample
> configurations for setting up self-hosted game servers.

This repository provides an example configuration for hosting a Minecraft server  
on a single AWS EC2 instance. Mods can optionally be loaded from the  
[Curseforge API](https://console.curseforge.com).

## Quickstart

### Prerequisites

- python (3.14.5)
- terraform (1.15.5)
- aws-cli (2.34.58)
- uv (0.11.18)

Ensure you've configured the AWS CLI (via `aws configure`) with a  
profile that has sufficient permissions. You'll also need a CurseForge API key,  
which you can get [here](https://console.curseforge.com) (account required).

### Terraform

```sh
terraform init
# Replace the ssh public key file with your own
terraform apply -var ssh_public_key="$(cat ~/.ssh/id_ed25519.pub)"
```

### Ansible

```
uv sync
uv run ansible-galaxy install -r requirements.yml
uv run ansible-playbook deployment.yml --extra-vars "minecraft_server__cf_api_key=$CF_API_KEY minecraft_server__cf_url=$CF_MODPACK_URL"
```

### Teardown

```
terraform destroy -var ssh_public_key="$(cat ~/.ssh/id_ed25519.pub)"
```

## Thank You!

A huge thanks to the contributors and maintainers of the
[itzg/docker-minecraft-server project](https://github.com/itzg/docker-minecraft-server).
