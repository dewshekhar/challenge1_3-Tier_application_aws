resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub_sub1.id
  tags = {
    Name            = "${lower(var.app_name)}-nat-gateway"
  }
}

resource "aws_eip" "eip" {
  vpc   = true
  tags = {
    Name = "${lower(var.app_name)}-nat-eip"
  }
}