resource "aws_security_group" "private_machine" {
    name = "private_machine"
    description = "Allow incoming connections."


    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default1.id}"

    tags {
        Name = "SG_PRIVATE"
    }
}

resource "aws_instance" "PRIVATE_EC2" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-west-1a"
    instance_type = "t2.micro"
    key_name = "terraform_keys"
    vpc_security_group_ids = ["${aws_security_group.private_machine.id}"]
    subnet_id = "${aws_subnet.us-west-1a-private.id}"
    source_dest_check = false

    tags {
        Name = "PRIVATE_EC2"
    }
}
