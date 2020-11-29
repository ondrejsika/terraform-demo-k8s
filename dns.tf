resource "cloudflare_record" "k8s" {
  zone_id = local.sikademo_com_zone_id
  name    = "k8s"
  value   = digitalocean_loadbalancer.sikademo.ip
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "k8s_wildcard" {
  zone_id = local.sikademo_com_zone_id
  name    = "*.${cloudflare_record.k8s.name}"
  value   = cloudflare_record.k8s.hostname
  type    = "CNAME"
  proxied = false
}
