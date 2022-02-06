#!/bin/bash
#
# Run as root for initial setup, all other configuration done with Ansible afterwards
set -euo pipefail

readonly SSH_PUBLIC_KEY=''

apt update --allow-releaseinfo-change \
  && apt upgrade -y \
  && apt autoremove -y --purge \
  && apt install -y acl python3 python3-apt python3-pip sudo

/usr/sbin/adduser --home /var/ansible --system --shell /bin/bash ansible
/usr/sbin/adduser ansible sudo
echo 'ansible ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ansible
chmod 0440 /etc/sudoers.d/ansible

mkdir /var/ansible/.ssh
echo "${SSH_PUBLIC_KEY}" > /var/ansible/.ssh/authorized_keys
chown -R ansible:nogroup /var/ansible/.ssh
chmod 0600 /var/ansible/.ssh/authorized_keys
