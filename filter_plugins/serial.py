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


def query_nameservers(fqdn, source=None):
    return [answer.target.to_text() for answer in query(fqdn, "NS", source)]


def get_serial(fqdn):
    # Get the authoritative nameservers, resolving them to IPs.
    nss = []
    for ns in query_nameservers(fqdn):
        for addr in socket.getaddrinfo(ns, 0):
            nss.append(addr[4][0])

    try:
        answers = query(fqdn, "SOA", nss)
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
