[Ondrej Sika (sika.io)](https://sika.io) | <ondrej@sika.io> | [__Školení Kubernetes__](https://ondrej-sika.cz/skoleni/kubernetes/) | [__Školení Terraform__](https://ondrej-sika.cz/skoleni/terraform/) 🚀💻

> [!TIP]
> <a href="https://ondrej-sika.cz/skoleni/kubernetes"><img src="https://img.shields.io/badge/Školení%20Kubernetes-by%20Ondřej%20Šika-blue?style=for-the-badge&logo=kubernetes&logoColor=white" style="width: 100%; height: auto;" alt="Školení Kubernetes by Ondřej Šika" /></a>
>
> 🚀 Naučte se, jak efektivně spravovat kontejnery s **Kubernetes**! Praktické školení vedené [Ondřejem Šikou](https://ondrej-sika.cz).
>
> 👉 [Více informací a registrace zde](https://ondrej-sika.cz/skoleni/kubernetes)

> [!NOTE]
> This is a demo / example reposiotry.

# [DEMO] Kubernetes on DigitalOcean

This repository sets up a Kubernetes cluster on DigitalOcean with Load Balancer and DNS records on Cloudflare using Terraform.

## Usage

Create `_terraform.auto.tfvars` with your credentials (see `_terraform.auto.EXAMPLE.tfvars`):

```hcl
digitalocean_token   = "xxx"
cloudflare_api_token = "xxx"
```

Create the infrastructure:

```
terraform init
terraform apply
```

Get the kubeconfig:

```
make kubeconfig-get # writes kubeconfig.yml
make kubeconfig-add # merges it into ~/.kube/config (with backup)
```
