#!/bin/ash

# generate keys
ssh-keygen -f /etc/ssh/ssh_host_rsa_key -t rsa -N '' > /dev/null
ssh-keygen -f /etc/ssh/ssh_host_dsa_key -t dsa -N '' > /dev/null
ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -t ecdsa -N '' > /dev/null
ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -t ed25519 -N '' > /dev/null

base64PublicKey=$1
publicKey=$(echo $base64PublicKey | base64 -d)
echo $publicKey >> /etc/ssh/authorized_keys

/usr/sbin/sshd

echo "SSH server ready! You can detach from that container (Ctrl+p, Ctrl+q) and resume setup in the other one."

ash