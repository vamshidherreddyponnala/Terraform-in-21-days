resource "aws_instance" "web" {
  ami                         = ami-0cff7528ff583bf9a
  associate_public_ip_address = true
  instance_type               = "t3.micro"
  key_name                    = "Key_Pair"
  vpc_security_group_ids      = [aws_security_group.public.id]
  subnet_id                   = [aws_subnet.public[0].id]

  tags = {
    Name = "${var.env_code}-public"
  }
}

resource "aws_security_group" "public" {
  name        = "${var.enc_code}-public"
  description = "Allow inbound traffic"
  vpc         = aws_vpc.main.id


  ingress {
    description = "SSH from  public"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["49.43.201.190"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env_code}-public"
  }
}


# resource "aws_instance" "private" {
#   ami                    = "ami-0cff7528ff583bf9a"
#   instance_type          = "t3.micro"
#   key_name               = "main"
#   vpc_security_group_ids = [aws_security_group.private.id]
#   subnet_id              = aws_subnet.private[0].id

#   tags = {
#     Name = "${var.env_code}-private"
#   }
# }

# resource "aws_security_group" "private" {
#   name        = "${var.env_code}-private"
#   description = "Allow VPC traffic"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description = "SSH from VPC"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = [var.vpc_cidr]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "${var.env_code}-private"
#   }
# }

