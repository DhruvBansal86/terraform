resource "aws_security_group" "public_machine" {
    name = "public_machine"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
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
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }

    vpc_id = "${aws_vpc.default1.id}"

    tags {
        Name = "SG_PUBLIC"
    }
}

resource "aws_key_pair" "terraform_keys" {
  key_name   = "terraform_keys"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCil5+uQnosMenDf8rWIBYAe+xm29HVt6hgcPJzQtFBp9SLG5pEERSDfVfvq6liGtm5Lj2GZC9qQkR6AAttN0Xv+eAPF2z9zftWi1zGKdDbND2yyJhZHG6ksNyKt7JLibPaj/XUnwyAVRIqT5JDtNe+5V9R5IGfuWnjHbQF22X1TWi7ctC5Egn6lcjnBrWy7ykAZukwhUO2WrL68b+qQkobEuA8APWlWcPhebuEJD8IuKjcissQ3c+h97zL4Z8436mtSphYN+36zAtzaptPliparZUz4QGji7cIm+qab2lMpkb1H7igIPHd6S7I0qL37E2asYvMgSMyG3R+vnIO/Llb imported-openssh-key"
}

resource "aws_instance" "web-1" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-west-1a"
    instance_type = "t2.micro"
    key_name = "terraform_keys"
    vpc_security_group_ids = ["${aws_security_group.public_machine.id}"]
    subnet_id = "${aws_subnet.us-west-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false
    user_data = "../user-data/user-data.sh"

    tags {
        Name = "PUBLIC_EC2"
    }
}

resource "aws_eip" "web-1" {
    instance = "${aws_instance.web-1.id}"
    vpc = true
 tags {
        Name = "PUBLIC_EIP"
    }

}
