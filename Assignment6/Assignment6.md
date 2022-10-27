# Assignment 6

## Task

Create a bash script to run at every hour, saving system memory (RAM) usage to a specified file and at midnight it sends the content of the file to a specified email address, then starts over for the new day.

1. My Bash script

```linux
#!/bin/bash

#path to the directory where the file should be created and used:
path=/home/vagrant/altschool/scripts/memory-logs/log_file.log

#string formatting from date to extract hour and minute
midnight=$(date +%H%M)

#email address to receive the alert
email=paul.adeboye1@gmail.com

#This command creates the log_file.log at the specified path. Notice how we call the path variable.
sudo touch ${path}

if [[ ${midnight} == 0000 ]];
then echo "Your midnight report is ready" | mutt -a ${path} -s "Midnight RAM Report" -- ${email} && sudo rm -f ${path}
else
 date >> ${path}
 free -h >> ${path}
echo "----"
fi
```

![Bash Script](./images/Screenshot%202022-10-25%20at%2010.17.11%2011.16.00.png)

2. My Cronjob

![My cronjob](./images/Screenshot%202022-10-25%20at%2010.19.22.png)

3. Email 
![Email](./images/Screenshot%202022-10-27%20at%2023.55.34.png)