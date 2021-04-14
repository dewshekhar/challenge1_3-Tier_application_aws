
#Application Server Key

resource "aws_key_pair" "keypair" {
  key_name   = "mediawiki"
  public_key = file(local.PATH_TO_PUBLIC_KEY)
  tags = {
    Name = "${local.app_name}-KEY"
  }
}

