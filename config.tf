locals {
  // Get available regions using: doctl kubernetes options regions
  region = "fra1"
  // Get available versions using: doctl kubernetes options versions
  k8s_version = "1.22.7-do.0"
  // Get available sizes using: doctl kubernetes options sizes
  node_size       = "s-4vcpu-8gb"
  node_count = 3
}