# Rocket-cam

This project is the home of the configuration and basic server to install on a 
raspberry pi zero W equiped with the camera hardware.

This software was tested with 2018-04-18-raspbian-stretch-lite.

## Installation:

- You'll need to flash the SD card with raspbian strech lite.
- Run the script ./install/configure_boot.sh from the boot directory.
  - Usage: `bash [PATH TO INSTALL]/install/configure_boot.sh`
  - This will configure the pi zero W to work with OTG modes [see this](https://gist.github.com/gbaman/975e2db164b3ca2b51ae11e45e8fd40a) for more details.
  - This will also enable SSH
- Put the SD card inside the pi
- Power the pi via usb cable from your computer and wait ~60-90 secondes for the pi to boot
- Make sure your computer connect to the wired conenction.
  - You might have to configure your IPV4 configuration to "Shared with other computer"
- run `arp` or `arp -n` to find the pi hostname/ip
- run `ssh pi@[$HOSTNAME].local` or `ssh pi@[IP]` the password should be `raspberry`
- Now you should be connected to a bash shell on the pi. Run `sudo bash ./install/configure_pi.sh [password] [slave or master] [hostname] [SSID]`
- Reboot the pi
- You are done ! 

## Accessing the pi

Once installed, power up the raspberry pi and wait ~30-60 secondes.
You should see in your wifi a new connection with the name you chose while installing

Connect to that wifi and you should be able to access to `http://[hostname].local`.