
# Run a karaf command
def run_command(module, base, args):
    client_bin = module.params['client_bin']
    command = "{0} 'feature:{1} {2}'".format(client_bin, base, args)
    rc, out, err = module.run_command(command)
    result = {'rc' : rc, 'stdout' : out, 'stderr' : err}
    if rc != 0:
        module.fail_json(msg=result['stdout'])
    return result

# Get a list of items from karaf
def get_list(result, size, index):
    items = [];
    for line in result['stdout'].splitlines():
        item = line.split("\t")
        if len(item) == size:
            items.append(item[index].strip())
    return items, result['stdout']

# Format a list so we can show a nice diff
def format_diff(items):
    return "\n".join(items) + "\n"

# Decide if anything will change this invocation
def get_changed(state, name, items):
    if state == 'present':
        if name in items:
            return False
        else:
            return True
    elif state == 'absent':
        if name not in items:
            return False
        else:
            return True

# Create a diff for check diff
def check_diff_output(state, items, name):
    if state == 'present':
        after = items + [name]
    elif state == 'absent':
        after = [item for item in items if item != name]
    return diff_output(items,after)

# Creat a diff output
def diff_output(before, after):
    diff = dict(
        before=format_diff(before),
        after=format_diff(after)
    )
    return diff
