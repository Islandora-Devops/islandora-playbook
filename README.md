# CLAW Vagrant Playbook
[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](./LICENSE)

## Introduction

The is an Ansible playbook for Islandora CLAW. It also has a vagrant file to bring up a development
environment virtual machine for Islandora CLAW.

This virtual machine **should not** be used in production **yet**.

## Requirements

1. [VirtualBox](https://www.virtualbox.org/)
2. [Vagrant](http://www.vagrantup.com/) 1.8.5+
3. [git](https://git-scm.com/)
4. [ansible](https://www.ansible.com/community) 2.3+
5. [virtualbox-vbguest](https://github.com/dotless-de/vagrant-vbguest) plugin (If targeting CENTOS)

## Variables

### System Resources

By default the virtual machine that is built uses 3GB of RAM. Your host machine will need to be able to support the additional memory use. You can override the CPU and RAM allocation by creating `ISLANDORA_VAGRANT_CPUS` and `ISLANDORA_VAGRANT_MEMORY` environment variables and setting the values. For example, on an Ubuntu host you could add to `~/.bashrc`:

```bash
export ISLANDORA_VAGRANT_CPUS=4
export ISLANDORA_VAGRANT_MEMORY=4096
```

### Using CENTOS

_CENTOS support is WIP and not to be considered stable_

Ubuntu 16.04 is the default linux distribution used by claw-playbook.  If you want to use CENTOS 7 instead, set the `ISLANDORA_DISTRO` environment variable to `centos/7`.  The easiest way to do this is to export the environment variable into your shell before running Vagrant commands. Otherwise you will have to provide the variable for every Vagrant command you issue.

```bash
ISLANDORA_DISTRO="centos/7" vagrant up
ISLANDORA_DISTRO="centos/7" vagrant ssh
```

If you are not using `vagrant up` to bring up a box, and are running `ansible-playbook` against it manually, you will need to set `ansible_ssh_user` to `vagrant` for your hosts.  It's easiest to add this value to `inventory/vagrant/group_vars/all.yml` to set the value for all hosts.  This is not neccessary if using Vagrant, as the ssh user is passed to ansible via the Vagrantfile.

## Use

### Vagrant

If you're looking for a development environment, using our Vagrant deployment is easiest:

1. Clone the repo
2. `vagrant up`

### All-in-one provisioning with Ansible

If you want to provision an all-in-one remote Ubuntu environment, like a production server:

1. SSH into your remote server and add an [user with password-less sudo privileges](https://www.digitalocean.com/community/tutorials/how-to-create-a-sudo-user-on-ubuntu-quickstart), and make sure you can log in as that user. Its easiest if you use SSH keys for login, so that you an log in to the server without a password. Another option if you are no comfortable with password-less sudo is to set the `ansible_become_pass` variable in your inventory as outlined [here](http://docs.ansible.com/ansible/latest/become.html).
1. Clone the repository onto your local machine.
1. Create an inventory for your new environment ('production' in this example): `cp -r inventory/vagrant inventory/production`.
1. Edit `inventory/production/hosts` to point to your new environment by changing 'default' line to:
```
default ansible_ssh_host=my_ip_or_domain_name
```
Optionally if you need to specify a username, password or port to connect to the server you can specify those in the inventory file as well:
```
default ansible_ssh_host=my_ip_or_domain_name ansible_ssh_user=my_user ansible_ssh_pass=my_super_secret_password ansible_ssh_port=my_port
```
More information about inventories can be found in the [ansible documentation](http://docs.ansible.com/ansible/latest/intro_inventory.html).
1. Update the inventory variables as you see fit to customize your Islandora installation. 
  1. You should modify `group_vars\all\passwords.yml` to use more secure passwords. These passwords can be encrypted using [Ansible Vault](https://docs.ansible.com/ansible/latest/vault.html) if you wish to keep your inventory secure.
  1. Change the `drupal_trusted_host` configuration in `inventory/production/group_vars/webserver/drupal.yml` to reflect your IP or domain name
  1. Change the Apache's port to 80 in `inventory/production/group_vars/webserver/apache.yml`
  1. Any other variable changes you wish.
1. Install the roles using `ansible-galaxy`: `$ ansible-galaxy install -r requirements.yml`
1. Provision the server with `$ ansible-playbook -i inventory/production`
  - If the host you are provisioning is a Ubuntu 16.04 machine, you may wish to have the playbook install Python for you. This is a requirement to run the playbook. You can do this by passing an additional variable on the command line like this. `$ ansible-playbook -i inventory/production -e "islandora_distro=ubuntu/xenial64"`

## Connect

You can connect to the machine via the browser at [http://localhost:8000](http://localhost:8000).

### Drupal

The default Drupal login details are:
  
  * username: admin
  * password: islandora

### MySQL
  
  * username: root
  * password: islandora

### Fedora4

The Fedora 4 REST API can be accessed at [http://localhost:8080/fcrepo/rest](http://localhost:8080/fcrepo/rest). 

Authentication is done via [Syn](https://github.com/Islandora-CLAW/Syn) using [JWT](https://jwt.io) tokens.

### Tomcat Manager
  
  * username: islandora
  * password: islandora

### SSH

You can connect to the machine via ssh:

  * `vagrant ssh`
  * `ssh -p 2222 ubuntu@localhost`

### VM

The default VM login details are:
  
  * username: ubuntu
  * password: ubuntu
 
## Roadmap

1. Get feature parity with [CLAW Vagrant](https://github.com/Islandora-CLAW/claw_vagrant)
2. Break each role out into its own git repo, so they can be listed on galaxy
3. Test install on multiple boxes
4. Test with other operating systems (?)
 
## Maintainers

* [Jonathan Green](https://github.com/jonathangreen)

