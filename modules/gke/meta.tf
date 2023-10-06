data "humanitec_source_ip_ranges" "main" {}

data "google_client_config" "default" {}

data "http" "icanhazip" {
  url = "http://icanhazip.com"
}