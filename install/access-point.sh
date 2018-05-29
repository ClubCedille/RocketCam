#!/bin/bash

touch /etc/udev/rules.d/70-persistent-net.rules

MAC=$(cat /sys/class/net/wlan0/address)

tee -a /etc/udev/rules.d/70-persistent-net.rules << END
SUBSYSTEM=="ieee80211", ACTION=="add|change", ATTR{macaddress}=="$MAC", KERNEL=="phy0", 
  RUN+="/sbin/iw phy phy0 interface add ap0 type __ap", 
  RUN+="/bin/ip link set ap0 address $MAC
END

apt-get install -y dnsmasq hostapd

tee -a /etc/dnsmasq.conf << END
interface=lo,ap0
no-dhcp-interface=lo,wlan0
bind-interfaces
server=8.8.8.8
domain-needed
bogus-priv
dhcp-range=192.168.10.50,192.168.10.150,12h
END

tee -a /etc/hostapd/hostapd.conf << END
ctrl_interface=/var/run/hostapd
ctrl_interface_group=0
interface=ap0
driver=nl80211
ssid=RocketCam
hw_mode=g
channel=11
wmm_enabled=0
macaddr_acl=0
auth_algs=1
wpa=2
wpa_passphrase=rocketcam
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP CCMP
rsn_pairwise=CCMP
END

echo 'DAEMON_CONF="/etc/hostapd/hostapd.conf"' > /etc/default/hostapd

tee -a /etc/dnsmasq.conf << END

auto lo
auto ap0
auto wlan0
iface lo inet loopback

allow-hotplug ap0
iface ap0 inet static
    address 192.168.10.1
    netmask 255.255.255.0
    hostapd /etc/hostapd/hostapd.conf
END