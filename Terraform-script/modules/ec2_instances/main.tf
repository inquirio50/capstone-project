variable "region" {}

variable "instance_count" {}

resource "aws_instance" "capstone" {
  ami = "ami-0289605e6e2e851bf"
  instance_type = "t2.micro"
  key_name = "capstone-key-pair"
  count = var.instance_count

  tags = {
    "Name" = "capstone-instance-${count.index}"
  }

  // Allow SSH access from any IP address
  security_groups = [aws_security_group.ssh_access.id]

  // Add public IP address to each instance
  associate_public_ip_address = true
}

resource "aws_security_group" "ssh_access" {
  name_prefix = "ssh-access"

  ingress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 22
    protocol = "tcp"
    to_port = 22
  } ]
}