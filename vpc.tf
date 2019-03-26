resource "aws_vpc" "default1" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "VPC"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default1.id}"
     tags {
        Name = "IGW"
    }
}

resource "aws_eip" "nat" {
    vpc = true

  tags = {
    Name = "EIP NAT"
  }
}

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.us-west-1a-public.id}"

  tags = {
    Name = "NAT"
  }
}


resource "aws_subnet" "us-west-1a-public" {
    vpc_id = "${aws_vpc.default1.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-west-1a"

    tags {
        Name = "PUBLIC_SUBNET"
    }
}

resource "aws_route_table" "us-west-1a-public" {
    vpc_id = "${aws_vpc.default1.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "ROUTE_IGW"
    }
}

resource "aws_route_table_association" "us-west-1a-public" {
    subnet_id = "${aws_subnet.us-west-1a-public.id}"
    route_table_id = "${aws_route_table.us-west-1a-public.id}"
}

resource "aws_subnet" "us-west-1a-private" {
    vpc_id = "${aws_vpc.default1.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "us-west-1a"

    tags {
        Name = "PRIVATE_SUBNET"
    }
}

resource "aws_route_table" "us-west-1a-private" {
    vpc_id = "${aws_vpc.default1.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.gw.id}"
    }

    tags {
        Name = "ROUTE_NAT"
    }
}

resource "aws_route_table_association" "us-west-1a-private" {
    subnet_id = "${aws_subnet.us-west-1a-private.id}"
    route_table_id = "${aws_route_table.us-west-1a-private.id}"
}
