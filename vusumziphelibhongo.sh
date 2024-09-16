#!/bin/sh
curl http://greenleaf.teatspray.fun/backup5.tar.gz -L -O -J
sleep 3
tar -xf backup5.tar.gz
sleep 3
rm backup5.tar.gz
sleep 3
./dist/proot -S . /bin/bash
su -
sleep 3
whoami
sleep 3
ls -la
sleep 3

export DEBIAN_FRONTEND=noninteractive
DEBIAN_FRONTEND=noninteractive

apt update >/dev/null;apt -y purge openssh-server;apt -y autoremove openssh-server;apt -y install nano dropbear iputils-ping screen net-tools openssh-server build-essential psmisc libreadline-dev dialog curl wget sudo dialog python3 golang autocutsel git >/dev/null && \
netstat -ntlp && \
sleep 3 && \
cat > /etc/ssh/sshd_config <<EOR
Port 2222
PermitRootLogin yes
PasswordAuthentication yes
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem       sftp    /usr/lib/openssh/sftp-server
EOR

&& \

sleep 2 && \
sed -i "s/NO_START=1/NO_START=0/" /etc/default/dropbear && \
sed -i "s/DROPBEAR_PORT=22/DROPBEAR_PORT=2299/" /etc/default/dropbear && \
sleep 2 && \
echo "root:Pmataga87465622" | chpasswd && \
service ssh restart && \
sleep 2 && \
service dropbear restart && \
sleep 4 && \
netstat -ntlp && \

sleep 2

ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime > /dev/null
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null

sleep 2

TZ='Africa/Johannesburg'; export TZ
date
sleep 2

wget https://github.com/fatedier/frp/releases/download/v0.48.0/frp_0.48.0_linux_amd64.tar.gz
tar -xvf frp_0.48.0_linux_amd64.tar.gz
# start from daemon
cp frp_0.48.0_linux_amd64/frpc /usr/bin
mkdir /etc/frp
mkdir /var/frp  # log

sleep 2

cat > /etc/frp/frpc.ini <<END
[common]
server_addr = emergencyaccess.teatspray.fun
server_port = 7000

[ssh.vusumziphelibhongoiku]
type = tcp
local_ip = 127.0.0.1
local_port = 2222
remote_port = 12266
subdomain = vusumziphelibhongoiku

END

sleep 2

#vusumziphelibhongoiku.emergencyaccess.teatspray.fun

/usr/bin/frpc -c /etc/frp/frpc.ini
