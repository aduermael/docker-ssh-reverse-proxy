#!/bin/ash

# generate keys
mkdir ~/.ssh
ssh-keygen -f ~/.ssh/id_rsa -t rsa -N '' > /dev/null

key=$(cat ~/.ssh/id_rsa.pub | base64 | tr -d '\n')

echo "public ip/domain:"
read publicAddr

echo "public port:"
read publicPort

echo "public container ssh port:"
read sshPort

echo "forward to private ip/domain:"
read privateAddr

echo "on port:"
read privatePort

read -rsp $'Run aduermael/ssh-reverse-proxy-public container on '$publicAddr$' and use that key when prompted:\n\n'$key$'\n\n\nWhen done, press any key to continue...\n' -n1 key

ssh -f -nNT -R $publicPort:$privateAddr:$privatePort  root@$publicAddr -p $sshPort

echo "Tunnel is ready! You can now detach from that container (Ctrl+p, Ctrl+q)."

ash
