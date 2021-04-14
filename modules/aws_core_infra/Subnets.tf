resource "aws_subnet" "pub_sub1" { 
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sub_cidr_1
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name                     = "${lower(var.app_name)}-pub-sub-1"
  }
}

resource "aws_subnet" "pub_sub2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sub_cidr_2
  availability_zone       = "us-west-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "${lower(var.app_name)}-pub-sub-2"
  }
}


resource "aws_subnet" "pri_sub1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.pri_sub_cidr_1
  availability_zone = "us-west-1a"
  tags = {
    Name = "${lower(var.app_name)}-pri-1"
  }
}

resource "aws_subnet" "pri_sub2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.pri_sub_cidr_2
  availability_zone = "us-west-1c"
  tags = {
    Name = "${lower(var.app_name)}-pri-2"
  }
}