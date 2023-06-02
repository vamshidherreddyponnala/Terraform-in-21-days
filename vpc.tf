locals {
  public_cidr=["10.0.0.0/24","10.0.11.0/24","10.0.12.0/24"]
  private_cidr=["10.0.100.0/24","10.0.101.0/24","10.0.103.0/24"]
  availability_zone = ["us-east-1a","us-east-1b","us-east-1c"]

}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public" {
  count = length(local.public_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = local.public_cidr[count.index]
  availability_zone = local.availability_zone[count.index]
  tags = {
    Name = "public${count.index+1}"
  }
}

resource "aws_subnet" "private" {
  count = length(local.private_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = local.private_cidr[count.index]
  availability_zone = local.availability_zone[count.index]
  tags = {
    Name = "private${count.index+1}"
  }
}

#Internet_Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

#Route_Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "main"
  }
}

#aws_route_table_association
resource "aws_route_table_association" "public" {
  count = length(local.public_cidr)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  count = length(local.public_cidr)

    vpc      = true
      tags = {
    Name = "nat${count.index+1}"
  }
}

# # #NAT GATWAY for Public Subnet
resource "aws_nat_gateway" "main" {
  count = length(local.public_cidr)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "main${count.index+1}"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "private" {
  count = length(local.private_cidr)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name = "private${count.index+1}"
  }
}

  resource "aws_route_table_association" "private" {
  count = length(local.private_cidr)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

