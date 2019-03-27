output "public instance ip" {
  description = "Name of the SSH key pair provisioned on the instance"
  value       = "${aws_eip.web.public_ip}"
}


