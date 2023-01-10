# AltSchool 3rd Semester Holiday Challenge

## Tasks

* Set up 2 EC2 instances on AWS(use the free tier instances).

* Deploy an Nginx web server on these instances(you are free to use Ansible)

* Set up an ALB(Application Load balancer) to route requests to your EC2 instances

* Make sure that each server displays its own Hostname or IP address. You can use any programming language of your choice to display this.

* Work on building a personal portfolio and CV (Check out resumeworded.com).

**Task 1**

Set up 2 EC2 instances on AWS(use the free tier instances.

Before I set up the instances, I will be creating a VPC on AWS. A virtual Private Cloud(VPC) is simply a private cloud within a public cloud. It adds an extra layer of security to your instances. It can be configured to have private and public subnetworks(subnet). 

A subnet is a range of IP addresses in your VPC. You can attach AWS resources, such as EC2 instances and RDS DB instances, to subnets. You can create subnets to group instances together according to your security and operational needs.


### How to create a VPC on AWS

* Login to your AWS Console

* Search for VPC

![VPC](./images/Screenshot%202023-01-10%20at%2019.10.16.png)

* Click on VPC

* On the next page, you will see a dashboard with links to VPCs, NAT Gateways, Subnets, etc. Click on the link to VPCs.

![VPC Link](./images/Screenshot%202023-01-10%20at%2019.24.03.png)

* Once you click on the link, it directs you to a page that shows the available VPCs. AWS has a default VPC, but for the scope of this project, we will create a new VPC.

![VPC Create](./images/Screenshot%202023-01-10%20at%2019.24.17.png)

* Once we click on `Create VPC`, it directs us to a page where we can configure and create a VPC to the required specifications of our project.

# Configuring the VPC #

1. Click on the `VPC and More` option. I'll use this option because it will automatically create `Subnets`, `Route tables`, `NAT Gateway`, and other services needed. 

![VPC and More](./images/Screenshot%202023-01-10%20at%2019.33.23.png)

![VPC more](./images/Screenshot%202023-01-10%20at%2019.33.31.png)

2. Give your subnet a name. The `default` appellation is automatically generated. However, you can decide to change it.

Leave the `IPv4 CIDR block`, `IPv6 CIDR block`, `Tenacy`, `Number of Availability Zones (AZs)`, `Number of public subnets`, `Number of private subnets`, and `Customize subnets CIDR blocks` in their default states, except you have specific requirements for your project.

![VPC Defaults](./images/Screenshot%202023-01-10%20at%2019.46.08.png)