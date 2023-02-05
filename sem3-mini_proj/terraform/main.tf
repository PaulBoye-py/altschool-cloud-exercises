provider "aws" {
  region = "us-east-1"
}

# Creating the VPC

resource "aws_vpc" "Altschool_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  instance_tenancy = "default"
  tags = {
    Name = "Altschool_vpc"
  }
}

# Creating Internet Gateway

resource "aws_internet_gateway" "Altschool_internet_gateway" {
  vpc_id = aws_vpc.Altschool_vpc.id
  tags = {
    Name = "Altschool_internet_gateway"
  }
}

# Create public subnet-1

resource "aws_subnet" "Altschool-public-subnet1" {
  vpc_id = aws_vpc.Altschool_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name = "Altschool-public-subnet1"
  }
}

# Create public subnet-2

resource "aws_subnet" "Altschool-public-subnet2" {
  vpc_id = aws_vpc.Altschool_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  tags = {
    Name = "Altschool-public-subnet2"
  }
}

resource "aws_subnet" "Altschool-public-subnet3" {
  vpc_id = aws_vpc.Altschool_vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1c"
  tags = {
    Name = "Altschool-public-subnet2"
  }
}


# Creating public route table
resource "aws_route_table" "Altschool-route-table-public" {
  vpc_id = aws_vpc.Altschool_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Altschool_internet_gateway.id
  }

  tags = {
    Name = "Altschool-route-table-public"
  }
}

# Associate public subnet1 with public route table

resource "aws_route_table_association" "Altschool-public-subnet1-association" {
  subnet_id = aws_subnet.Altschool-public-subnet1.id
  route_table_id = aws_route_table.Altschool-route-table-public.id
}

# Associate public subnet2 with public route table

resource "aws_route_table_association" "Altschool-public-subnet2-association" {
  subnet_id = aws_subnet.Altschool-public-subnet2.id
  route_table_id = aws_route_table.Altschool-route-table-public.id
}

# Subnet3 Associaton

resource "aws_route_table_association" "Altschool-public-subnet3-association" {
  subnet_id = aws_subnet.Altschool-public-subnet3.id
  route_table_id = aws_route_table.Altschool-route-table-public.id
}



# Network ACL

# resource "aws_network_acl" "Altschool-network_acl" {
#   vpc_id = aws_vpc.Altschool_vpc.id
#   subnet_ids = [aws_subnet.Altschool-public-subnet1.id, aws_subnet.Altschool-public-subnet2.id]

#   ingress = [ {
#     action = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port = 0
#     ipv6_cidr_block = "value"
#     protocol = "-1"
#     rule_no = 100
#     to_port = 0
#   } ]

#   egress = [ {
#     action = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port = 0
#     ipv6_cidr_block = "value"
#     protocol = "value"
#     rule_no = 100
#     to_port = 0
#   } ]
# }

# Security Group

resource "aws_security_group" "Altschool_security_group" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.Altschool_vpc.id

  dynamic "ingress" {
    for_each = [22, 443, 80]
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      description = "This allows the following ports: HTTP, HTTPS, SSH"
      cidr_blocks = ["0.0.0.0/0"]

    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Altschool_security_group"
  }
}

# Create AWS Instances

resource "aws_instance" "Altschool1" {
  ami = "ami-00874d747dde814fa"
  key_name = var.key_pair
  instance_type = "t2.micro"
  subnet_id = aws_subnet.Altschool-public-subnet1.id
  vpc_security_group_ids = [aws_security_group.Altschool_security_group.id]
  associate_public_ip_address = true

  tags = {
    Name = "Altschool1"
  }

  provisioner "local-exec" {
    command = "echo ubuntu@${self.public_ip} >> ../ansible/host-inventory"
  }
}

resource "aws_instance" "Altschool2" {
  ami = "ami-00874d747dde814fa"
  key_name = var.key_pair
  instance_type = "t2.micro"
  subnet_id = aws_subnet.Altschool-public-subnet2.id
  vpc_security_group_ids = [aws_security_group.Altschool_security_group.id]
  associate_public_ip_address = true

  tags = {
    Name = "Altschool2"
  }

  provisioner "local-exec" {
    command = "echo ubuntu@${self.public_ip} >> ../ansible/host-inventory"
  }
}

resource "aws_instance" "Altschool3" {
  ami = "ami-00874d747dde814fa"
  key_name = var.key_pair
  instance_type = "t2.micro"
  subnet_id = aws_subnet.Altschool-public-subnet3.id
  vpc_security_group_ids = [aws_security_group.Altschool_security_group.id]
  associate_public_ip_address = true

  tags = {
    Name = "Altschool3"
  }

  provisioner "local-exec" {
    command = "echo ubuntu@${self.public_ip} >> ../ansible/host-inventory"
  }
}


resource "aws_lb_target_group" "Altschool-lb-target-group" {
  name        = "Altschool-lb-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.Altschool_vpc.id

  health_check {
    path = "/"
    protocol = "HTTP"
  }

  tags = {
    Name = "Altschool-lb-target-group"
  }
}

resource "aws_lb_target_group_attachment" "Altschool-lb-target-group-attachment-1" {
  target_group_arn = aws_lb_target_group.Altschool-lb-target-group.arn
  target_id = aws_instance.Altschool1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "Altschool-lb-target-group-attachment-2" {
  target_group_arn = aws_lb_target_group.Altschool-lb-target-group.arn
  target_id = aws_instance.Altschool2.id
  port = 80
}

resource "aws_lb_target_group_attachment" "Altschool-lb-target-group-attachment-3" {
  target_group_arn = aws_lb_target_group.Altschool-lb-target-group.arn
  target_id = aws_instance.Altschool3.id
  port = 80
}

# Load Balancer

resource "aws_lb" "altschool-lb" {
  name = "altschool-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.Altschool_security_group.id]
  ip_address_type = "ipv4"
  subnets = [aws_subnet.Altschool-public-subnet1.id, aws_subnet.Altschool-public-subnet2.id, aws_subnet.Altschool-public-subnet3.id]

  tags = {
    Environment = "dev"
  }
}

# Attach Instances to Load Balancer

resource "aws_lb_listener" "altschool-lb-listener" {
  load_balancer_arn = aws_lb.altschool-lb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.Altschool-lb-target-group.arn
  }

  tags = {
    Name = "altschool-lb-listener"
  }
}


# Create Route 53

resource "aws_route53_zone" "my-site" {
  name = "paul-roju.me"

  tags = {
    Name = "paul-roju.me"
  }
}

# Record pointing LB to site and subdomain

resource "aws_route53_record" "my-subdomain" {
  zone_id = aws_route53_zone.my-site.zone_id
  name = "terraform-test.paul-roju.me"
  type = "CNAME"
  ttl = 300
  records = ["${aws_lb.altschool-lb.dns_name}"]
}