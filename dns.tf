resource "cloudflare_record" "k8s" {
  zone_id = local.sikademo_com_zone_id
  name    = local.record_name
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

resource "cloudflare_record" "k8s_prod" {
  zone_id = local.sikademo_com_zone_id
  name    = "${cloudflare_record.k8s.name}-prod"
  value   = cloudflare_record.k8s.hostname
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "k8s_prod_wildcard" {
  zone_id = local.sikademo_com_zone_id
  name    = "*.${cloudflare_record.k8s_prod.name}"
  value   = cloudflare_record.k8s.hostname
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "k8s_dev" {
  zone_id = local.sikademo_com_zone_id
  name    = "${cloudflare_record.k8s.name}-dev"
  value   = cloudflare_record.k8s.hostname
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "k8s_dev_wildcard" {
  zone_id = local.sikademo_com_zone_id
  name    = "*.${cloudflare_record.k8s_dev.name}"
  value   = cloudflare_record.k8s.hostname
  type    = "CNAME"
  proxied = false
}
