$ORIGIN		talideon.com.
$TTL		3600

@			SOA		ns1 k.stereochro.me. (
					2015021601 ; serial
					6h         ; refresh
					1h         ; retry
					1w         ; expire
					1d         ; minimum
					)
			NS		ns1
			NS		ns2
			A		78.153.202.217
			AAAA	2a01:a8:201::217
			MX		40 mail.talideon.com.
			; The TXT record is needed for dumber mailservers.
			TXT		"v=spf1 a mx -all"
			SPF		"v=spf1 a mx -all"
www			CNAME	@

; Nameservers
ns1			A		78.153.202.217
ns1			AAAA	2a01:a8:201::217
ns2			A		188.40.129.84
ns2			AAAA	2a01:4f8:101:23a4::2

; Server itself.
lir			A		78.153.202.217
lir			AAAA	2a01:a8:201::217

lir			SSHFP 1 1 f08cd3d31d3be6bc2687a38f0edc7881e99bc207
lir			SSHFP 1 2 b4d609295c470eafa42f8d3e2f94765a5523a0d9b1bc07e01ab97bcad17e0cb3
lir			SSHFP 2 1 17716e30fef9653801fc1a42deba46624e5d9491
lir			SSHFP 2 2 5abfbfa16b91c9fac1683656743743f0aedab0e24cf78cf0e60df7b768d2fd25
lir			SSHFP 3 1 873c8651b2daf6cfc8273dadbf77b46edc181a42
lir			SSHFP 3 2 8efc13f18be81ec12a09e36c7b0b153bccea4f00b5102fc23ddd5042f5a225d3

; Aliases.
bethisad	CNAME	@
mail		CNAME	@
mirrors		CNAME	@

; My home network.
etain       A       213.79.53.114

; Services
_submission._tcp    SRV 0 1 587  mail.talideon.com.
_sieve._tcp         SRV 0 1 4190 mail.talideon.com.

; vim:set filetype=dns:
