// Description: Creates an Internet Gateway 
resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags = {
        Name = "MM - Internet Gateway"
        
    }
}

// Description: Creates a NAT Gateway
// You cannot launch a NAT gateway without the Elastic IP address associated with it. That's why it is required
resource "aws_eip" "eip" {
    vpc = true
}
resource "aws_nat_gateway" "nat_gateway" {
    allocation_id   = "${aws_eip.eip.id}"                       # Allocation ID of the Elastic IP address for the gateway
    subnet_id       = "${aws_subnet.subnet-public[1].id}"        # Construct the NAT gateway in one of the public subnets

    tags = {
        Name = "MM - NAT Gateway"
    }
}