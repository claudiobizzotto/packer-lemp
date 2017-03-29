Ubuntu 16.04 Virtualbox with Packer and Ansible
===============================================

A simple Packer blueprint that builds an Ubuntu 16.04 Virtualbox image and provisions it with Ansible.

# Requirements

Make sure the following software is installed on your local machine before you proceed with the instructions below:

* [Packer](http://www.packer.io/)
* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant](http://vagrantup.com/)

Because [Ansible](http://docs.ansible.com/intro_installation.html) is only used to provision the Virtualbox image during the build process, it doesn't need to be installed on your local machine.

# Usage

Change directory into the folder containing this `README.md` file and run the following command line:

```SHELL
$ packer build vbox.json
```

# Testing the machine image

The `Vagrantfile` included in this repository allows quick testing of the Virtualbox image built above. From the same directory, spin up a new Vagrant instance with the following command line:

```SSH
$ vagrant up
```

# Tweaking the example

The `variables` section in the Packer configuration file (`vbox.json`) can be tweaked according to your needs. For example, you can change the `mirror` value to a URL that's geographically closer to you.

You may also want to change some values in the preseed file (`http/preseed.cfg`), such as language and timezone, as well as in the `Vagrantfile`.

# Extending the example

Other software can be installed on top of what's being provided by default, which is the bare minimum. The best way of doing that is using Ansible as a *hook*: once Ansible gets installed in the machine image, an Ansible playbook is called (`ansible/playbook.yml`), at which point you can do whatever you want.

So, instead of installing extra software through Packer's [shell provisioner](https://www.packer.io/docs/provisioners/shell.html), you do that through Ansible - the [advantages](https://www.ansible.com/it-automation) are compelling.

You can even use Ansible roles and groups for that. Check the `ansible-local` provisioner [documentation](https://www.packer.io/docs/provisioners/ansible-local.html) for more details.

# Troubleshooting

1. "Something is breaking my build. Can I get a detailed sequence of what's going on?"

Yes. All you have to do is set the `PACKER_LOG` environment variable to `1`:

```SHELL
$ PACKER_LOG=1 packer build vbox.json
```

2. "I see the shell commands and Ansible tasks being successfully executed inside the image, yet, as soon as I log into the Vagrant machine, I can't see the changes there. How come?"

Vagrant likes caching. To clear the cache, destroy the Vagrant box (`vagrant destroy`), delete the local Vagrant directory (`rm -rf .vagrant`) and start afresh (`vagrant up`) - you don't even need to *re-pack* the Virtualbox image.

