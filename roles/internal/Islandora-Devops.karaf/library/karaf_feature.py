#!/usr/bin/python

ANSIBLE_METADATA = {
    'metadata_version': '0.1',
    'status': ['preview'],
    'supported_by': 'community'
}

DOCUMENTATION = '''
---
module: karaf_feature

short_description: Manage features with karaf

version_added: "2.3"

description:
    - Allows the idempotent addition and removal of features from karaf.

options:
    name:
        description:
            - The name of the feature
        required: true
    state:
        description:
            - If present the feature will be added to Karaf
            - If absent the feature will be removed from Karaf
        required: false
        choices: [ present, absent ]
        default: present

author:
    - Jonathan Green (@jonathangreen)
'''

EXAMPLES = '''
# Install karaf feature
- karaf_repo:
    state: present
    url: fcrepo-api-x

# Uninstall karaf feature
- karaf_repo:
    state: absent
    url: fcrepo-api-x
'''

RETURN = '''
before:
    description: The list of features before this command was run
before_raw:
    description: The unparsed raw output of the list command
after:
    description: The list of features after this command was run
after_raw:
    description: The unparsed raw output of the list command
'''

from ansible.module_utils.basic import AnsibleModule
from ansible.module_utils.karaf_common import *

def get_feature_list(module):
    result = run_command(module, 'list', '-i --no-format')
    return get_list(result, 6, 0)

def add_remove_feature(module):
    name = module.params['name']
    state = module.params['state']
    if state == 'present':
        base = 'install'
    elif state == 'absent':
        base = 'uninstall'
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
    feature_list, feature_stdout = get_feature_list(module)

    result['before'] = feature_list
    result['before_raw'] = feature_stdout
    result['changed'] = get_changed(state, name, feature_list)
    result['params'] = module.params

    if not result['changed']:
        module.exit_json(**result)

    if module.check_mode:
        if module._diff:
            result['diff'] = check_diff_output(state, feature_list, name)
        module.exit_json(**result)

    result['result'] = add_remove_feature(module)
    feature_list, feature_stdout = get_feature_list(module)
    result['after'] = feature_list
    result['after_raw'] = feature_stdout

    if module._diff:
        result['diff'] = diff_output(result['before'], result['after'])

    module.exit_json(**result)

if __name__ == '__main__':
    main()
