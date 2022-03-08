variable "AWS_REGION" {
    default = "us-east-1"
    description = "Region of the AWS account"
}

variable "vpc_cidr" {
  type = string
  default = ""
  description = "IPv4 CIDR block to be assigned to the VPC"
}

variable "public_subnet" {
  type = list(string)
  default = []
  description = "List of public CIDR blocks within the VPC CIDR"
}

variable "private_subnet" {
  type = list(string)
  default = []
  description = "List of private CIDR blocks within the VPC CIDR"
}

variable "azs" {
  type = list(string)
  default = []
  description = "Availability zones"
}