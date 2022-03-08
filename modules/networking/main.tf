// Description: Creates a VPC
resource "aws_vpc" "vpc" {
    cidr_block              = "${var.vpc_cidr}"
    enable_dns_support      = "true" # Gives an internal domain name
    enable_dns_hostnames    = "true" # Gives an internal host name
    enable_classiclink      = "false" # Boolean flag that enables ClassicLink for the VPC
    instance_tenancy        = "default" # Default, makes instances shared on the host. 

    tags = {
        Name = "MM - VPC"
    }
}