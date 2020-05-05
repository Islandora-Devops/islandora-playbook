#!/bin/sh

ssh-keyscan -H vm > /root/.ssh/known_hosts

ansible-galaxy install --role-file=/root/playbook/requirements.yml --roles-path=roles/external
ansible-playbook -i /root/playbook/inventory/docker /root/playbook/playbook.yml
tail -f /dev/null