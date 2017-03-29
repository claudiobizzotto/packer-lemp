#!/usr/bin/env bash

set -eux

# Delete Ansible directory
rm -rf $ANSIBLE_STAGING_DIRECTORY

# Uninstall Ansible and remove PPA
rm -rf /home/vagrant/.ansible
apt -y remove --purge ansible
apt-add-repository -y --remove ppa:ansible/ansible

