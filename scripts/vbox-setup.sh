#!/usr/bin/env bash

set -eux

# Install necessary libraries for Virtualbox Guest Additions, Vagrant NFS, Vagrant Share etc.
apt -y install \
  linux-headers-$(uname -r) \
  virtualbox-guest-additions-iso

# Mount VirtualBox Guest Additions ISO file
GUEST_ADDITIONS_ISO=`find /home/vagrant -iname "*VBoxGuestAdditions*.iso" | head -1`

if [ ! -z "$GUEST_ADDITIONS_ISO" -a "$GUEST_ADDITIONS_ISO" != " " ]
then
  # Mount ISO file and run installer
  mkdir /tmp/vbox
  mount -t iso9660 -o loop -r $GUEST_ADDITIONS_ISO /tmp/vbox
  sh /tmp/vbox/VBoxLinuxAdditions.run

  # Unmount ISO file and delete file
  umount /tmp/vbox
  rm -rf /tmp/vbox
  rm $GUEST_ADDITIONS_ISO
fi

# Disable daily apt unattended updates
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic

