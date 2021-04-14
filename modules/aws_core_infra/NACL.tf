
resource "aws_default_network_acl" "main" {
  default_network_acl_id = aws_vpc.main.default_network_acl_id
  egress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  subnet_ids = [aws_subnet.pub_sub1.id, aws_subnet.pub_sub2.id, aws_subnet.pri_sub1.id, aws_subnet.pri_sub2.id]
  tags = {
    Name = "${lower(var.app_name)}-nacl"
  }
}


