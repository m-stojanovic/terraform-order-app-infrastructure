
resource "aws_key_pair" "assignment" {
  key_name   = "assignment-server"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCyW46gtJOCtf7LRE0cZtHkU5DSXXRV/EKazQdUQVukPTw1Fr9IUBUdXq2E1Okwx/LVz1kdijk8ejvwwnKsMEluYs8rN8uDfTWuQqVlZoXtP9v2RKvW3JkIPNbKA49o18o+i0L8EVNAXxeOd4sROyS7klf368j/OJfJvON6DQ/chHogwsQvQhZPOCQRE7I2n7hH4SQclewzvRjyQ8JJ2/kPxOtuqp1rGFjrm0DumHCGBjCuSufSZNI/cpY3yTtuAHk3JKhsYr3mz7xOujtcFH8cVoh35+id5JuVZ+nrHND74LNWDgHhMXuPx3iSBZMadjozS8d7BN/VgFxQzmo/3OL2Uq6wMtvQhL75j9b24Kgrt7HpQTIG3xJCmNSZXAyppfRFDkA2LgqgUQF3AdvEOYCDccg2i+N1M2LwJqBjNizILgiMfKlSUD9bCyrsrdlYrE0YtuqyQZ4IAv8NHsCSDE5UBzeL9hCrvMaJ0NrOYjmLlNh2z6N4LeOgK602har1Rna88MSGzxPufz7xPlxeUIW4o7bn/vv/CDYI3Me7F0hFtvVx4bBsup1cvaIOjQ87kCFO/8YDwBMlcwSkLT3HcZ3L6C+c6T927lbnTDO/Cl3Wd+YoeBLK2CssWhBdmK6w2v2LNlMA88F/k6GULBW7L8aiA1Jr8s1Tk+ApKjFuPMPrKQ== mstojanovic@Milos-MacBook-Pro.local"
}

resource "aws_iam_instance_profile" "ec2_rds_iam_profile" {
  name = "ec2-rds-iam-profile"
  role = aws_iam_role.ec2_rds_iam_role.name
}

resource "aws_instance" "assignment" {
  ami                         = data.aws_ami.latest.id
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnets[0]
  key_name                    = aws_key_pair.assignment.key_name
  vpc_security_group_ids      = [aws_security_group.assignment-ec2-sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_rds_iam_profile.name
  associate_public_ip_address = true
  tags                        = merge(tomap({ "Name" = "assignment-server" }), var.tags)

  user_data = <<-EOF
              #!/bin/bash
              export PGPASSWORD='${var.rds_password}' && psql --host=${aws_db_instance.assignment-rds.address} --port=${aws_db_instance.assignment-rds.port} --username=dbuser --dbname=${var.rds_dbname} -c 'CREATE USER db_user_iam; GRANT rds_iam TO db_user_iam;'
              sudo systemctl start docker
              sudo docker run -d -p 80:80 frontend-app
              sudo docker run -d -p 3000:3000 -e "DB_HOST=${aws_db_instance.assignment-rds.address}" -e "DB_PORT=${aws_db_instance.assignment-rds.port}" -e "DB_DATABASE=${var.rds_dbname}" -e "DB_USERNAME=${var.rds_username}" -e "AWS_REGION=${var.aws_region}" -e "DB_ACCESS_TYPE=iam" -v /home/ec2-user/app/ssl:/certs backend-app:latest
              EOF      

  depends_on = [aws_db_instance.assignment-rds]
}

resource "aws_security_group" "assignment-ec2-sg" {
  name        = "assignment-ec2-server-sg"
  description = "Security group to allow access to assignment server."
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "allow access from everywhere on port 22"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "allow access from everywhere on port 80"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    description = "allow external access to everywhere"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(tomap({ "Name" = "assignment-ec2-server-sg" }), var.tags)
}