## The Cyber Lab. 

### Please see the following network diagram to get started. 
`Cyber Lab Physical Diagram.drawio`

I have made every attempt to cut costs and use free open-source software where I could.
I recommend using HP Z600 or the HP Z800 series workstations as they are very quiet and they are cheap. However, they do consume a fair amount of electricity compared to modern chipsets, 160W at max capacity but they can be configured with large amounts of RAM and have multiple processors which is what we need with out the heat and the noise for a home lab. 

### Installing ESXi
To get started the first thing that you want to do is install esxi on your servers this will give you the ability to host virtual machines.
Don't worry about all the networking We'll get to that in a bit.
Steps:
1. Prepare Installation Media
Using a USB Flash Drive:

Download the ESXi 6.7 ISO image from the VMware website.
Use a tool like Rufus to create a bootable USB drive:
Open Rufus.
Select your USB drive.
Select the ESXi 6.7 ISO image.
Click Start to create the bootable USB drive.
Using a CD/DVD:

Download the ESXi 6.7 ISO image from the VMware website.
Burn the ISO image to a CD/DVD using a tool like ImgBurn or any other ISO burning software.
2. Boot from Installation Media
Insert the bootable USB drive or CD/DVD into the server.
Power on the server and enter the BIOS/UEFI settings (usually by pressing a key like F2, F10, F12, ESC, or DEL during the boot process).
Configure the server to boot from the USB drive or CD/DVD.
Save the changes and exit the BIOS/UEFI settings. The server should now boot from the installation media.
3. Install ESXi 6.7
Boot Screen:

When the server boots from the installation media, you will see the ESXi 6.7 boot screen. Press Enter to start the installation.
Loading ESXi Installer:

The installer will load necessary files. This might take a few minutes.
Welcome Screen:

On the Welcome to the VMware ESXi 6.7 Installation screen, press Enter to continue.
End User License Agreement (EULA):

Read the EULA and press F11 to accept and continue.
Select Storage Device:

The installer will display a list of available storage devices. Select the storage device where you want to install ESXi 6.7 and press Enter.
Select Keyboard Layout:

Choose your keyboard layout and press Enter.
Set Root Password:

Enter a strong root password, confirm it, and press Enter.
Confirm Installation:

The installer will warn you that the selected disk will be repartitioned. Press F11 to confirm and start the installation.
Installation Progress:

The installer will copy files and install ESXi 6.7. This might take a few minutes.
Installation Complete:

Once the installation is complete, you will be prompted to remove the installation media and press Enter to reboot the server.
4. Post-Installation Configuration
Boot into ESXi:

After rebooting, the server will boot into the ESXi 6.7 hypervisor.
Initial Configuration:

You will see the Direct Console User Interface (DCUI). Press F2 to customize the system.
Log in using the root username and the password you set during the installation.
Network Configuration:

Configure the network settings:
Select Configure Management Network.
Set the network adapter, VLAN (if needed), IP configuration (static IP is recommended), DNS configuration, and hostname.
Apply Changes:

Press Esc to exit the network configuration menu. You will be prompted to restart the management network to apply the changes. Confirm the restart.
5. Access the ESXi Host
Web Interface:

From a web browser, access the ESXi host by navigating to https://[ESXi-host-IP].
Log in with the root credentials.
Configuration and Management:

From the ESXi web interface, you can configure, manage, and monitor your ESXi host.
Additional Resources:
VMware Documentation:
Refer to the official VMware documentation for more detailed instructions and best practices: VMware ESXi 6.7 Documentation.
Following these steps will help you successfully install VMware ESXi 6.7 on your server.


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
