#!/usr/bin/env bash

set -eux

# Create directories to host Ansible files
mkdir -p $ANSIBLE_STAGING_DIRECTORY/{group_vars,templates,vars}
chown -R $ANSIBLE_STAGING_DIRECTORY_USER:$ANSIBLE_STAGING_DIRECTORY_GROUP $ANSIBLE_STAGING_DIRECTORY
chmod -R $ANSIBLE_STAGING_DIRECTORY_PERMISSIONS $ANSIBLE_STAGING_DIRECTORY

# Install Ansible repository.
apt -y install software-properties-common
apt-add-repository ppa:ansible/ansible

# Install Ansible.
apt -y update
apt -y install ansible

