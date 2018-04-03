variable "domain" {
  default = "tobysullivan.net"
}
variable "cloudflare_email" {}
variable "cloudflare_token" {}
variable "cloudflare_domain" {
  default = "tobysullivan.net"
}
variable "env" {
  default = "production"
}

provider "aws" {
  region = "us-east-1"
}

provider "cloudflare" {
  email = "${var.cloudflare_email}"
  token = "${var.cloudflare_token}"
}

resource "aws_s3_bucket" "website" {
  bucket = "${var.domain}"
  acl = "public-read"
  force_destroy = "${var.env != "production"}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.domain}/*"
        }
    ]
}
EOF
  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "www" {
  bucket = "www.${var.domain}"
  force_destroy = true

  website {
    redirect_all_requests_to = "https://${var.domain}"
  }
}

resource "cloudflare_record" "root" {
  domain = "${var.cloudflare_domain}"
  name = "${var.domain}"
  value = "${aws_s3_bucket.website.website_endpoint}"
  type = "CNAME"
  proxied = true
}

resource "cloudflare_record" "www" {
  domain = "${var.cloudflare_domain}"
  name = "www.${var.domain}"
  value = "${cloudflare_record.root.hostname}"
  type = "CNAME"
  proxied = true
}

output "s3_bucket" {
  value = "${var.domain}"
}

