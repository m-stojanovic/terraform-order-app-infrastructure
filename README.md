<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
* [Built With](#built-with)
* [Getting Started](#getting-started)
* [Prerequisites](#prerequisites)
* [Installation](#installation)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [Contact](#contact)


<!-- ABOUT THE PROJECT -->
## About The Project

The project involves creating a basic ordering system deployed on an EC2 instance using Terraform and Packer. It features a frontend accessible over the internet and a backend connected to an RDS database, with the backend using IAM authentication for database access. Docker is utilized for containerization.

### Built With

* [Terraform](https://terraform.io)
* [Packer](https://packer.io)
* [Docker](https://docker.com)


## Getting Started

To get started with the project, simply run the provided Makefile. This Makefile automates the setup process, including initializing Packer, validating configurations, building the ami with Packer, and then applying the Terraform configurations. 

### Prerequisites

Terraform version 1.4.6 +

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/m-stojanovic/terraform-order-app-infrastructure/issues) for a list of proposed features (and known issues).

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- CONTACT -->
## Contact

Milos Stojanovic

Project Link: [https://github.com/m-stojanovic/terraform-order-app-infrastructure](https://github.com/m-stojanovic/terraform-order-app-infrastructure)