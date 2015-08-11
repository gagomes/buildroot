Ansible playbook for buildroot
===============================

This playbook tries to automate the deployment and setup of a buildroot build environment for XenServer
so you can focus on what matters.

It requires:
 - XenServer (any version should do, but this has only been tested on version 6.5)
 - python 2.x (tested with version 2.7.6)
 - ansible 1.9.2

Setup:
===============================

Requires python-dev / python-devel installed.

Install ansible via PIP

```shell
pip install -r requirements.txt

```

And type make. 


Notes:
===============================

Don't forget to update the group_vars/all to make sure the defaults apply 
to your local setup

# Inventory

The xenhost group should be the IP address of your XenServer host.
The centos group should be the IP address of your buildroot guest. 

Now, this is the tricky part. We don't typically know the IP addresses 
of the VMs in advanced. So you have two options:

1. Set a reservation on your DHCP for the MAC address in your 
   group_vars/all:vm_mac, which by default is cc:11:22:33:44:55 

2. Create a test VM, set it's network interface to cc:11:22:33:44:55 and
   figure out which IP your DHCP server is leasing to you.


If you run into problems and need support, ping me live on freenode as 
goncalo, or using my github' user at gmail.com

