# Islandora Playbook
[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](./LICENSE)

## Introduction

This is an Ansible playbook for provisioning an instance of Islandora. This repository includes a Vagrantfile, so `vagrant up` will create a local virtual machine and run the playbook on it. For an alternative installation using Docker, please see [ISLE](https://islandora.github.io/documentation/installation/docker-compose/).

This virtual machine **should not** be used in production **yet**, however the Ansible inventory can be used as the basis for a server deployment with everything besides the Drupal port behind a firewall.

## Variables

### Base box

By default the Vagrantfile builds Islandora on a `ubuntu/focal64` base box.   

The [Islandora 8 base box](https://app.vagrantup.com/islandora/boxes/8) is now deprecated.

### Install Profile

The Unix shell variable 'ISLANDORA_INSTALL_PROFILE' can be one of:

standard - Installs a drupal/recommended-project base install and enables the Islandora and Islandora Defaults modules without any special configuration.

demo - Installs the demo based on the install profile developed by Born Digital. This has a custom theme and more out-of-the-box customizations.

This corresponds to the 'islandoar_profile' Ansible variable.

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

### Fedora5

The Fedora 6 REST API can be accessed at [http://localhost:8080/fcrepo/rest](http://localhost:8080/fcrepo/rest). 

Authentication is done via [Syn](https://github.com/Islandora-CLAW/Syn) using [JWT](https://jwt.io) tokens.

### Solr

You can access the Solr administration UI at http://localhost:8983/solr/

### SSH

You can connect to the machine via ssh:

  * `vagrant ssh`
  
### ActiveMQ

The default ActiveMQ login details are:
  
  * username: admin
  * password: admin

You can access the ActiveMQ administrative interface at: http://localhost:8161/admin

### Cantaloupe

You can access the Cantaloupe admin interface at: http://localhost:8080/cantaloupe/admin

  * username: admin
  * password: islandora
  
You can access the IIIF interface at: http://localhost:8080/cantaloupe/iiif/2/

### JWT

Islandora uses JWT for authentication across the stack. Crayfish microservices, Fedora, and Drupal all use them.
Crayfish and Fedora have been set up to use a default token of `islandora` to make testing easier. To use it, just set
the following header in HTTP requests:

  * `Authorization: Bearer islandora`
  
### BlazeGraph (Bigdata)

You can access the BlazeGraph interface at: http://localhost:8080/bigdata/

You have to select the islandora namespace in the [namespaces tab](http://localhost:8080/bigdata/#namespaces) before you can execute queries.

### FITS

You can access the FITS Web Service at http://localhost:8080/fits/  

### Matomo

CLAW Playbook installs an instance of the [Matomo](https://matomo.org/) (formally PIWIK) web analytics platform. You can access your instance at: http://localhost:8000/matomo

  * username: admin
  * password: islandora
 
## Roadmap

The playbook is in maintenance mode as new development is focused on [ISLE](https://islandora.github.io/documentation/installation/docker-compose/) for development and production.
 
## Maintainers

* [Jonathan Green](https://github.com/jonathangreen)
