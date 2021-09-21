# Ansible Role: Grok [![Build Status](https://travis-ci.org/Islandora-Devops/ansible-role-grok.svg?branch=main)](https://travis-ci.org/Islandora-Devops/ansible-role-grok)

An Ansible role that installs [Grok](https://github.com/GrokImageCompression/grok) on:

* Centos/RHEL 7.x
* Ubuntu Xenial

## Role Variables

Available variables are listed below, along with default values:

Where to clone it to:
```
grok_clone_directory: /opt/grok
```

Version to install:
```
grok_version_tag: v2.3.0
```

## Dependencies

* Playbook requires the following applciations to be installed: 
  - git
  - build-essential (gcc, g++, make)
  
## Example Playbook

    - hosts: webservers
      roles:
        - islandora.grok

## License

MIT
