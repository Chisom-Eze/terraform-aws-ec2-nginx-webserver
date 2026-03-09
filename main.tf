resource "aws_vpc" "Cloud-Ops" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Cloud-Ops"
  }
}


resource "aws_subnet" "Cloud-Ops-subnet" {
  vpc_id                  = aws_vpc.Cloud-Ops.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Cloud-Ops-subnet"
  }
}


resource "aws_internet_gateway" "Cloud-Ops-igw" {
  vpc_id = aws_vpc.Cloud-Ops.id

  tags = {
    Name = "Clouds-Ops-igw"
  }
}


resource "aws_route_table" "Cloud-Ops-rt" {
  vpc_id = aws_vpc.Cloud-Ops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Cloud-Ops-igw.id
  }

  tags = {
    Name = "Cloud-Ops_rt"
  }
}


resource "aws_route_table_association" "Cloud-Ops-assoc" {
  subnet_id      = aws_subnet.Cloud-Ops-subnet.id
  route_table_id = aws_route_table.Cloud-Ops-rt.id
}


resource "aws_security_group" "web_sg" {
  name        = "Cloud-Ops-sg"
  description = "Cloud-Ops-sg"
  vpc_id      = aws_vpc.Cloud-Ops.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["102.90.97.228/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Cloud-Ops-web_sg"
  }
}


data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "Cloup-Ops_web-server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.Cloud-Ops-subnet.id

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  key_name = "Cloud-Ops"

  user_data = file("user-data.sh")

  tags = {
    Name = "Cloud-Ops-ec2"
  }
}