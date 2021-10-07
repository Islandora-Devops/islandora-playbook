# Ansible Role: Tomcat [![Build Status](https://travis-ci.org/Islandora-Devops/ansible-role-tomcat9.svg?branch=main)](https://travis-ci.org/Islandora-Devops/ansible-role-tomcat9)

An Ansible role that installs Tomcat on Ubuntu 20.04 Focal Fossa

## Role Variables

Available variables are listed below, along with default values:

Tomcat packages to install
```
tomcat9_packages:
  - tomcat9
```

Tomcat admin packages to install
```
tomcat9_admin_packages:
  - tomcat9-admin
```

Directory to install Tomcat into
```
tomcat9_home: /var/lib/tomcat9
```

Whether to install the Tomcat administrative interface
```
tomcat9_admin_install: yes
```

Tomcat roles
```
tomcat9_roles: []
```

Tomcat users
```
tomcat9_users: []
```

User and group to run Tomcat as
```
tomcat9_server_user: tomcat
tomcat9_server_group: tomcat
```

Some OS-specific variables are set in vars/* but can be overridden
```
tomcat9_home: /opt/tomcat
```
## Dependencies

  None

## Example Playbook

    - hosts: webservers
      roles:
        - { role: islandora.tomcat9 }

## License

MIT
