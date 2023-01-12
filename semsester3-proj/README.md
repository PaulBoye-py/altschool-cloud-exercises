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


## How to create a VPC on AWS

* Login to your AWS Console

* Search for VPC

![VPC](./images/Screenshot%202023-01-10%20at%2019.10.16.png)

* Click on VPC

* On the next page, you will see a dashboard with links to VPCs, NAT Gateways, Subnets, etc. Click on the link to VPCs.

![VPC Link](./images/Screenshot%202023-01-10%20at%2019.24.03.png)

* Once you click on the link, it directs you to a page that shows the available VPCs. AWS has a default VPC, but for the scope of this project, we will create a new VPC.

![VPC Create](./images/Screenshot%202023-01-10%20at%2019.24.17.png)

* Once we click on `Create VPC`, it directs us to a page where we can configure and create a VPC to the required specifications of our project.

# Configuring the VPC

1. Click on the `VPC and More` option. I'll use this option because it will automatically create `Subnets`, `Route tables`, `NAT Gateway`, and other services needed. 

    ![VPC and More](./images/Screenshot%202023-01-10%20at%2019.33.23.png)

    ![VPC more](./images/Screenshot%202023-01-10%20at%2019.33.31.png)

2. Give your subnet a name. The `default` appellation is automatically generated. However, you can decide to change it.

    Leave the `IPv4 CIDR block`, `IPv6 CIDR block`, `Tenacy`, `Number of Availability Zones (AZs)`, `Number of public subnets`, `Number of private subnets`, and `Customize subnets CIDR blocks` in their default states, except you have specific requirements for your project.

    ![VPC Defaults](./images/Screenshot%202023-01-10%20at%2019.46.08.png)

3. In the `NAT gateways ($)` section, select the second option, which creates a NAT Gateway in 1 AZ(Availability Zone)

    ![VPC Nat](./images/Screenshot%202023-01-10%20at%2021.08.14.png).

    A NAT(Network Address Translation) Gateway enables resources in private subnets to reach the internet. External services, however, cannot initiate a connection with the resources in the private subnets.

4. Leave all the remaining options in their default setting, and click on `Create VPC`

    ![Create VPC](./images/Screenshot%202023-01-10%20at%2021.22.37.png)

    You should see something similar to this. All the necessary services and configurations are being created and implemented.

5. Once the process is complete, you should see the newly created VPC.

    ![Newly Created VPC](./images/Screenshot%202023-01-10%20at%2021.31.43.png)

    If you check the available subnets, you should see four new subnets from the newly created VPC added. Two are private, and two are public.

    ![Subnets](./images/Screenshot%202023-01-10%20at%2021.51.04.png)


## Create EC2 Instances

Instances can be provisioned manually on the AWS Console, and can also be automated using Ansible. You can check this [repo](https://github.com/PaulBoye-py/altschool-cloud-exercises/tree/main/dec_proj/AWS_Ansible) to see how to provision the EC2 instances using Ansible. I will write a blog explaining the playbook, so ensure you subscribe to my posts, but for the sake of this project, we will provision them manually.

1. Type in `EC2` in the search bar.

    ![EC2 search](./images/Screenshot%202023-01-10%20at%2022.03.20.png)

    Click on `EC2`

2. On the next page, click on `Launch Instance`
![Launch Instance](./images/Screenshot%202023-01-10%20at%2022.03.43.png)

    This will take us to the where we configure the instances to our specifications and launch them.

    ![Instance 1](./images/Screenshot%202023-01-10%20at%2022.23.51.png)

3. Fill in the`Name`, `Number of instances`, and the `OS Image` that you require for your. For this project, I have chosen to create 2 instances, with the name `webservers`, and they will be running on the `Ubuntu` distribution of Linux.

    The image below shows the specifications of the `Amazon Machine Image`, and the `Instance type` that I have chosen to work with.

    ![AMI](./images/Screenshot%202023-01-10%20at%2022.25.41.png)

4. In the `Key pair (login)` Section, click on `Create a new Key pair`.

    ![Keypair](./images/Screenshot%202023-01-10%20at%2022.35.09.png)

5. On the page that follows, fill up the form in this manner:

    ![create Key pairs](./images/Screenshot%202023-01-10%20at%2022.35.20.png)

6. The Key pair will be downloaded automatically. Take note of it as we will be needing it to SSH into our servers.

    ![Keypair Download](./images/Screenshot%202023-01-10%20at%2022.35.27.png)

7. Next, we will set up the network settings. 

    * We are not using the default VPC, instead we will use the one we earlier created.

    * Click on `Edit`

    * Select the VPC we earlier created.

    ![Select VPC](./images/Screenshot%202023-01-10%20at%2022.57.53.png)

    * Once selected, the associated subnets will be prepopulated into the subnet field. 

    * Select one of the private subnets. This will automatically disable the `Auto-assign public IP` option. One of the instructions for this project was to assign public IPs to the instances.

        ![Private Network](./images/Screenshot%202023-01-10%20at%2022.58.09.png)

        ![Disable Public IP](./images/Screenshot%202023-01-10%20at%2022.58.47.png)

8. Still under the network settings, we will create a new security group. A security group is a set of rules that control the traffic in and out of your instance. 

    ![security group](./images/Screenshot%202023-01-10%20at%2023.18.55.png)

    **NB**: Make sure you use a name and a description that you can remeber.

9. Leave everything else as they are, and proceed to `Launch instance`. You should see something like this in the next page.

![instance launch](./images/Screenshot%202023-01-10%20at%2023.22.32.png)

---

Welldone, you have just created 2 instances, set a key pair to SSH into the instances, routed them to the VPC we earlier, and created a new Security Group to control the traffic in and out of the instances. 

---
---

Now we will go ahead to create a different instance. This instance will be called a **Bastion Host**. A *bastion host* is a server that will allow us access a private network from an external network. Remember, when we created our instances, we used private subnets, which is inaccessible to the public. In order to setup nginx on the webservers using ansible, we would need to SSH into these instances using our bastion host.

Let's dive into setting up the bastion host.

## Setting up the **Bastion Host**

1. Navigate the AWS console to `Launch Instance`.

2. Create an instance with the following configuration:

    ![Bastion 1](./images/Screenshot%202023-01-10%20at%2023.23.43.png)

    * I named the instance `Bastion`, and selected the same Amazon Machine Image which is `Ubuntu`, with the default configurations.

    * I aslo created a new keypair called bastion, and it has   been downloaded on my local machine.

3. Now, head over to the VPC section and select the same VPC we created and used for the first instances we created.

    ![Bastion 2](./images/Screenshot%202023-01-10%20at%2023.24.08.png)

    * Select any of the **public** subnetworks

    ![Bastion 3](./images/Screenshot%202023-01-10%20at%2023.24.17.png)

    * Now you will see that the `Auto Assign public IP` field will be automatically set 
    to `Enable`. That's great. Leave it like that.

    * 

    