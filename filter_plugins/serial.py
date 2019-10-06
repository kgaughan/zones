"""
DNS utilities.
"""

import datetime
import random
import socket

import dns.exception
import dns.resolver


def query(fqdn, qname, nss=None):
    resolver = dns.resolver.Resolver()
    if nss:
        resolver.nameservers = nss
    return resolver.query(fqdn, qname)


def query_nameservers(fqdn):
    nss = []
    for answer in query(fqdn, "NS"):
        for addr in socket.getaddrinfo(answer.target.to_text(), "domain"):
            nss.append(addr[4][0])
    return nss


def get_serial(fqdn):
    try:
        answers = query(fqdn, "SOA", query_nameservers(fqdn))
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
