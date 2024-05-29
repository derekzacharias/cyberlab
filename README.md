## The Cyber Lab. 

### Please see the following network diagram to get started. 
`Cyber Lab Physical Diagram.drawio`

I have made every attempt to cut costs and use free open-source software where I could.
I recommend using HP Z600 or the HP Z800 series workstations as they are very quiet and they are cheap. However, they do consume a fair amount of electricity compared to modern chipsets, 160W at max capacity but they can be configured with large amounts of RAM and have multiple processors which is what we need with out the heat and the noise for a home lab. 

### Installing ESXi
To get started the first thing that you want to do is install esxi on your servers this will give you the ability to host virtual machines.
Don't worry about all the networking We'll get to that in a bit.

### Prerequisites
Hardware Requirements
Compatible server with at least 4 GB RAM.
x64 processor with Intel VT-x or AMD-V support.
Storage space for ESXi installation.
Software Requirements
Download the ESXi 6.7 ISO from the VMware website.
Steps
### 1. Prepare Installation Media
Using a USB Flash Drive
Download the ESXi 6.7 ISO.
Use Rufus to create a bootable USB drive.
Using a CD/DVD
Download the ESXi 6.7 ISO.
Burn the ISO to a CD/DVD using software like ImgBurn.
### 2. Boot from Installation Media
Insert the bootable USB drive or CD/DVD.
Enter BIOS/UEFI settings and set the server to boot from the installation media.
Save changes and reboot.
### 3. Install ESXi 6.7
Boot Screen:

Press Enter to start the installation.
Loading Installer:

Wait for the installer to load.
Welcome Screen:

Press Enter.
EULA:

Press F11 to accept.
Select Storage Device:

Choose the storage device for installation and press Enter.
Keyboard Layout:

Select your keyboard layout and press Enter.
Set Root Password:

Enter and confirm a strong root password.
Confirm Installation:

Press F11 to start the installation.
Complete Installation:

Remove installation media and press Enter to reboot.
4. Post-Installation Configuration
Boot into ESXi:

The server boots into the ESXi 6.7 hypervisor.
Initial Configuration:

Press F2 and log in with root credentials.
Network Configuration:

Select Configure Management Network:
Set network adapter, VLAN (if needed), IP configuration, DNS, and hostname.
Press Esc and confirm to restart the management network.
5. Access the ESXi Host
Web Interface:

Open a browser and navigate to https://[ESXi-host-IP].
Log in with root credentials.
Configuration and Management:

Use the ESXi web interface to configure, manage, and monitor the host.


### Configuring your switches
The next thing that youneed to do is configure your switch. Use the following configuration for each link from the switch to the ESXI hosts.

```
interface GigabitEthernet0/xx
description Link from switch to ESXi01 
switchport trunk encapsulation dot1q
switchport mode trunk
switchport nonegotiate
spanning-tree portfast trunk
```
### Next configure the vlans 
```
configure terminal
vlan 10
 name Clients
!
vlan 15
 name Management
!
vlan 20
 name Servers
!
end
copy run start
```

```
The DockerAndApps.sh script will install docker, docker-compose, Portainer, juice-shop.```

```
txt
```

```
txt
```
