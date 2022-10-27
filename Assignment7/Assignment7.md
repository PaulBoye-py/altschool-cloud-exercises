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

1. Ansible playbook


2. Output of systemctl status apache2 after deploying the playbook

3. Rendered page
![Ansible-php](./images/Screenshot%202022-10-25%20at%2022.30.30.png)