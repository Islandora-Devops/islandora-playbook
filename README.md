# Islandora Playbook
[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](./LICENSE)

## Introduction

This is an Ansible playbook for provisioning an instance of Islandora. This repository can be used with Vagrant, or for deploying to a remote server.

As of tag 2.0.0, deployment is done in two stages:
* with `islandora_build_base_box=true` ('ISLANDORA_BUILD_BASE=true' in Vagrant), to install environment components that change infrequently, and
* with `islandora_build_base_box=false` ('ISLANDORA_BUILD_BASE=false' [default] in Vagrant), to install and configure the Islandora software.

The base box can be stored, to save time on subsequent builds (e.g. for creating dev or testing environments).

For usage instructions, including Vagrant and remote server deployment, see [Islandora Playbook](https://islandora.github.io/documentation/installation/playbook) in the Islandora Documentation.

For an alternative installation using Docker, please see [ISLE](https://islandora.github.io/documentation/installation/docker-introduction/).


## Use

With Vagrant (each of these steps may take several minutes!):

```bash
ISLANDORA_BUILD_BASE=true vagrant up         # Create the base box on a bare Ubuntu.
vagrant package --output islandora_base      # Shut down the VM and save it as a file, islandora_base, which is created in this directory.
vagrant destroy                              # You will be prompted to enter 'y' to destroy this VM
vagrant up                                   # It will show it is importing the islandora_base base box, then will provision Islandora.
```

Detailed installation and usage instructions can be found on the [official installation documentation for Islandora](https://islandora.github.io/documentation/installation/playbook/).


## Variables

These Vagrant variables (in all caps) are read from the environment, so if you set them as Unix shell variables they will override the defaults defined in the Vagrantfile.

### Build Base box

If `ISLANDORA_BUILD_BASE` is `true`, then the playbook will download a standard Vagrant base box of the `ISLANDORA_DISTRO` and partly provision it, creating a virtual machine that can be saved as an islandora base box.

If `ISLANDORA_BUILD_BASE` is `false` (default), then the playbook will use an existing islandora base box and provision the islandora software.

This corresponds to the `islandora_build_base_box` Ansible variable.

### Islandora Distro

`ISLANDORA_DISTRO` defaults to `ubuntu/focal64` (20.04 LTS), which is currently the only working distribution. 

This corresponds to the `islandora_distro` Ansible variable.

### Install Profile

`ISLANDORA_INSTALL_PROFILE` can be one of:

* `starter`: Installs using [the `islandora/islandora-starter-site` project](https://github.com/Islandora/islandora-starter-site/) as a template, intended for spinning up sites for general usage.
* `starter_dev`: Similar to `starter`, installs based on [the `islandora/islandora-starter-site` project](https://github.com/Islandora/islandora-starter-site/); however, performs a clone of the repository with its history, intended specifically for development of the starter site.
* `demo`: Installs the demo based on the [install profile](https://github.com/Islandora-Devops/islandora_install_profile_demo) developed by Born Digital. This has a custom theme and more out-of-the-box customizations.

This corresponds to the `islandora_profile` Ansible variable.

### System Resources

By default the virtual machine that is built uses 4GB of RAM. Your host machine will need to be able to support the additional memory use. You can override the CPU and RAM allocation by creating `ISLANDORA_VAGRANT_CPUS` and `ISLANDORA_VAGRANT_MEMORY` environment variables and setting the values. For example, on an Ubuntu host you could add to `~/.bashrc`:

```bash
export ISLANDORA_VAGRANT_CPUS=4
export ISLANDORA_VAGRANT_MEMORY=5040
```

## Connect (Vagrant)

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


## Running Vagrant on Macs

### Virtualbox not available for M1, M2 Macs

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


## Roadmap

The playbook is in maintenance mode as new development is focused on [ISLE](https://islandora.github.io/documentation/installation/docker-compose/) for development and production.

## Maintainers

* [Alexander O'Neill](https://github.com/alxp)
