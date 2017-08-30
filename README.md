# CLAW Vagrant Playbook
[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](./LICENSE)

## Introduction

This is the development environment virtual machine (vm) for running Islandora 7.x-2.x (a.k.a. [Islandora CLAW](https://github.com/Islandora-CLAW/CLAW)). 

_This virtual machine **should not** be used in production **yet**._

* It should work on any operating system that supports Ansible, Git, VirtualBox and Vagrant. 

* It uses a suite of [Ansible](https://www.ansible.com/how-ansible-works) playbooks called within the Vagrantfile's provisioners section to install [Islandora CLAW](https://github.com/Islandora-CLAW/CLAW), its dependencies, additional software, user roles and more.

* The information listed below is to serve as a quick getting started guide. 
  * For more detailed information please navigate to the Technical documentation [here](/docs/index.md)

---

## Requirements

1. [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 5.1+
2. [Vagrant](https://www.vagrantup.com/downloads.html) 1.95+
3. [git](https://git-scm.com/downloads) 2.1+
4. [ansible](http://docs.ansible.com/ansible/latest/intro_installation.html) 2.3+

## System Resources

By default the virtual machine (guest) that is built uses 3GB of RAM. The host machine **will need to be able to support** the additional memory use. 

One can override the CPU and RAM allocation by creating `ISLANDORA_VAGRANT_CPUS` and `ISLANDORA_VAGRANT_MEMORY` environment variables and setting the values within the Vagrantfile. 

**Example 1:** Within an Ubuntu host machine one could add these values to `~/.bashrc` to increase the CPU & Memory usage of the (guest).

```bash
export ISLANDORA_VAGRANT_CPUS=4
export ISLANDORA_VAGRANT_MEMORY=4096
```

**Example 2:** Within the Vagrant file, one could edit these values to increase the CPU & Memory usage prior to running `vagrant up` to launch the virtual environment (guest) with more resources allocated.

````
$cpus   = ENV.fetch("ISLANDORA_VAGRANT_CPUS", "4")
$memory = ENV.fetch("ISLANDORA_VAGRANT_MEMORY", "4096")
````

## System Ports
The following services and ports are mapped/exposed from the development environment virtual machine (guest) to the (host) laptop, workstation or server that runs Virtualbox.

Please note that in the event of conflict, the port values for the **host ONLY** should be changed within the Vagrantfile. These values can be arbitrary. This can often occur when running more than one Vagrant server at time. 

**Original Vagrant port settings**
* `guest: 8000, host: 8000` # **Apache**
* `guest: 8080, host: 1234` # **Tomcat**
* `guest: 8181, host: 8181` # **Karaf**
* `guest: 8282, host: 8282` # **Islandora Microservices**
* `guest: 3306, host: 3306` # **MySQL**
* `guest: 5432, host: 5432` # **PostgreSQL**
* `guest: 8983, host: 8983` # **Solr**

**Example Vagrant port settings change**

`guest: 8080, host: 8081` # **Tomcat**

## Installation

1. Open up a terminal and clone this repository to the host system

````
git clone https://github.com/Islandora-Devops/claw-playbook.git
````

2. Navigate to the newly cloned repository directory

````
cd ~/claw-playbook
````
3. Start up the development environment virtual machine. 

```
vagrant up
````
This process will automatically provision all software, users etc upon the first launch using the Ansible playbook called `playbook.yml` found at the bottom of the Vagrantfile. 

**Please note:** this process can take upwards to 1-2 hours depending on the speed of one's internet connection, speed of disk etc.

To reprovision the server (reinstall software)

````
vagrant reload --provision
````


---

## Connect

* One can connect to the guest vm via a webbrowser at [http://localhost:8000](http://localhost:8000).
* One can also connect to the guest vm via ssh using one of two accounts: (_Both have sudoer's permissions_)

  * `vagrant ssh`
  * `ssh -p 2222 ubuntu@localhost`

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

### VM

The default vm login details are:
  
  * username: ubuntu
  * password: ubuntu

### **Key terms**
  * **vm** = virtual machine running Ubuntu 16.04 LTS
  * **guest** = the virtual machine running Islandora and services
  * **host** = system running Virtualbox and its virtual machines a.k.a guests). Typically a laptop, workstation etc.

## Roadmap

1. Get feature parity with [CLAW Vagrant](https://github.com/Islandora-CLAW/claw_vagrant)
2. Break each role out into its own git repo, so they can be listed on galaxy
3. Test install on multiple boxes
4. Test with other operating systems (?)
5. Document
 
## Maintainers

* [Danny Lamb](https://github.com/dannylamb)
* [Jonathan Green](https://github.com/jonathangreen)
