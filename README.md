## The cyber lab. Learn information technology and cyber security.

### Please see the following network diagram to get started. 
`Cyber Lab Physical Diagram.drawio`

I have made every attempt to cut costs and use free open-source software where I could.
I recommend using HP Z600 or the HP Z800 series workstations as they are very quiet and they are cheap. However, they do consume a fair amount of electricity compared to modern chipsets, 160W at max capacity but they can be configured with large amounts of RAM and have multiple processors which is what we need with out the heat and the noise for a home lab. 

### Installing ESXi
To get started the first thing that you want to do is install esxi on your servers this will give you the ability to host virtual machines and after installing Docker the ability to host containers.
Don't worry about all the networking We'll get to that in a bit

### Configuring your switches
The next thing that you're going to need to do is configure your switch. This is not a difficult process. Use the following configuration for each link from the switch to the ESXI hosts.

```
interface GigabitEthernet0/xx
description Link from switch to ESXi01 
switchport trunk encapsulation dot1q
switchport mode trunk
switchport nonegotiate
spanning-tree portfast trunk
```

```
The DockerAndApps.sh script will install docker, docker-compose, Portainer, juice-shop.```

```
txt
```

```
txt
```
