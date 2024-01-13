locals {
  record_name  = "k8s"
  cluster_name = "sikademo"

  // Get available regions using: doctl kubernetes options regions
  region = "fra1"
  // Get available versions using: doctl kubernetes options versions
  k8s_version = "1.28.2-do.0"
  // Get available sizes using: doctl kubernetes options sizes
  node_size  = "s-4vcpu-8gb"
  node_count = 3
}
