# Fetch Availability Zones
data "aws_availability_zones" "az" {
  state = "available"
}