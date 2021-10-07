# Ansible Role: Keymaster

An Ansible role that copies provided or self-generated keys to other roles on:

* Centos/RHEL 7.x
* Ubuntu Xenial

## Role Variables

Available variables are listed below, along with default values:

```
# Source directory for keys.
ssl_key_directory: /opt/keys/claw
# Public key filename
ssl_key_public_file: public.key
# Private key filename
ssl_key_private_file: private.key
# Path to copy private key to
ssl_key_private_output_path: /tmp/private.key
# Path to copy public key to
ssl_key_public_output_path: /tmp/public.key

```

## Usage

This role is to allow you to copy the same set of public or private keys to multiple locations/servers. The role is referenced itself except when included by other roles.

ie.
```
- name: Get SSL keys
  include_role: 
    name: keymaster
  vars:
    ssl_key_public_output_path: "{{ my_public_key_path }}"
```

This causes the public key that keymaster is watching to be copied to the path "{{ my\_public\_key\_path }}"

You can also copy the private key by providing the variable `ssl_key_private_output_path` like here:
```
- name: Get SSL keys
  include_role: 
    name: keymaster
  vars:
    ssl_key_private_output_path: "{{ webserver_app_jwt_key_path }}/private.key"
```

## Dependencies

none
  
## Example Playbook

    - hosts: webservers
      roles:
        - { role: Islandora-Devops.keymaster }

## License

MIT
