# Main VPC definition
resource "aws_vpc" "main-vpc" {
  cidr_block = "${lookup(var.vpc_subnet_mask, var.aws_region)}"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.stack_name}-vpc"
    hub_stackname = "${var.stack_name}"
  }
}

# Internet gateway for external connection
resource "aws_internet_gateway" "vpc-gateway" {
  vpc_id = "${aws_vpc.main-vpc.id}"

  tags {
    Name = "${var.stack_name}-gateway"
    hub_stackname = "${var.stack_name}"
  }
}

# Outbound internet route
resource "aws_route" "vpc-internet-route" {
  route_table_id = "${aws_vpc.main-vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.vpc-gateway.id}"
}

#
# Subnet 1
#
resource "aws_subnet" "subnet-1" {
  vpc_id = "${aws_vpc.main-vpc.id}"
  cidr_block = "${lookup(var.subnet1_subnet_mask, var.aws_region)}"
  availability_zone = "${lookup(var.availability_zones_1, var.aws_region)}"

  tags {
    Name = "${var.stack_name}-subnet1"
    hub_stackname = "${var.stack_name}"
  }
}
resource "aws_route_table_association" "subnet-1" {
  subnet_id = "${aws_subnet.subnet-1.id}"
  route_table_id = "${aws_vpc.main-vpc.main_route_table_id}"
}

#
# Subnet 2
#
resource "aws_subnet" "subnet-2" {
  vpc_id = "${aws_vpc.main-vpc.id}"
  cidr_block = "${lookup(var.subnet2_subnet_mask, var.aws_region)}"
  availability_zone = "${lookup(var.availability_zones_2, var.aws_region)}"

  tags {
    Name = "${var.stack_name}-subnet2"
    hub_stackname = "${var.stack_name}"
  }
}
resource "aws_route_table_association" "subnet-2" {
  subnet_id = "${aws_subnet.subnet-2.id}"
  route_table_id = "${aws_vpc.main-vpc.main_route_table_id}"
}

# Route 53 zone for services
resource "aws_route53_zone" "primary" {
  name = "${var.internal_dns_tld}"

  comment = "${var.stack_name}"
  vpc_id = "${aws_vpc.main-vpc.id}"
  vpc_region = "${var.aws_region}"

  tags {
    hub_stackname = "${var.stack_name}"
  }
}
