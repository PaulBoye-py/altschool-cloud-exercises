# AltSchool Cloud Engineering

## Assignment 2

___

### 1. Display CPU information

```cmd
    cat /proc/cpuinfo
```

The cat /proc/cpuinfo command displays what type of processor your system is running including the number of CPUs present.

![cat /proc/cpuinfo command](/Assignment2/images/Screenshot%20(40).png)
___

### 2. Display all environment variables

```cmd
    env
```

The env command allows you to display your current environment or run a specified command in a changed environment. If no flags or parameters are specified, the env command displays your current environment, showing one Name=Value pair per line.

![env command](/Assignment2/images/Screenshot%20(39).png)
___

### 3. Display processor related statistics

```cmd
    mpstat 1
```

The mpstat command writes to standard output activities for each
available processor, processor 0 being the first one.  Global
average activities among all processors are also reported.  The
mpstat command can be used on both SMP and UP machines, but in
the latter, only global average activities will be printed. If no
activity has been selected, then the default report is the CPU
utilization report.

![mpstat 1](/Assignment2/images/Screenshot%20(42).png)
___

### 4. Show system reboot history

```cmd
    last reboot
```

The `last reboot` command,  displays all the previous reboot date and time for the system. This picks the information from the /var/log/wtmp file.

![last reboot](/Assignment2/images/last%20reboot.png)
___

### 5. Display DNS information for domain

```cmd
    dig domain
```

The dig command in Linux is used to gather DNS information. It stands for Domain Information Groper, and it collects data about Domain Name Servers. The dig command is helpful for troubleshooting DNS problems, but is also used to display DNS information.

![dig domain](/Assignment2/images/dig%20domain.png)
___

### 6. Add a new user**

```cmd
    sudo adduser username
```

When invoked, useradd creates a new user account according to the options specified on the command line and the default values set in the /etc/default/useradd file.

![adduser](/Assignment2/images/add%20user.png)
___

### 7.  List all users in a Linux system

```cmd
    cat /etc/passwd
```

Use the “cat” command to list all the users on the terminal to display all the user account details and passwords stored in the /etc/passwd file of the Linux system.

![cat /etc/passwd](/Assignment2/images/catetc.png)
___

### 8. Display I/O statistics

```cmd
    iostat
```

The iostat command in Linux is used for monitoring system input/output statistics for devices and partitions. It monitors system input/output by observing the time the devices are active in relation to their average transfer rates.

![iostat](/Assignment2/images/iostat.png)
___

### 9. Display free and used memory

```cmd
    free -h
```

The `free -h` command is used to display free and used memory in the OS.
`-h` for human readable, `-m` for MB, `-g` for GB.

![free](/Assignment2/images/free.png)
___

### 10. Browse through a text file

```cmd
    less file
```

The less command is a Linux terminal pager that shows a file's contents one screen at a time. It is useful when dealing with a large text file because it doesn't load the entire file but accesses it page by page, resulting in fast loading speeds.

![less](/Assignment2/images/less.png)
___
