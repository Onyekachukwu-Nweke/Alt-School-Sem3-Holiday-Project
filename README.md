![project-logo](/images/AltSchool-Holiday-Sem3.jpeg)

# Deployment of a High Availability Website on Different Zones in the same Region(us-east-1)

_From the Diagram above requirements needed for the project_:

- VPC
- Four (4) Subnets
- Three (3) Route Tables
- One (1) Internet Gateway
- Two Nat Gateway
- One (1) Application Balancer
- Launch Template for AutoScaling Group
- AutoScaling Group (ASG)

## Creation of A Virtual Private Cloud (VPC)

VPC is used to isolate cloud resources

## Creation of Four (4) Subnets 

![subnets](/images/subnet.png)

I created four subnets, 2 private and 2 public each Availability Zone has Two subnets(1 public and 1 private)

The NAT gateway will be placed in the public subnets to be able to allow them to connect to the internet and provide a routing gateway for the private subnets

## Creation of the Three (3) Route tables

![route-tables](/images/routetables.png)

The main route table is the default route table and the Internet gateway will be connected to it.

While the other private route tables will be routed to the NAT gateway to allow the private instances internet access

## Creation of Launch Template for AutoScaling Group

![launch template](/images/launch-temp.png)

A Launch template is used for the creation of an AutoScaling Group so that the machine type used will be uniform to avoid infrastructural failure.

![ami](/images/ami.png)

The ami id is used to create an identical machine instance for the project.

![sec-group](/images/web-sec-group.png)

A security group is created for the template having port 80 for inbound and all traffic for outbound

And I created a launch script called user data

```
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y --no-install-recommends php8.1
    sudo apt-get install -y php8.1-cli php8.1-common php8.1-mysql php8.1-zip php8.1-gd php8.1-mbstring php8.1-curl php8.1-xml php8.1-bcmath php8.1-fpm
    sudo systemctl reload php8.1-fpm
    git clone https://github.com/Onyekachukwu-Nweke/server_stats_template.git
    sudo apt install -y nginx
    sudo mv server_stats_template/assets /var/www/html/
    sudo mv server_stats_template/index.php /var/www/html/
    git clone https://github.com/Onyekachukwu-Nweke/Alt-School-Sem3-Holiday-Project.git
    sudo cat Alt-School-Sem3-Holiday-Project/nginx | sudo tee /etc/nginx/sites-available/default
    sudo mv /var/www/html/index.nginx-debian.html ../
    sudo systemctl reload php8.1-fpm
    sudo systemctl restart nginx
```

## Creation of 