# Ansible Role: Apache Karaf [![Build Status](https://travis-ci.org/Islandora-Devops/ansible-role-karaf.svg?branch=main)](https://travis-ci.org/Islandora-Devops/ansible-role-karaf)

An Ansible role that installs [Karaf](https://karaf.apache.org) in a Tomcat 8 servlet container on:

* Centos/RHEL 7.x
* Ubuntu Xenial

## Role Variables

Available variables are listed below, along with default values:

Version to install:
```
karaf_version: 4.0.8
```

Where to download Karaf to:
```
karaf_staging_folder: /usr/local/src
```

Where to install Karaf to:
```
karaf_install_folder: /opt
```

Where to put the symlink for Karaf:
```
karaf_install_symlink: /opt/karaf
```

User to run Karaf as:
```
karaf_user: karaf
```

Whether to create the user:
```
karaf_create_user: yes
```

Name of the Karaf service:
```
karaf_service_name: karaf
```

Karaf log levels:
```
karaf_log_root_level: INFO
karaf_log_camel_level: DEBUG
karaf_log_islandora_level: DEBUG
```

Where to put the log files:
```
karaf_log_path: ${karaf.data}/log/
```

Logging configuration template:
```
karaf_logging_template: org.ops4j.pax.logging.cfg
```

Java home:
```
karaf_java_home: /usr/lib/jvm/java-8-openjdk-amd64
```

Java packages required to install:
```
karaf_java_packages:
  - openjdk-8-jre
  - openjdk-8-jdk
```

Karaf service file template:
```
karaf_systemd_template: karaf.service
```

## Dependencies

* Java 8
  
## Example Playbook

    - hosts: webservers
      roles:
        - { role: islandora.karaf }

## License

MIT
