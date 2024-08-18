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

resource "cloudflare_record" "k8s_extra_records" {
  for_each = toset(local.extra_records)

  zone_id = local.sikademo_com_zone_id
  name    = each.key
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

output "domains" {
  value = concat([
    cloudflare_record.k8s.hostname,
    cloudflare_record.k8s_wildcard.hostname,
    cloudflare_record.k8s_prod.hostname,
    cloudflare_record.k8s_prod_wildcard.hostname,
    cloudflare_record.k8s_dev.hostname,
    cloudflare_record.k8s_dev_wildcard.hostname,
    ], [
    for record in cloudflare_record.k8s_extra_records : record.hostname
  ])
}
