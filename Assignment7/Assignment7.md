# Ansible Assignment

## Task:

Create an Ansible Playbook to setup a server with Apache
The server should be set to the Africa/Lagos Timezone
Host an index.php file with the following content, as the main file on the server:

```bash
<?php
date("F d, Y h:i:s A e", time());
?>
```

Instruction:
Submit the Ansible playbook, the output of systemctl status apache2 after deploying the playbook and a screenshot of the rendered page.

**1. Ansible playbook**
```bash
# install Apache2 using Ansible
- name: Setup Ansible server on myserver list (host group)
  hosts: myservers
  become: True
  vars:
    apache2_version: 2.4.41
  tasks:
    # first task --- instal apache2
    - name: Install the latest version of nginx
      command: apt install apache2 -y

    # second task --- start the service
    - name: Start apache2
      service:
        name: apache2
        enabled: yes
        state: started

    # third task --- confirm apache2 version
    - name: Get nginx installed version
      command: apache2 -v
      register: apache2_version
    # print the current version of apache2 on screen
    - name: print apache2 version
      debug:
        msg: "The current version of apache2 is {{apache2_version}}"

    # forth task --- connfirm status
    - name: Getthe status of apache2 service
      command: systemctl status apache2

    # fifth task --- set server to Africa/Lagos timezone
    - name: Set timezone to Africa/Lagos
      command: timedatectl set-timezone Africa/Lagos
    # sixth task --- confirm time zone has been changed correctly
    - name: Get status of timezone
      command: timedatectl
      
    #Install php7.4 on box2
    # install all necessary prerequisites
    - name: php  prerequisites
      command: apt install apt-transport-https lsb-release software-properties-common ca-certificates -y
      
    - name: install using ppa:ondrej/php repository
      command: add-apt-repository ppa:ondrej/php -y

    - name: install php7.4
      command: apt install php7.4 -y 
```
![ansible-playbook](./images/Screenshot%202022-10-28%20at%2000.43.23.png)

The playbook was saved in install-apache2.yml


**2. Output of systemctl status apache2 after deploying the playbook**

```bash
 apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor prese>
     Active: active (running) since Fri 2022-10-28 00:20:54 WAT; 9min ago
       Docs: https://httpd.apache.org/docs/2.4/
   Main PID: 769 (apache2)
      Tasks: 6 (limit: 1131)
     Memory: 16.8M
     CGroup: /system.slice/apache2.service
             ├─769 /usr/sbin/apache2 -k start
             ├─782 /usr/sbin/apache2 -k start
             ├─783 /usr/sbin/apache2 -k start
             ├─787 /usr/sbin/apache2 -k start
             ├─788 /usr/sbin/apache2 -k start
             └─789 /usr/sbin/apache2 -k start

```
![systemctl-status-apache2](./images/Screenshot%202022-10-28%20at%2000.35.39.png)

**3. Rendered page**
![Ansible-php](./images/Screenshot%202022-10-25%20at%2022.30.30.png)