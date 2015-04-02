$ORIGIN		talideon.com.
$TTL		3600

@			SOA		ns1 k.stereochro.me. (
					2015040203 ; serial
					6h         ; refresh
					1h         ; retry
					1w         ; expire
					1d         ; minimum
					)
			NS		ns1
			NS		ns2
			NS		ns3
			NS		ns4
			A		78.153.202.217
			AAAA	2a01:a8:201::217
			MX		40 mail.talideon.com.
			; The TXT record is needed for dumber mailservers.
			TXT		"v=spf1 a mx -all"
			SPF		"v=spf1 a mx -all"
www			CNAME	@

mail		A		78.153.202.217
mail		AAAA	2a01:a8:201::217

; Nameservers
; lir.talideon.com
ns1			A		78.153.202.217
ns1			AAAA	2a01:a8:201::217
; bunsen.moybella.net
ns2			A		188.40.129.84
ns2			AAAA	2a01:4f8:101:23a4::2
; ns2.blacknightsolutions.com
ns3			A		82.96.97.64
ns3			AAAA	2001:1bc0:ab:3::2
; cian.talideon.com
ns4			A		45.55.149.240
ns4			AAAA	2604:a880:800:10::716:6001

; Server itself.
lir			A		78.153.202.217
lir			AAAA	2a01:a8:201::217

lir			SSHFP	1 1 f08cd3d31d3be6bc2687a38f0edc7881e99bc207
lir			SSHFP	1 2 b4d609295c470eafa42f8d3e2f94765a5523a0d9b1bc07e01ab97bcad17e0cb3
lir			SSHFP	2 1 17716e30fef9653801fc1a42deba46624e5d9491
lir			SSHFP	2 2 5abfbfa16b91c9fac1683656743743f0aedab0e24cf78cf0e60df7b768d2fd25
lir			SSHFP	3 1 873c8651b2daf6cfc8273dadbf77b46edc181a42
lir			SSHFP	3 2 8efc13f18be81ec12a09e36c7b0b153bccea4f00b5102fc23ddd5042f5a225d3

; My home network.
etain		A		213.79.53.114

; My Digital Ocean VM.
cian		A		45.55.149.240
cian		AAAA	2604:a880:800:10::716:6001

cian		SSHFP	1 1 d190104b6a82cdf1fc24bc1597c17a05c36c948b
cian		SSHFP	1 2 32419935f517b1b54bd344a4eb2bd12122c2ad120b483c39a80b2013a0e8f351
cian		SSHFP	2 1 467400854e4592f5962af804f484ed338572c143
cian		SSHFP	2 2 5eb68371949219790f6af84f307b66e171c731f06ffcac4c26d3311e84ab5f2b
cian		SSHFP	3 1 829d076fe4593963d769a632c880bdaa4af4f618
cian		SSHFP	3 2 45a879ad33d36e640e11a02e10413a9d9e30ac74d1b05530172353d62ac8b477

; Aliases.
bethisad	CNAME	@
mirrors		CNAME	@

; Services
_imap._tcp          SRV     0 1 143  mail.talideon.com.
_imaps._tcp			SRV		0 1 993  mail.talideon.com.
_submission._tcp	SRV		0 1 587  mail.talideon.com.
_sieve._tcp			SRV		0 1 4190 mail.talideon.com.
_xmpp-client._tcp	SRV		0 1 5222 talideon.com.
_xmpp-server._tcp	SRV		0 1 5269 talideon.com.

; DANE
_25._tcp.mail		TLSA	1 0 1 74271471a968933deb5a413dcf82dd2d973c186aff1c1607f1b3b8997b467cce
_443._tcp			TLSA	1 0 1 74271471a968933deb5a413dcf82dd2d973c186aff1c1607f1b3b8997b467cce
_143._tcp.mail		TLSA	1 0 1 74271471a968933deb5a413dcf82dd2d973c186aff1c1607f1b3b8997b467cce
_443._tcp.mail		TLSA	1 0 1 74271471a968933deb5a413dcf82dd2d973c186aff1c1607f1b3b8997b467cce
_587._tcp.mail		TLSA	1 0 1 74271471a968933deb5a413dcf82dd2d973c186aff1c1607f1b3b8997b467cce
_993._tcp.mail		TLSA	1 0 1 74271471a968933deb5a413dcf82dd2d973c186aff1c1607f1b3b8997b467cce
_4190._tcp.mail		TLSA	1 0 1 74271471a968933deb5a413dcf82dd2d973c186aff1c1607f1b3b8997b467cce
_5222._tcp			TLSA	1 0 1 74271471a968933deb5a413dcf82dd2d973c186aff1c1607f1b3b8997b467cce
_5269._tcp			TLSA	1 0 1 74271471a968933deb5a413dcf82dd2d973c186aff1c1607f1b3b8997b467cce

; vim:set filetype=dns:
