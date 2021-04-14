
#IAM Role Policy

resource "aws_iam_role" "role" {
  name               = "${local.app_name}-SSM-IAM-ROLE"
  description        = "IAM role for EC2 instance"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    Name = "${local.app_name}-SSM-IAM-ROLE"
  }
}

resource "aws_iam_instance_profile" "profile" {
  name = "${local.app_name}-SSM-IAM-ROLE"
  role = aws_iam_role.role.name
}

resource "aws_iam_role_policy_attachment" "att1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.role.name
}
resource "aws_iam_role_policy_attachment" "att2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess"
  role       = aws_iam_role.role.name
}