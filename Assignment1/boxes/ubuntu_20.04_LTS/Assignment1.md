# AltSchool Cloud Engineering Assignment 1

## Task: Setup Ubuntu 20.04 LTS on your local machine using Vagrant

Vagrant is a tool for building and managing virtual machine environments in a single workflow. With an easy-to-use workflow and focus on automation, Vagrant lowers development environment setup time, increases production parity, and makes the "works on my machine" excuse a relic of the past.

**Step 1** : Download and install [Vagrant](https://www.vagrantup.com/ "Vagrant") on your local machine.

**Step 2** : On your terminal, create a folder where you will be running        Vagrant on your local machine.

    mkdir ubuntu20.04_LTS
    cd ubuntu20.04_LTS

**Step 3** : Since we are going to be running Ubuntu 20.04 LTS, we will have to initilaize Vagrant in that folder by running the command below:

    vagrant init ubuntu/focal64

This initializes the current directory to be a Vagrant environment by creating an initial Vagrantfile if one does not already exist. The `ubuntu/focal64` part just tells Vagrant to use Ubuntu 20.04 LTS when initializing.

Once you press `enter`, you should see the following prompt:

    A Vagrantfile has been placed in this directory. You are now
    ready to vagrant up your first virtual environment! Please read
    the comments in the Vagrantfile as well as documentation on
    vagrantup.com for more information on using Vagrant.

To see the contents of the Vagrantfile, run the command below:

    cat Vagrantfile

The Vagrantfile contains a bunch of configuration code that vagrant uses to know what kind of machine it should spin up, and how it should set it up.

**Step 4** : Customize your Vagrantfile as necessary with private_network set to dhcp.

To do this, open the Vagrantfile in notepad(for windows users), or any other text editor.
Under the part that talks about  creating a private network, which allows host-only access to the machine using a specific IP, uncomment the ruby code written below it, remove `ip: "aaa.bbb.xx.yy"`, and add  `type: "dhcp"`.

The final result should look like this:

    #Create a private network, which allows host-only access to the machine
    #using a specific IP.
    config.vm.network "private_network", type: "dhcp"

**Step 5** : Start your machine by running the code:

    vagrant up

The code above runs the virtual machine to the specification of the configurations in the Vagrantfile.

You may have this error if you already have a another virtual machine that is already running using DHCP on the same hypervisor for the same machine, for example, a VirtualBox machine.

    A host only network interface you're attempting to configure via DHCP
    already has a conflicting host only adapter with DHCP enabled. The
    DHCP on this adapter is incompatible with the DHCP settings. Two
    host only network interfaces are not allowed to overlap, and each
    host only network interface can have only one DHCP server. Please
    reconfigure your host only network or remove the virtual machine
    using the other host only network.

To resolve this, end the previous machine, or ppen the Vagrantfile, and run the following monkey patch at the top of the Vagrantfile.

    Vagrant.configure("2") do |config|
    #Type the code below
        class VagrantPlugins::ProviderVirtualBox::Action::Network
            def dhcp_server_matches_config?(dhcp_server, config)
                true
            end
        end

**Step 6** : To access the machine, you will need to login to the machine by running the code:

    vagrant ssh

This gives a prompt that welcomes you to the OS. It also shows some sysytem information.

**Step 7** : To view the interface configuration(`ifconfig`), you will need to install net-tools by running the command below:

    sudo apt install net-tools

Once net-tools has been installed, run the command below to view the network interface configuration.

    ifconfig

The interface configuration looks like this:

    enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
        inet6 fe80::74:c4ff:fe03:bf7e  prefixlen 64  scopeid 0x20<lin
        ether 02:74:c4:03:bf:7e  txqueuelen 1000  (Ethernet)
        RX packets 1582  bytes 395489 (395.4 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1170  bytes 175299 (175.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

    enp0s8: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
            inet 192.168.56.101  netmask 255.255.255.0  broadcast 192.168
            inet6 fe80::a00:27ff:fe61:6efa  prefixlen 64  scopeid 0x20<li
            ether 08:00:27:61:6e:fa  txqueuelen 1000  (Ethernet)
            RX packets 12  bytes 4430 (4.4 KB)
            RX errors 0  dropped 0  overruns 0  frame 0
            TX packets 27  bytes 4123 (4.1 KB)
            TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

    lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
            inet 127.0.0.1  netmask 255.0.0.0
            inet6 ::1  prefixlen 128  scopeid 0x10<host>
            loop  txqueuelen 1000  (Local Loopback)
            RX packets 26  bytes 2536 (2.5 KB)
            RX errors 0  dropped 0  overruns 0  frame 0
            TX packets 26  bytes 2536 (2.5 KB)
            TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

![iconfig]
(<https://drive.google.com/file/d/1adHUE9USirYaWMyv5hT9Z6sfBeeGBFHC/view?usp=sharing>)

**For more information**, read the [Vagrant documentation.](https://www.vagrantup.com/docs "Vagrant documentation")
