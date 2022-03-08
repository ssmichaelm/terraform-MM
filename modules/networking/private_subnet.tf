// Description: Creates two private subnet resources associated with the main VPC
// Result: subnet-private[0] with AZS "us-east-1a" and CIDR 11.11.0.0/24, subnet-private[1] with AZS "us-east-1b" and CIDR 11.11.32.0/24
resource "aws_subnet" "subnet-private" {
    vpc_id                  = "${aws_vpc.vpc.id}"                        
    count                   = "${length(var.private_subnet)}"       # Number of subnets created, determined by variables
    cidr_block              = "${var.private_subnet[count.index]}"  # CIDR block determined by variables
    map_public_ip_on_launch = "false"                               # Specify false for private subnet
    availability_zone       = "${var.azs[count.index]}"             # Availability zone determined by variables

    tags = {
        Name = "MM - Private subnet"
    }
}

// Description: Creates a route table for one private subnet
resource "aws_route_table" "route_table_us-east-1a-private" {
    vpc_id = "${aws_vpc.vpc.id}"

    // Route for NAT Gateway
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.nat_gateway.id}"
    }

    tags = {
        Name = "MM - Private subnet route table"
    }
}
// Description: Creates route table associations for each private. subnet. This creates an association between each subnet created and the main VPC route table
resource "aws_route_table_association" "route_table_associations-private-1a" {
    subnet_id       = "${aws_subnet.subnet-private[0].id}"
    route_table_id  = "${aws_route_table.route_table_us-east-1a-private.id}"
}

// Description: Creates a route table for one private subnet
resource "aws_route_table" "route_table_us-east-1b-private" {
    vpc_id = "${aws_vpc.vpc.id}"

    // Route for NAT Gateway
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.nat_gateway.id}"
    }

    tags = {
        Name = "MM - Private subnet route table"
    }
}
// Description: Creates route table associations for each private. subnet. This creates an association between each subnet created and the main VPC route table
resource "aws_route_table_association" "route_table_associations-private-1b" {
    subnet_id       = "${aws_subnet.subnet-private[1].id}"
    route_table_id  = "${aws_route_table.route_table_us-east-1b-private.id}"
}
