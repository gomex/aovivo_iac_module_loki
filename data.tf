data "aws_vpc" "main" {
  state = "available"
  filter {
    name   = "tag:Environment"
    values = ["production"]
  }
}

data "aws_ami" "custom_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["loki-*"]
  }

  filter {
    name   = "tag:OS_Version"
    values = ["Loki aula ao vivo"]
  }

  owners = ["405151343467"]
}
