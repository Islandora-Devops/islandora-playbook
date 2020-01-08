# -*- encoding:utf-8 -*-
# Copied from https://adamj.eu/tech/2016/08/19/restricting-the-ansible-version-in-use/
# and edited to our use-case.
from __future__ import absolute_import, division, print_function, unicode_literals

import sys
import os
import os.path
import yaml
from distutils.version import StrictVersion

import ansible

try:
    # Version 2.0+
    from ansible.plugins.callback import CallbackBase
except ImportError:
    CallbackBase = object


class CallbackModule(CallbackBase):
    def __init__(self):
        self.minimum_version = StrictVersion('2.7.0')
        self.maximum_version = StrictVersion('2.8.7')
        self.load_from_main()
        current_version = StrictVersion(ansible.__version__)
        # Can't use `on_X` because this isn't forwards compatible with Ansible 2.0+
        if current_version < self.minimum_version or current_version > self.maximum_version:
            CallbackModule.print_red_bold(
                "Islandora-Playbook restriction: only an Ansible version between {minversion} and {maxversion} is supported."
                .format(minversion=self.minimum_version, maxversion=self.maximum_version)
            )
            sys.exit(1)

    @staticmethod
    def print_red_bold(text):
        print('\x1b[31;1m' + text + '\x1b[0m')

    def load_from_main(self):
        current_dir = os.getcwd()
        version_file = os.path.join(current_dir, 'ansible-version.yml')
        if os.path.exists(version_file):
            with open(version_file, 'r') as fp:
                versions = yaml.load(fp, Loader=yaml.SafeLoader)
            try:
                self.minimum_version = StrictVersion(versions['islandora_ansible_version_min'])
            except KeyError:
                pass
            try:
                self.maximum_version = StrictVersion(versions['islandora_ansible_version_max'])
            except KeyError:
                pass
