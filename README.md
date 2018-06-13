# Rocket-cam

The goal of this project is to transform a raspberry pi zero w into a camera system that is 
accessible remotely.

This software allow you to control many raspberry pi zero W from a single master PI.
Once you've sent a command to the master PI, the slaves will do the same.

The start and stop command will be duplicated on all the pi.
The picture command will only work for the master pi.

This project have been build for two student club in Montréal in order to record the flight of a rocket.
We needed to be able to control when to start the recording and to syncronize four camera.

## Installation:

- You will need to flash the SD card with raspbian strech lite.
- Run the script ./rocket-cam/configure_boot.sh from the boot directory.
  - Usage: `bash [PATH TO INSTALL]/rocket-cam/configure_boot.sh`
  - This will configure the pi zero W to work with OTG modes [see this](https://gist.github.com/gbaman/975e2db164b3ca2b51ae11e45e8fd40a) for more details.
  - This will also enable SSH
- Put the SD card inside the pi
- Power the pi via usb cable from your computer and wait ~60-90 secondes for the pi to boot
- Make sure your computer connect to the wired connection.
  - You might have to configure your IPV4 configuration to "Shared with other computer"
- run `ip n` or `arp -n` to find the pi ip
- run `ssh pi@[IP]` or `ssh pi@raspberrypi.local` the password should be `raspberry`
- Now you should be connected to a bash shell on the pi. Run `sudo bash ./rocket-cam/configure_pi.sh [password] [slave or master] [hostname] [SSID]`
- Reboot the pi
- You are done ! 

## Accessing the pi

Once installed, power up the raspberry pi and wait ~30-60 secondes.
You should see in your wifi a new connection with the SSID you chosed while installing it.

Connect to that wifi and you should be able to access `http://10.0.0.1`.


PS:
This software was tested with 2018-04-18-raspbian-stretch-lite.
