resource "aws_iam_role" "ec2_rds_iam_role" {
  name = "EC2RDSIAMRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
      },
    ]
  })
}

resource "aws_iam_policy" "rds_iam_auth" {
  name        = "RDSIAMAuthentication"
  description = "Policy for EC2 IAM authentication to RDS"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "rds-db:connect",
        Resource = "arn:aws:rds-db:${var.aws_region}:${var.aws_account_id}:dbuser:${aws_db_instance.assignment-rds.resource_id}/${var.rds_username}"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_iam_attachment" {
  role       = aws_iam_role.ec2_rds_iam_role.name
  policy_arn = aws_iam_policy.rds_iam_auth.arn
}