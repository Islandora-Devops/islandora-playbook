# Islandora Playbook
[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](./LICENSE)

## Introduction

This is an Ansible playbook for Islandora 8. It also has a vagrant file to bring up a release or development virtual machine for Islandora 8. For an alternative installation using Docker, please see [ISLE](https://islandora.github.io/documentation/installation/docker-compose/).

This virtual machine **should not** be used in production **yet**.

## Variables

### Base box

By default, Vagrant creates a complete Islandora 8 1.1.0 instance. This version is the current official release of Islandora.

If you want to build a VM that pulls in the latest Islandora code (suitable for a development environment, for example), before running `vagrant up`, open `Vagrantfile` and change the `$vagrantBox` variable to 'ubuntu/focal64':

```
# Available boxes are 'islandora/8' and 'ubuntu/focal64'
# Use 'ubuntu/focal64' to build a dev environment from scratch.
# Use 'islandora/8' if you just want to download a ready to run VM.
$vagrantBox = ENV.fetch("ISLANDORA_DISTRO", "islandora/8")
```
$$$ Drupal Profile

YOu can also choose to install a specific Islandora Drupal install profile with the following variables:

| Shell variable            | Vagrant variable | Ansible variable          | Description                                                                                      |
|---------------------------|------------------|---------------------------|--------------------------------------------------------------------------------------------------|
| ISLANDORA_PROFILE_PROJECT | $drupalProject   | islandora_profile_project | Composer project name + version of the Drupal profile to download.                               |
|                           |                  |                           | Example: "islandora/drupal_profile:1.x-dev", "islandora/islandora_install_profile_demo:dev-main" |
|                           |                  |                           |                                                                                                  |
| ISLANDOA_PROFILE          | $drupalProfile   | islandora_profile.        | Machine name of Drupal profile to install. Usually just the second part composer project name.   |
|                           |                  |                           | Example: "islandora_profile", "islandora_install_profile_demo"                                   |
<dl>
<dt>islandora_profile</dt>
<dd>The standard Islandora profile with core defaults enabled, running on Drupal 9</dd>

<dt>islandora_install_profile_demo</dt>
<dd>An experimental distribution with additional features enabled by default and a Bootstrap-based theme. Runs on Drupal 8.9.</dd>
</dl>

### System Resources

By default the virtual machine that is built uses 4GB of RAM. Your host machine will need to be able to support the additional memory use. You can override the CPU and RAM allocation by creating `ISLANDORA_VAGRANT_CPUS` and `ISLANDORA_VAGRANT_MEMORY` environment variables and setting the values. For example, on an Ubuntu host you could add to `~/.bashrc`:

```bash
export ISLANDORA_VAGRANT_CPUS=4
export ISLANDORA_VAGRANT_MEMORY=5040
```

## Use

Detailed installation and usage instructions can be found on the [official installation documentation for Islandora 8](https://islandora.github.io/documentation/installation/playbook/).

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

The Fedora 5 REST API can be accessed at [http://localhost:8080/fcrepo/rest](http://localhost:8080/fcrepo/rest).

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

Islandora 8 uses JWT for authentication across the stack. Crayfish microservices, Fedora, and Drupal all use them.
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
