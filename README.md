# Rocket-cam

This project is the home of the configuration and basic server to install on a 
raspberry pi zero W equiped with the camera hardware.

This software was tested with 2018-04-18-raspbian-stretch-lite.

## Installation:

- You'll need to flash the SD card with raspbian strech lite.
- Run the script ./install/configure_boot.sh from the boot directory of the SD card.
  - This will configure the pi zero W to work with OTG modes [see this](https://gist.github.com/gbaman/975e2db164b3ca2b51ae11e45e8fd40a) for more details.
  - This will also enable SSH
- Put the SD card inside
- Power the pi via usb cable from your computer and wait ~60-90 secondes for the pi to boot
- Make sure your computer connect to the wired conenction.
  - You might have to configure your IPV4 configuration to "Shared with other computer"
- run `arp` or `arp -n` to find the pi hostname
- ssh pi@[$HOSTNAME].local password should be raspberry
- run `scp ./install/configure_pi.sh pi@[$HOSTNAME]:~/`
- @TODO finish this list
