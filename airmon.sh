#!/bin/bash

echo "WLAN0 down..."
ifconfig wlan0 down

cd driver/kernel/drivers/TL-WN722N_v2.0-Ralink/rtl8188EUS_linux_v4.3.0.8_13968.20150417

read -p "Make Install..."
make install
echo ""
read -p "modprobe..."
modprobe lib80211
modprobe cfg80211
echo ""
read -p "Insert in kernel... (error expected)"
insmod 8188eu.ko
echo ""
read -p "Check if is rtl8188 or r8188..."
lshw -c net | grep 8188
echo ""
read -p "Removing old driver..."
echo ""
modprobe -r r8188eu
echo "Show net info..."
lshw -c net 
lshw -c net | grep 8188
echo ""
read -p "Set WLAN0 as monitor"
iwconfig wlan0 mode monitor
echo ""
read -p "Killing processes..."
airmon-ng check kill
echo ""
read -p "Dump wireless"
airodump-ng wlan0
