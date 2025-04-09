provider "aws" {
  region = "eu-north-1"
}
/*
resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_block
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = merge(
  { "Name" = var.vpc_name },  
  var.tags                    
  )
}

resource "aws_subnet" "public_subnets" {
 count      = length(var.public_subnet_cidrs)
 vpc_id     = aws_vpc.vpc.id
 map_public_ip_on_launch = true
 availability_zone_id = element(data.aws_availability_zones.az.zone_ids, count.index)
 cidr_block = element(var.public_subnet_cidrs, count.index)
  tags = merge(
    {Name = "Public Subnet ${count.index + 1}"},
    var.tags
  )
}
 
resource "aws_subnet" "private_subnets" {
 count      = length(var.private_subnet_cidrs)
 vpc_id     = aws_vpc.vpc.id
 availability_zone_id = element(data.aws_availability_zones.az.zone_ids, count.index)
 cidr_block = element(var.private_subnet_cidrs, count.index)
 
 tags = merge(
    {Name = "Private Subnet ${count.index + 1}"},
    var.tags
  )
}

resource "aws_internet_gateway" "igw" {
 vpc_id = aws_vpc.vpc.id
 
 tags = {
   Name = "VPC igw"
 }
}

#Public Route Table.
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-RT"
  }
}

# Associate Public Subnets.
resource "aws_route_table_association" "public_assoc" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Table.
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Private-RT"
  }
}

# Associate Private Subnets.
resource "aws_route_table_association" "private_assoc" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

# Security Group for EC2 - Allow SSH & HTTP from Internet
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.vpc.id
  # Allow HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to all
  }
  tags = {
    Name = "EC2-SecurityGroup"
  }
}

# EC2 Instance
resource "aws_instance" "my_ec2" {
  ami             = data.aws_ami.latest_amazon_linux.id
  instance_type   = "t3.micro"
  subnet_id       = aws_subnet.public_subnets[0].id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = merge(
    { "Name" = var.instance_name },
    var.tags
  )
}
*/