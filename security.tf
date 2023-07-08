resource "aws_security_group" "main" {
  vpc_id      = data.aws_vpc.main.id
  description = "Liberar toda saida"

  egress {
    description = "Liberar toda saida"
    from_port   = 0
    to_port     = 0

    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "descomplicando packer"
  }

}

resource "aws_security_group_rule" "main" {
  for_each    = var.sg_group_rule
  cidr_blocks = each.value.cidr_blocks
  from_port   = each.value.port
  to_port     = each.value.port
  description = each.key
  protocol    = each.value.protocol

  security_group_id = aws_security_group.main.id
  type              = "ingress"
}

#tfsec:ignore:aws-ec2-no-public-ingress-sgr
resource "aws_security_group_rule" "ssh" {

  cidr_blocks = ["0.0.0.0/0"]
  from_port   = "22"
  to_port     = "22"
  description = "Access to SSH"
  protocol    = "tcp"

  security_group_id = aws_security_group.main.id
  type              = "ingress"
}