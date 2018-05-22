#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
folder="/root/koolproxy"
if [ ! -d "$folder" ]; then
  mkdir $folder
  mkdir $folder/data
  mkdir $folder/data/rules
  cd $folder
  wget -O koolproxy https://koolproxy.com/downloads/x86_64
  chmod +x koolproxy
fi
pkill -9 koolproxy
cd $folder/data/rules
rm koolproxy.txt  kp.dat daily.txt
wget https://kprule.com/koolproxy.txt
wget https://kprule.com/kp.dat
wget https://kprule.com/daily.txt
if [ ! -f "user.txt" ]; then 
  wget https://kprule.com/user.txt
fi
echo "1" > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3000
cd $folder
./koolproxy >  $folder/data/koolproxy.log 2>&1 &