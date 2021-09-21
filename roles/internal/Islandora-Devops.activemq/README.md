# Ansible Role: ActiveMQ

An Ansible role that installs [ActiveMQ](http://activemq.apache.org/) on:

* Centos/RHEL 7.x
* Ubuntu Xenial

## Role Variables

Available variables are listed below, along with default values:

What version to install:
```
activemq_version: 5.14.5
```

Where to install to:
```
activemq_install_root: /opt
```

User\group to install as:
```
activemq_user: ubuntu
```

Whether to create user if not present:
```
activemq_create_user: yes
```

## Dependencies

* None
  
## Example Playbook

    - hosts: webservers
      roles:
        - { role: Islandora-Devops.activemq }

## License

MIT
