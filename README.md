# Islandora Playbook
[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](./LICENSE)

## Introduction

This is an Ansible playbook for provisioning an instance of Islandora. This repository includes a Vagrantfile, so `vagrant up` will create a local virtual machine and run the playbook on it.

This can also be used as an ansible playbook (playbook.yml) to provision a remote server. If doing so, be sure to change the passwords in `inventory/vagrant/group_vars/all/passwords.yml` (or override them with your own inventory), as well as ensure all ports except the Drupal port are behind a firewall.

For an alternative installation using Docker, please see [ISLE](https://islandora.github.io/documentation/installation/docker-introduction/).

## Running Vagrant on Macs

### No Virtualbox available for M1, M2 Macs

The new architecture of the Apple silicon chips (M1, M2) is incompatible with VirtualBox,
so the newest Macs cannot be used with the Vagrant method. However, they can still deploy
the playbook to remote VMs, or use Docker (ISLE).

### macOS 12.0 Monterey VirtualBox Workaround

VirtualBox has not been updated to work fully with macOS Monterey as of October, 2021.
A workaround exists, which is to run VirtualBox in non-headless mode.

In your Vagrantfile, add the line `v.gui = true` to the configuration section near the top:

```
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |v|
    v.name = "Islandora 8 Ansible"
    v.gui = true
  end
```

Discussion of this issue can be found on [this issue](https://github.com/hashicorp/vagrant/issues/12557
) in Vagrant's GitHub project.

## Variables

### Base box

By default the Vagrantfile builds Islandora on a `ubuntu/focal64` (20.04 LTS) base box.


### Install Profile

The Unix shell variable `ISLANDORA_INSTALL_PROFILE` can be one of:

* `standard`: Installs a [`drupal/recommended-project`](https://github.com/drupal/recommended-project) base install and enables the [Islandora](https://github.com/Islandora/islandora) and [Islandora Defaults](https://github.com/Islandora/islandora_defaults) modules without any special configuration.
* `demo`: Installs the demo based on the [install profile](https://github.com/Islandora-Devops/islandora_install_profile_demo) developed by Born Digital. This has a custom theme and more out-of-the-box customizations.
* `starter`: Installs using [the `islandora/islandora-starter-site` project](https://github.com/Islandora/islandora-starter-site/) as a template, intended for spinning up sites for general usage.
* `starter_dev`: Similar to `starter`, installs based on [the `islandora/islandora-starter-site` project](https://github.com/Islandora/islandora-starter-site/); however, performs a clone of the repository with its history, intended specifically for development of the starter site.

This corresponds to the `islandora_profile` Ansible variable.

### System Resources

By default the virtual machine that is built uses 4GB of RAM. Your host machine will need to be able to support the additional memory use. You can override the CPU and RAM allocation by creating `ISLANDORA_VAGRANT_CPUS` and `ISLANDORA_VAGRANT_MEMORY` environment variables and setting the values. For example, on an Ubuntu host you could add to `~/.bashrc`:

```bash
export ISLANDORA_VAGRANT_CPUS=4
export ISLANDORA_VAGRANT_MEMORY=5040
```

## Use

Detailed installation and usage instructions can be found on the [official installation documentation for Islandora](https://islandora.github.io/documentation/installation/playbook/).

## Connect

You can connect to the machine via the browser at [http://localhost:8000](http://localhost:8000).

### Drupal

The default Drupal login details are:

  * username: admin
  * password: islandora

### MySQL

  * username: drupal8
  * password: islandora

### Fedora 6

The Fedora 6 REST API can be accessed at [http://localhost:8080/fcrepo/rest](http://localhost:8080/fcrepo/rest).

Authentication is done via [Syn](https://github.com/Islandora/Syn) using [JWT](https://jwt.io) tokens.

### Solr

You can access the Solr administration UI at http://localhost:8983/solr/

### SSH

You can connect to the machine via ssh:

  * `vagrant ssh`

### ActiveMQ

You can access the ActiveMQ administrative interface at: http://localhost:8161/admin

  * username: admin
  * password: admin


### Cantaloupe

You can access the Cantaloupe admin interface at: http://localhost:8080/cantaloupe/admin

  * username: admin
  * password: islandora

You can access the IIIF endpoint at: http://localhost:8080/cantaloupe/iiif/2/

### JWT

Islandora uses JWT for authentication across the stack. Crayfish microservices, Fedora, and Drupal all use them.
Crayfish and Fedora have been set up to use a default token of `islandora` to make testing easier. To use it, just set
the following header in HTTP requests:

  * `Authorization: Bearer islandora`

### BlazeGraph (Bigdata)

You can access the BlazeGraph interface at: http://localhost:8080/bigdata/

You have to select the 'islandora' namespace in the [namespaces tab](http://localhost:8080/bigdata/#namespaces) before you can execute queries.

### FITS

You can access the FITS Web Service at http://localhost:8080/fits/

### Matomo

The Playbook installs an instance of the [Matomo](https://matomo.org/) web analytics platform. You can access your instance at: http://localhost:8000/matomo

  * username: admin
  * password: islandora

## Roadmap

The playbook is in maintenance mode as new development is focused on [ISLE](https://islandora.github.io/documentation/installation/docker-compose/) for development and production.

## Maintainers

* [Alexander O'Neill](https://github.com/alxp)
