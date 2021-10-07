# Ansible Role: Cantaloupe

An Ansible role that installs [Cantaloupe](https://github.com/medusa-project/cantaloupe) in a Tomcat 8 servlet container on:

* Centos/RHEL 7.x
* Ubuntu Xenial

## Role Variables

Available variables are listed below, along with default values:

```
# Cantaloupe version
cantaloupe_version: 4.1.7
# Where to extract the cantaloupe archive
cantaloupe_install_root: /opt
# Target of a symlink from the extracted cantaloupe archive 
cantaloupe_symlink: /opt/cantaloupe
# Path to cantaloupe logs
cantaloupe_log_path: /var/log/cantaloupe
# Cantaloupe user
cantaloupe_user: cantaloupe
# Cantaloupe group
cantaloupe_group: cantaloupe

# Whether to automatically deploy the war file
cantaloupe_deploy_war: no
# Where to deploy the war to
cantaloupe_deploy_war_path: /path/to/tomcat/webapps
# Name for the deployed war (minus .war), this is the context path
cantaloupe_deploy_war_filename: cantaloupe
# Create the filesystem cache directory automatically
cantaloupe_create_FilesystemCache_dir: no
```

There are many more options available and documented in the [defaults/main.yml](defaults/main.yml)

## Dependencies

* A tomcat 8 container like [islandora.tomcat8](https://github.com/Islandora-DevOps/ansible-role-tomcat8)
  
## Example Playbook

    - hosts: webservers
      roles:
        - { role: islandora.cantaloupe }

## License

MIT
