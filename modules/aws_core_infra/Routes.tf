resource "aws_route_table" "routes" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${lower(var.app_name)}-pub-rt"
  }
}


resource "aws_route_table_association" "associations" {
  subnet_id      = aws_subnet.pub_sub1.id
  route_table_id = aws_route_table.routes.id
}

resource "aws_route_table_association" "associations_pub2" {
  subnet_id      = aws_subnet.pub_sub2.id
  route_table_id = aws_route_table.routes.id
}


resource "aws_route" "default" {
  route_table_id         = aws_route_table.routes.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "private_route_nat" {
  route_table_id         = aws_route_table.private_routes_nat.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}


resource "aws_route_table" "private_routes_nat" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${lower(var.app_name)}-private-rt"
  }
}
 
resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.private_routes_nat.id
}

resource "aws_route_table_association" "private_associations" {
  subnet_id      = aws_subnet.pri_sub1.id
  route_table_id = aws_route_table.private_routes_nat.id
}

resource "aws_route_table_association" "private_associations2" {
  subnet_id      = aws_subnet.pri_sub2.id
  route_table_id = aws_route_table.private_routes_nat.id
}



