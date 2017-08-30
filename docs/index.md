# Index

  * About - About this project
  * Installation - Installing Islandora CLAW using Ansible
  * Software - Islandora CLAW dependencies and their versions
  * Vagrant - virtual machine information
  * Usage - Using CLAW
  * Contributing - How to contribute
  * Documentation - How to build this documentation in mkdocs

___

## About CLAW Vagrant Islandora 7.x-2.x

[Islandora](http://islandora.ca) is an open-source software framework designed to help institutions and organizations and their audiences collaboratively manage, and discover digital assets using a best-practices framework.  Islandora was originally developed by the University of Prince Edward Island's Robertson Library, but is now implemented and contributed to by an ever-growing international community.

Islandora CLAW consists of:

  * [Sync](camel/sync/README.md) - Event driven middleware based on Apache Camel that synchronizes a Fedora 4 JCR with a Drupal CMS.
  * [Islandora](drupal/islandora/README.md) - Fedora 4 Repository module
  * [Install](install/README.md) - The is a development environment virtual machine for the Islandora CLAW project. It should work on any operating system that supports Ansible, Git, VirtualBox and Vagrant.

---

## Installation 

The [installation section](install/README.md) provides and overview on how to create a virtual development environment.

## Using Ansible 

* List of commands here

## Ansible Playbook structure

````
├── LICENSE
├── README.md
├── Vagrantfile
├── ansible.cfg
├── bootstrap.yml
├── database.yml
├── docs
│   └── index.md
├── inventory
│   └── vagrant
│       ├── group_vars
│       └── hosts
├── karaf.yml
├── playbook.yml
├── requirements.yml
├── roles
│   ├── external
│   │   ├── apache
│   │   ├── composer
│   │   ├── drupal
│   │   ├── drupal-console
│   │   ├── drush
│   │   ├── geerlingguy.php
│   │   ├── git
│   │   ├── java
│   │   ├── mysql
│   │   ├── php
│   │   ├── postgresql
│   │   └── solr
│   └── internal
│       ├── blazegraph
│       ├── cantaloupe
│       ├── fcrepo
│       ├── fcrepo-syn
│       ├── fits
│       ├── grok
│       ├── karaf
│       ├── openseadragon
│       ├── tomcat8
│       └── webserver-app
├── solr.yml
├── tomcat.yml
└── webserver.yml
````

* playbook.yml
* requirements.yml
* solr.yml
* tomcat.yml
* webserver.yml


* Ansible Galaxy Explained

## Software

* Ubuntu 16.04 LTS
* MySQL 

## Vagrant

* Currently uses the Vagrant box ubuntu/xenial 

## Usage

The [usage section](install/README.md) provides and overview on how to run and connect to the virtual development environment.

## Contributing

If you would like to contribute, please get involved with the [Islandora DevOps Group](https://github.com/Islandora-Devops/claw-playbook), and check out the [contributing section](contributing/contributing.md). We love to hear from you!

If you would like to contribute code to the project, you will need to be covered by an Islandora Foundation [Contributor License Agreement](http://islandora.ca/sites/default/files/islandora_cla.pdf) or [Corporate Contributor Licencse Agreement](http://islandora.ca/sites/default/files/islandora_ccla.pdf). Please see the [Contributors](http://islandora.ca/resources/contributors) page on Islandora.ca for more information.

## Documentation
The [How to build documentation](technical-documentation/docs-build.md) provides and overview on how the documentation is created, built, and deployed.

## Sponsors

## Maintainers

* [Daniel Lamb](https://github.com/daniel-dgi/)

## Licensing

Islandora is licensed under the GNU General Public License, Version 3. See [LICENSE](https://github.com/Islandora-Labs/islandora/blob/7.x-2.x/LICENSE) for the full license text.