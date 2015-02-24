$ORIGIN	davidwalkerandme.com.
$TTL	3600

@		SOA		ns1.talideon.com. k.stereochro.me. (
				2014013002 ; serial
				6h         ; refresh
				1h         ; retry
				1w         ; expire
				1d         ; minimum
				)
		NS		ns1.talideon.com.
		NS		ns2.talideon.com.
		NS		ns3.talideon.com.
		A		78.153.202.217
		AAAA	2a01:a8:201::217
		SPF		"v=spf1 -all"
www		CNAME	@

; vim:set filetype=dns:
