#!/bin/sh

ssh-keyscan -H vm > /root/.ssh/known_hosts

ansible-galaxy install --role-file=/root/playbook/requirements.yml --roles-path=roles/external

ansible-playbook \
    -u root \
    -i ./inventory/vagrant/hosts \
    -e '@./docker/extra-vars.yml' \
    -e ansible_ssh_host='vm' \
    -e int_host='vm' \
    --private-key /root/.ssh/id_rsa \
    ./playbook.yml \
    -l default

## Keeps the container running forever, after Ansible finishes
tail -f /dev/null