// Description: Creates two public subnet resources associated with the main VPC
// Result: subnet-public[0] with AZS "us-east-1a" and CIRD 11.11.64.0/24, subnet-public[1] with AZS "us-east-1b" and CIDR 11.11.128.0/24
resource "aws_subnet" "subnet-public" {
    vpc_id                  = "${aws_vpc.vpc.id}"
    count                   = "${length(var.public_subnet)}"
    cidr_block              = "${var.public_subnet[count.index]}"
    map_public_ip_on_launch = "true"
    availability_zone       = "${var.azs[count.index]}"

    tags = {
        Name = "MM - Public subnet"
    }
}

// Description: Creates the main/local route table for the VPC 
// Result: One route table for the two public subnets that they share. Contains a route entry with the IGW.
resource "aws_route_table" "route_table_us-east-1-public" {
    vpc_id = "${aws_vpc.vpc.id}"

    // Route for Internet Gateway
    route {
        cidr_block = "0.0.0.0/0"                                   # Enable subnet to access Internet via igw
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags = {
        Name = "MM - Public subnet route table"
    }
}

// Description: Creates route table associations for each public subnet. 
resource "aws_route_table_association" "route_table_associations-public-1a" {
    count           = "${length(var.public_subnet)}"
    subnet_id       = "${aws_subnet.subnet-public[count.index].id}"
    route_table_id  = "${aws_route_table.route_table_us-east-1-public.id}"
}