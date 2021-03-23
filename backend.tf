terraform {
  backend "remote" {
    organization = "sikademo"
    workspaces {
      name = "k8s"
    }
  }
}
