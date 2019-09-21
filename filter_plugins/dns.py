"""
DNS utilities.
"""

import datetime

import dns.exception
import dns.resolver


def get_serial(fqdn):
    res = dns.resolver.Resolver()
    try:
        answers = res.query(fqdn, "SOA")
    except dns.exception.DNSException as e:
        pass
    else:
        for rdata in answers:
            return rdata.serial
    return None


def next_serial(fqdn):
    current_serial = get_serial(fqdn)
    today = datetime.datetime.utcnow().strftime("%Y%m%d")
    if current_serial is None or not str(current_serial).startswith(today):
        return today + "00"
    return str(current_serial + 1)


class FilterModule(object):
    """
    """

    def filters(self):
        return {"next_serial": next_serial}
