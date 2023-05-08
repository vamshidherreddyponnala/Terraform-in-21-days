resource "aws_instance" "app_server" {
  ami           = "ami-0fcf52bcf5db7b003"
  instance_type = "t2.micro"

  tags = {
    Name = "AppServer"
    Owner= "Vamshi"
  }
}


