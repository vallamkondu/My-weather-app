# Fetch Availability Zones
data "aws_availability_zones" "az" {
  state = "available"
}

# Fetch the latest Amazon Linux AMI ID
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]  # Use Amazon-owned AMIs
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}