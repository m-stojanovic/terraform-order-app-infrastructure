build {

  name = "assignment-builder"
  sources = [
    "source.amazon-ebs.example"
  ]

  provisioner "shell" {
    inline = ["mkdir -p /home/ec2-user/app/ssl"]
  }

  provisioner "file" {
    name        = "provision_frontend"
    source      = "./files/frontend"
    destination = "/home/ec2-user/app"
  }

  provisioner "file" {
    name        = "provision_backend"
    source      = "./files/backend"
    destination = "/home/ec2-user/app"
  }

  provisioner "file" {
    name        = "provision_dockerfile"
    source      = "./files/Dockerfile"
    destination = "/home/ec2-user/app/Dockerfile"
  }

 provisioner "file" {
    name        = "provision_cert"
    source      = "./files/ssl"
    destination = "/home/ec2-user/app"
}

  provisioner "file" {
    name        = "provision_app"
    source      = "./files/setup_app.sh"
    destination = "/home/ec2-user/app/setup_app.sh"
  }

  provisioner "shell" {
    inline = [
      "/home/ec2-user/app/setup_app.sh"
    ]
  }
}