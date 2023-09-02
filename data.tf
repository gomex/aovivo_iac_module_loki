data "aws_vpc" "main" {
  state = "available"
  filter {
    name   = "tag:Environment"
    values = ["production"]
  }
}

data "hcp_packer_image" "loki" {
  bucket_name    = "loki"
  channel        = "prod"
  cloud_provider = "aws"
  region         = "us-east-1"
}