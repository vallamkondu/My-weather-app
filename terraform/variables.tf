variable "cidr_block" {
  description = "cidr block range"
  type = string
  default = "10.16.0.0/19"
}

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.16.0.0/24", "10.16.2.0/24", "10.16.3.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.16.4.0/24", "10.16.5.0/24", "10.16.6.0/24"]
}

variable "vpc_name" {
  description = "Name of the vpc"
  default = "my-vpc"
  
}

variable "tags" {
  description = "Default tags"
  default = {
    Environment = "Development"
    Project     = "Weather-App"
    Owner       = "Dikshit"
  }
}

variable "enable_dns_support" {
  description = "dns support for vpc"
  type = bool
  default = true
}

variable "enable_dns_hostnames" {
  description = "dns host name for vpc"
  type = bool
  default = true
}

variable "instance_name" {
  description = "Instance Name"
  default = "MyEC2Instance"
}

variable "ami_id" {
  default = "ami-0c2e61fdcb5495691"
}
