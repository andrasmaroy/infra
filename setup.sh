#!/bin/bash
#
# Run as root for initial setup, all other configuration done with Ansible afterwards
set -euo pipefail

readonly SSH_PUBLIC_KEY=''

apt update && apt install -y sudo python3 python3-apt python3-pip

/usr/sbin/adduser --system --shell /bin/bash ansible
/usr/sbin/adduser ansible sudo
echo 'ansible ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ansible
chmod 0440 /etc/sudoers.d/ansible

mkdir /home/ansible/.ssh
echo "${SSH_PUBLIC_KEY}" > /home/ansible/.ssh/authorized_keys
chown -R ansible:nogroup /home/ansible/.ssh
chmod 0600 /home/ansible/.ssh/authorized_keys
