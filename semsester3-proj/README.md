# AltSchool 3rd Semester Holiday Challenge

## Tasks

* Set up 2 EC2 instances on AWS(use the free tier instances).

* Deploy an Nginx web server on these instances(you are free to use Ansible)

* Set up an ALB(Application Load balancer) to route requests to your EC2 instances

* Make sure that each server displays its own Hostname or IP address. You can use any programming language of your choice to display this.

* Work on building a personal portfolio and CV (Check out resumeworded.com).

# Screenshots 

![Screenshot1](./images/Screenshot%202023-01-09%20at%2019.58.21.png)
![Screenshot2](./images/Screenshot%202023-01-09%20at%2019.58.29.png)



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

4. In the Firewall (security groups) section, we will use the security group we earlier created. Therefore click on `Select existing security group` option, and select the one you previously created.

    ![Bastion 4](./images/Screenshot%202023-01-10%20at%2023.24.47.png)

5. Click on `Launch instance`. This will provision the bastion host instance. If you click on the instance, you will see the instance summary for the bastion host. Notice that this instance has a `Public IPv4 address`, and the other 2 servers we created only have `Private IPv4 addresses`. 

    ![Bastion 5](./images/Screenshot%202023-01-10%20at%2023.25.30.png)

---

Now we have set up 3 instances: 2 webservers and 1 bastion host to access the webservers. Firstly, we need to SSH into the bastion server on your local machine. I have setup a virtual Ubuntu server on my local machine. You can go through this [tutorial](https://medium.com/@paul.adeboye/how-to-setup-ubuntu-20-04-lts-on-a-windows-machine-using-vagrant-89a236f13ae) to understand how to do this.

---


## SSH into the Bastion host server

* To SSH into the Bastion host, we will need to have a copy of the Keypair file that we downloaded in our virtual machine. A very easy way to do this is to just create a file with the same name as that of the keypair, and copy the contents of the keypair into that file.

* Let me show you what I mean. On my pc, the Keypair file is called `bastion.pem`. What I will simply do is to create a file named `bastion.pem` in my virtual machine, and copy the contents of the original `bastion.pem` into it. 

* ![Bastion pem file](./images/Screenshot%202023-01-12%20at%2022.26.51.png)

* After copying the contents of the file, I saved it, and now I have a copy of the `bastion.pem` file on my VM. 

* To SSH into the bastion host, use this code format:

        ssh -i <"pem file"> ubuntu@ip address

    * To make things easier, AWS provides us with the code for this. On the page of the instance, look around for a `Connect` button, and click on it. Once you click on it, it takes you to a page that shows you the various ways to connect to an instance. Click on the `SSH client` option, and it will provide you with the code. Copy that code and paste it on your VM's terminal, then click on enter. 

    * The terminal will ask you if you want to continue connection, type in `yes`, and that will be all. You should see something similar to this. 

        ![bastion ssh](./images/Screenshot%202023-01-10%20at%2023.31.51.png)
        
        * You can see that we are logged in as `ubuntu@ip address`, which means we have successfully logged in the bastion host

---

## SSH from Bastion Host to the Private Servers

To SSH into the private servers from the Bastion Host, we will perform the same process we did above.

<<<<<<< HEAD
1. Copy the keypairs of the 2 servers into their respective files with their respective file names.

    ![Server Keypair](./images/Screenshot%202023-01-10%20at%2023.33.05.png)

2. SSH into the server(s) using this command template:

    ```shell
     ssh -i <"pem file"> ubuntu@ip address
    ```

    Here is a picture of mine:

    ![SSH Server](./images/Screenshot%202023-01-10%20at%2023.33.51.png)

    ![SSH Sever2](./images/Screenshot%202023-01-10%20at%2023.34.36.png)

Do this step for the 2 AWS instances you created. Once done, we can then move to configuring Nginx on the private EC2 Servers.

---

## Configuring Nginx on the Private EC2 servers using Ansible

As we know, Ansible is a configurarion management tool that can be applied to configure servers, databases, etc to the required specifications, and at scale.

We will communciate to our private servers, configure and install the necessary packages needed to deploy Nginx and a page displaying the server's IP private IP Address, all done using Ansible.

Let's get into it!!

1. Login back into your Bastion host server and run the following command to update and upgrade the package libraries and repos:

```
    sudo apt update && sudo apt upgrade -y
```

![sudo apt update](./images/Screenshot%202023-01-10%20at%2023.36.01.png)


2. Once updated, we can proceed to install ansible on the Bastion host with the command:

    ```shell
        sudo apt install ansible -y
    ```

![sudo apt install ansible](./images/Screenshot%202023-01-10%20at%2023.37.03.png)


3. To successfully install Nginx on our servers, we need to create 3 files, namely: 

* Host inventory file: contains the IP addresses of the targer servers;
* ansible.cfg file: We can define our default configurations here;
* ansible playbook file(yml file): this is where we write the actual ansible commands to be executed on the servers.

### Ansible configuration (ansible.cfg) file

* Create the ansible.cfg file with the following command:

```shell
sudo vi ansible.cfg
```

Write the following commands in the text editor:
```shell
[defaults]
inventory = inventory
private_key_file = ~/myproj.pem
```
![ansible.cfg](./images/Screenshot%202023-01-10%20at%2023.39.54.png)

**NB:** The `private_key_file` is the file that contains the keypair for your webservers.


### Host inventory file

* Create the host inventory file

```shell
sudo vi inventory
```

![inventory](./images/Screenshot%202023-01-10%20at%2023.40.30.png)

* Write the following commands in the text editor:

```shell
<Private IP Address 1>
<Private IP Address 2>
```

Copy and paste the respective private IP addresses of the servers.

### Ansible Playbook file

This is the `.yml` file that will contain the commands to be executed on the server. I named mine `main.yml`.

```shell
sudo vi main.yml
```

Copy the following code to the file:

```shell
---

- hosts: all
  become: yes
  tasks:

  - name: update & upgrade server
    apt:
      update_cache: yes
      upgrade: yes

  - name: install nginx
    apt:
      name: nginx
      state: latest

  - name: add hostname to server
    tags: print
    shell: echo "<h1>This is my server $(hostname -f)</h1>" > /var/www/html/index.nginx-debian.html

  - name: restart nginx
    tags: restart
    service:
      name: nginx
      state: restarted
      enabled: yes
```

![main.yml](./images/Screenshot%202023-01-10%20at%2023.42.54.png)

But before we run the playbook, we need to ensure that ansible can communicate with our servers. Run the ansible ping code to check:

```shell
ansible all -m ping -v
```

A successful ping should return a message like this:

![ansible ping](./images/Screenshot%202023-01-10%20at%2023.45.47.png)

It looks good now, so let's execute the main.yml file with the command:

```shell
ansible-playbook -i inventory main.yml
```

![ansible playbook](./images/Screenshot%202023-01-09%20at%2019.21.17.png)
=======
1. Copy the keypairs of the 2 servers into their respective files with their respective file names.
>>>>>>> master
