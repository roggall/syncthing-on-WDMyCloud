# Syncthing-on-WDMyCloud
A wrap of the Syncthing app compiled for ARM 32 to be installed on WDMyCloud NAS


You must configure a Syncthing share on yor NAS, this creates the user syncthing that will launch the Syncthing app, and then install the WDMyCloud_syncthing_1.xx.bin;

the configure button on the WDMyCloud windows will you give the access to the web page of Syncthing, then you can proceed using Syncthing as usual;
the web interface is available as well at the address <WDMyCloud's-IP-address>:8384;

please refer to https://syncthing.net/ for any question about Syncthing;

if you want Syncthing be accessible from the web, allow the NAT for <WDMyCloud's-IP-address>:22000 on your access router toward the WAN (the NT or the ONT).




Please note: the WDMyCloud_syncthing_1.xx.bin has been compiled for the NAS 'WDMyCloud' while the tool MyCloudOS5_mksapkg supports the following NAS models:
- WDMyCloud
- WDMyCloudEX4100
- WDMyCloudDL4100
- WDMyCloudEX2100
- WDMyCloudDL2100
- WDMyCloudMirror
- MyCloudEX2Ultra
- MyCloudPR4100
- MyCloudPR2100
- WDCloud

Since I cannot test it for other NAS than WDMyCloud, I leave you to test it on other systems:

to do this you can clone the project, modifing the proper files in the syncthing directory, and the launching
./comp.sh
so to get the new version of WDMyCloud_syncthing_1.xx.bin;

within comp.sh is the statement to compile for the proper NAS, plase test it by launching
./MyCloudOS5_mksapkg

please note that each time you launch ./comp.sh the minor release number will increase, the release number is written within apkg.rc; you can enable the verbosity through the file 'verbose', if you need to debug the processes;
if the file 'verbose' contains the word "enabled" in the first line then a log file will log each output you see on the screen;

in order to compile the project you have to follow the intructions detailed in My_Cloud_OS_5_NAS_App_Guide_04292021.zip, you can find it on the web;
the project is compilable on a Debian 10 system:

    Below are the instructions to install the toolchain and setup the build environment for Godzilla, and it is for ARM platform:
    1. Install Debian 10 amd64 Linux
    2. Install needed packages
    # dpkg --add-architecture armhf
    # apt-get update
    # apt-get install apt-utils=1.8.2 apt-file=3.2.2 pkg-config=0.29-6 build-essential=12.6 devscripts=2.19.5+deb10u1
    # apt-get install automake=1:1.16.1-4 autotools-dev=20180224.1 autoconf=2.69-11 autopoint=0.19.8.1-9 sudo=1.8.27-1
    # apt-get install libltdl-dev =2.4.6-9 libtool=2.4.6-9 debhelper=12.1.1
    3.
    To build a package using armhf toolchain
    # export CC="arm-linux-gnueabihf-gcc"
    # export CROSS_COMPILE="arm-linux-gnueabihf-"
    # export ARCH=arm
    # export TARGET_HOST="arm-linux-gnueabihf"

To launch the .sh script yourself you need to enable the ssh access on WDMyCloud then ssh sshd@<WDMyCloud's-IP-address> then ./start.sh /mnt/HD/HD_a2/Nas_Prog/syncthing

the log file and the whole installation is available at /mnt/HD/HD_a2/Nas_Prog/syncthing


the initial syncthing version is 1.27.6, the version updates automatically you cannot force the update through the syncthing web interface.



