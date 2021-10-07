#!/usr/bin/python

ANSIBLE_METADATA = {
    'metadata_version': '0.1',
    'status': ['preview'],
    'supported_by': 'community'
}

DOCUMENTATION = '''
---
module: karaf_repo

short_description: Manage repos with karaf

version_added: "2.3"

description:
    - Allows the idempotent addition and removal of repositories from karaf.

options:
    name:
        description:
            - The URL of the repository
        required: true
    state:
        description:
            - If present the repository will be added to Karaf
            - If absent the repository will be removed from Karaf
        required: false
        choices: [ present, absent ]
        default: present

author:
    - Jonathan Green (@jonathangreen)
'''

EXAMPLES = '''
# Install karaf repo
- karaf_repo:
    state: present
    url: mvn:org.apache.camel.karaf/apache-camel/2.18.1/xml/features

# Uninstall karaf repo
- karaf_repo:
    state: absent
    url: mvn:org.apache.camel.karaf/apache-camel/2.18.1/xml/features
'''

RETURN = '''
original_repos:
    description: The list of repos before this command was run
repos:
    description: The list of repos after this command was run
'''

from ansible.module_utils.basic import AnsibleModule
from ansible.module_utils.karaf_common import *

def get_repo_list(module):
    result = run_command(module, 'repo-list', '--no-format')
    return get_list(result,2,1)

def add_remove_repo(module):
    name = module.params['name']
    state = module.params['state']
    if state == 'present':
        base = 'repo-add'
    elif state == 'absent':
        base = 'repo-remove'
    return run_command(module, base, name)

def main():
    module_args = dict(
        name=dict(type='str', required=True),
        state=dict(choices=['present', 'absent'], default='present'),
        client_bin=dict(default="/opt/karaf/bin/client", type="path")
    )

    result = dict(
        changed=False
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    state = module.params['state']
    name = module.params['name']
    repo_list, repo_stdout = get_repo_list(module)

    result['before'] = repo_list
    result['before_raw'] = repo_stdout
    result['changed'] = get_changed(state, name, repo_list)
    result['params'] = module.params

    if not result['changed']:
        module.exit_json(**result)

    if module.check_mode:
        if module._diff:
            result['diff'] = check_diff_output(state, repo_list, name)
        module.exit_json(**result)

    result['result'] = add_remove_repo(module)
    repo_list, repo_stdout = get_repo_list(module)
    result['after'] = repo_list
    result['after_raw'] = repo_stdout

    if module._diff:
        result['diff'] = diff_output(result['before'], result['after'])

    module.exit_json(**result)

if __name__ == '__main__':
    main()
