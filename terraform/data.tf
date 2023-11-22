data "aws_ami" "latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["assignment-node-*"]
  }

  owners = ["self"]
}