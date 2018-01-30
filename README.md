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

1. SSH into your remote server and add an `ubuntu` [user with sudo privileges](https://www.digitalocean.com/community/tutorials/how-to-create-a-sudo-user-on-ubuntu-quickstart)
1. Clone the repository onto your local machine
1. Create an inventory for your new environment ('production' in this example): `cp -r inventory/vagrant inventory/production`
1. Edit `inventory/production/hosts` to point to your new environment by changing 'default' line to:
```
default ansible_ssh_host=my_ip_or_domain_name ansible_ssh_user=root ansible_ssh_pass=my_super_secret_password
```
1. Change all the passwords from "islandora" to something else.  You can get a full list of them by grepping your new inventory:
```bash
$ grep -rn pass inventory/production
inventory/production/group_vars/webserver/drupal.yml:21:drupal_db_password: islandora
inventory/production/group_vars/webserver/drupal.yml:29:drupal_account_pass: islandora
inventory/production/group_vars/database.yml:2:mysql_root_password: islandora
inventory/production/group_vars/database.yml:6:    password: islandora
inventory/production/group_vars/tomcat.yml:5:    password: islandora
inventory/production/group_vars/tomcat.yml:46:cantaloupe_admin_password: islandora
```
1. Change the `drupal_trusted_host` configuration in `inventory/production/group_vars/webserver/drupal.yml` to reflect your IP or domain name
1. Change the Apache's port to 80 in `inventory/production/group_vars/webserver/apache.yml`
1. Install the roles using `ansible-galaxy`: `$ ansible-galaxy install -r requirements.yml`
1. Provision the server with `$ ansible-playbook -i inventory/production -e "islandora_distro=ubuntu/xenial64"`

## Connect

You can connect to the machine via the browser at [http://localhost:8000](http://localhost:8000).

### Drupal

The default Drupal login details are:
  
  * username: admin
  * password: islandora

### MySQL
  
  * username: drupal8
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
