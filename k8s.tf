resource "digitalocean_kubernetes_cluster" "sikademo" {
  name   = "sikademo"
  region = local.region
  // Get available versions using: doctl kubernetes options versions
  version = local.k8s_version

  node_pool {
    name       = "sikademo"
    size       = local.node_size
    node_count = local.node_count
  }
}

resource "digitalocean_loadbalancer" "sikademo" {
  name   = "sikademo"
  region = local.region

  droplet_tag = "k8s:${digitalocean_kubernetes_cluster.sikademo.id}"

  healthcheck {
    port     = 80
    protocol = "tcp"
  }

  forwarding_rule {
    entry_port      = 80
    target_port     = 80
    entry_protocol  = "tcp"
    target_protocol = "tcp"
  }

  forwarding_rule {
    entry_port      = 443
    target_port     = 443
    entry_protocol  = "tcp"
    target_protocol = "tcp"
  }

  forwarding_rule {
    entry_port      = 8080
    target_port     = 30003
    entry_protocol  = "tcp"
    target_protocol = "tcp"
  }

  forwarding_rule {
    entry_port      = 25
    target_port     = 30025
    entry_protocol  = "tcp"
    target_protocol = "tcp"
  }
}

output "lb_ip" {
  value = digitalocean_loadbalancer.sikademo.ip
}

output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.sikademo.kube_config.0.raw_config
  sensitive = true
}
