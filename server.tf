provider "aws" {
  region = "us-east-1" # Substitua pela região da sua escolha
}

resource "aws_instance" "example" {
  ami                    = data.aws_ami.custom_ami.cloud_image_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = ["${aws_security_group.main.id}"]
  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "exemplo-ec2"
  }
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.example.public_ip
}
