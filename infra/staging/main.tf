terraform {
  backend "s3" {
    bucket = "terraform-states.tobyjsullivan.com"
    key    = "states/tobysullivan.net/terraform.staging.tfstate"
    region = "us-east-1"
  }
}

variable "cloudflare_email" {}
variable "cloudflare_token" {}

module "website" {
  source = "../common/"
  env = "staging"
  region = "us-east-1"
  domain = "staging.tobysullivan.net"
  cloudflare_domain = "tobysullivan.net"
  cloudflare_email = "${var.cloudflare_email}"
  cloudflare_token = "${var.cloudflare_token}"
}
