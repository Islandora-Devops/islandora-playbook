# Ansible Role: FITS

An Ansible role that installs [FITS](https://projects.iq.harvard.edu/fits) on:

* Centos/RHEL 7.x
* Ubuntu Xenial

## Role Variables

Available variables are listed below, along with default values:

Where to download to:
```
fits_download_dir: /usr/local/src
```

Version of FITS to install:
```
fits_version: 1.1.1
```

Version of FITS Web service to install:
```
fits_ws_version: 1.1.3
```

Where to install FITS:
```
fits_install_root: /opt
```

What to call the symlink created from above directory:
```
fits_install_symlink: /opt/fits
```

User/group to install as:
```
fits_user: tomcat
fits_group: tomcat
```

Install the FITS web service in Tomcat
```
fits_ws: yes
```

## Dependencies

* Tomcat
  
## Example Playbook

    - hosts: webservers
      roles:
        - { role: islandora.fits }

## License

MIT