""" Ansible module for building projects with CMake.

See the DOCUMENTATION and EXAMPLES strings below for more information.

"""
from __future__ import print_function

from glob import glob
from os.path import abspath
from subprocess import Popen
from subprocess import PIPE


from ansible.module_utils.basic import AnsibleModule


__all__ = "main",


__version__ = "0.1.3"  # PEP 0440 with Semantic Versioning


DOCUMENTATION = """
module: cmake
short_description: Build a project using CMake.
notes:
- U(github.com/mdklatt/ansible-cmake-module)
version_added: "2.1"
author: Michael Klatt
options:
  build_type:
    description: CMake build type to use.
    required: false
    default: Debug
    choices: [Debug, Release, RelWithDebInfo, MinSizeRel]
  binary_dir:
    description: Destination for binaries.
    required: true
  source_dir:
    description: |
      Location of C(CMakeLists.txt). This is required the first time a project
      is built, or use it to tell CMake to regenerate the build files.
    required: false
  cache_vars:
    description: A dictionary of cache variables to define.
    required: false
  target:
    description: The name of the target to build.
    required: false
  creates:
    description: |
      If the given path exists (wildcards are allowed), the CMake command will
      not be executed.
    required: false
  executable:
    description: Path to the C(cmake) executable.
    required: false
"""  # must be valid YAML


EXAMPLES = """
# Build a binary.
- cmake:
    source_dir: /path/to/project
    binary_dir: /path/to/broject/build

# Build and install a binary if it doesn't already exist.
- cmake:
    source_dir: /path/to/project
    binary_dir: /path/to/project/build
    target: install
    creates: /path/to/installed/binary

# Clean a built project (source_dir is not required).
- cmake:
    binary_dir: /path/to/project/build
    target: clean
"""  # plain text


_ARGS_SPEC = {
    # MUST use list for choices.
    "build_type": {
        "default": "Debug",
        "choices": ["Debug", "Release", "RelWithDebInfo", "MinSizeRel"],
    },
    "binary_dir": {"required": True},
    "source_dir": {"default": None},
    "cache_vars": {"type": "dict"},
    "target": {},
    "creates": {"default": ""},  # empty path never exists
    "executable": {"default": "cmake"},
}


def main():
    """ Execute the module.

    """
    def cmake(args):
        """ Execute cmake command. """
        # Any output to STDOUT or STDERR must be captured.
        args = [module.params["executable"]] + list(args)
        process = Popen(args, stdout=PIPE, stderr=PIPE, cwd=binary)
        stdout, stderr = process.communicate()
        if process.returncode != 0:
            module.fail_json(msg=stderr, stdout=stdout, rc=process.returncode)
        return

    def config():
        """ Execute the CMake config step. """
        args = []
        for var in cache_vars.iteritems():
            args.extend(("-D", "=".join(var)))
        source = abspath(module.params["source_dir"])
        args.append(source)
        cmake(args)
        return

    def build():
        """ Execute the CMake build step. """
        args = ["--build", binary]
        if module.params["target"]:
            args.extend(("--target", module.params["target"]))
        cmake(args)
        return

    module = AnsibleModule(_ARGS_SPEC, supports_check_mode=True)
    required = not glob(module.params["creates"])
    if module.check_mode:
        module.exit_json(changed=required)  # calls exit(0)
    if required:
        binary = abspath(module.params["binary_dir"])
        cache_vars = {"CMAKE_BUILD_TYPE": module.params["build_type"]}
        try:
            cache_vars.update(module.params["cache_vars"])
        except TypeError:  # parameter is None
            pass
        if module.params["source_dir"]:
            config()
        build()
    module.exit_json(changed=required, rc=0, **module.params)  # calls exit(0)


# Make the module executable.

if __name__ == "__main__":
    raise SystemExit(main())
