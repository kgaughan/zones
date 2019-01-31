"""
DNS utilities.
"""

import datetime
import os
import random
import shlex
import subprocess


def which(cmd):
    for path in os.environ["PATH"].split(os.pathsep):
        full_path = os.path.join(path, cmd)
        if os.access(full_path, os.X_OK):
            return full_path
    return None


def run_query(cmd, rtype, fqdn, ns=None):
    if not fqdn.endswith('.'):
        fqdn += '.'

    args = [cmd]
    if ns:
        args.append('@' + ns)
    args.extend([fqdn, rtype])

    for line in subprocess.check_output(args).decode().split('\n'):
        if line.startswith(';'):
            continue
        parsed = shlex.split(line)
        if len(parsed) > 0 and parsed[0] == fqdn and parsed[3] == rtype:
            yield parsed[4:]


def next_serial(fqdn):
    full_path = which('dig')
    if full_path is None:
        raise Exception('Cannot find dig')

    def query_nameservers(fqdn, ns=None):
        return [line[0] for line in run_query(full_path, 'NS', fqdn, ns)]

    # Get a registry nameserver.
    reg_ns = random.choice(query_nameservers('.'.join(fqdn.split('.')[1:])))

    nss = query_nameservers(fqdn, reg_ns)
    random.shuffle(nss)

    current_serial = None
    for ns in nss:
        try:
            for line in run_query(full_path, 'SOA', fqdn, ns):
                current_serial = line[2]
                break
        except subprocess.CalledProcessError as exc:
            if exc.returncode not in [9]:
                raise
        if current_serial is not None:
            break

    today = datetime.datetime.utcnow().strftime('%Y%m%d')
    if current_serial is None or current_serial[:8] != today:
        return today + '00'
    return str(int(current_serial) + 1)


class FilterModule(object):
    """
    """

    def filters(self):
        return {
            'next_serial': next_serial,
        }
