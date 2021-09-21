# Ansible Role: Drupal-OpenSeadragon

An Ansible role that installs the [Drupal 8 field formatter](https://github.com/Islandora-CLAW/openseadragon) and [OpenSeadragon library](https://openseadragon.github.io/) on:

* Centos/RHEL 7.x
* Ubuntu Xenial

## Role Variables

Available variables are listed below, along with default values:

Composer package to install:
```
openseadragon_composer_item: "islandora/openseadragon:dev-8.x-1.x"
```

Drupal composer root:
```
openseadragon_composer_root: "/var/www/html/drupal"
```

Drupal sites:
```
openseadragon_sites:
  - default
```

Drush path (note: if a preceding task sets drush_path, it will override the default value):
```
openseadragon_drush_path: /usr/local/bin/drush
```

Version of Openseadragon library to install:
```
openseadragon_version: 2.2.1
```

Temporary directory to download to:
```
openseadragon_temp_folder: /tmp
```

Check for an existing IIIF server configuration setting
```
openseadragon_iiiv_set_var: false
```

What to set the IIIF server to:
```
openseadragon_iiiv_server:
```

## Dependencies

* Drupal 8
* Drush
* Working IIIF image server (like [islandora.cantaloupe](https://github.com/Islandora-DevOps/ansible-role-cantaloupe))

## Example Playbook

    - hosts: webservers
      roles:
        - { role: islandora.drupal-openseadragon }

## License

MIT
