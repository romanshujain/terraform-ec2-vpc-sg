resource "aws_vpc" "main-vpc" {
  cidr_block = "10.20.0.0/16"
  instance_tenancy = "default"
  tags =  {
    Name = "terraform-vpc"
  }
}

resource "aws_subnet" "public_subnet1" {
  cidr_block = "10.20.0.0/18"
  vpc_id = "${aws_vpc.main-vpc.id}"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "public_subnet"
  }

}

resource "aws_subnet" "private_subnet1" {
  cidr_block = "10.20.64.0/18"
  vpc_id = "${aws_vpc.main-vpc.id}"
  map_public_ip_on_launch = "false"
  tags =  {
    Name = "private_subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  cidr_block = "10.20.128.0/18"
  vpc_id = "${aws_vpc.main-vpc.id}"
  map_public_ip_on_launch = "false"
  tags =  {
    Name = "private_subnet2"
  }
}

resource "aws_subnet" "private_subnet3" {
  cidr_block = "10.20.192.0/18"
  vpc_id = "${aws_vpc.main-vpc.id}"
  map_public_ip_on_launch = "false"
  tags =  {
    Name = "private_subnet3"
  }
}

resource "aws_internet_gateway" "AWS-IGW" {
  vpc_id = "${aws_vpc.main-vpc.id}"
}


resource "aws_route_table" "AWS-RT" {
  vpc_id = "${aws_vpc.main-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.AWS-IGW.id
  }
}

resource "aws_route_table_association" "AWS-RTA" {
  route_table_id = aws_route_table.AWS-RT.id
  subnet_id = aws_subnet.public_subnet1.id
}
