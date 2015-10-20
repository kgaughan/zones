$ORIGIN		talideon.com.
$TTL		3600

@			SOA		ns1 k.stereochro.me. (
					2015102000 ; serial
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
			TXT		"v=spf1 ip4:45.55.149.240 ip6:2604:a880:800:10::716:6001/64 a mx -all"
			SPF		"v=spf1 ip4:45.55.149.240 ip6:2604:a880:800:10::716:6001/64 a mx -all"
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
ns3			A		78.153.202.4
ns3			AAAA	2a01:a8:dc2:33::33
; cian.talideon.com
ns4			A		45.55.149.240
ns4			AAAA	2604:a880:800:10::716:6001

; Server itself.
lir			A		78.153.202.217
lir			AAAA	2a01:a8:201::217

lir			TXT		"v=spf1 a mx -all"
lir			SPF		"v=spf1 a mx -all"

lir			SSHFP	1 1 33f52ffa59079b25a3d2e41b05403383016f586a
lir			SSHFP	1 2 1b3291d1d27b4e67e1c56c5943783c56280c590867a79361a4f847c7fc0bf262
lir			SSHFP	2 1 27dfe15fc68ae916d5be965ec6ab556638b3e886
lir			SSHFP	2 2 9212211b7b73756c8a13c10ed09e38f57018ffcdc38cc9aee5f7824238e2b49d
lir			SSHFP	3 1 78fc530683dfb7c622794aff53385d902c3acbd3
lir			SSHFP	3 2 d655e85051012ad4a23fbd1a67032abfaac4748169445a22a70597961225a484

; My home network.
etain		A		213.79.53.114

; My Digital Ocean VM.
cian		A		45.55.149.240
cian		AAAA	2604:a880:800:10::716:6001

cian		TXT		"v=spf1 a:lir.talideon.com a mx -all"
cian		SPF		"v=spf1 a:lir.talideon.com a mx -all"


cian		SSHFP	1 1 b3c27d0efecee20d4c00e3f5f3cd2a61ca02ad82
cian		SSHFP	1 2 7ad47957fbb90f54a299f29efbde82066f64744cb5c50e106af7da0d082821cf
cian		SSHFP	2 1 9d3b92fd93e5f8803c2a889d73806a84bfc7d670
cian		SSHFP	2 2 f8ef86bb095339039496b875ae2dfc8a27bb6b0f8d32f40990911d3d8e935c1d
cian		SSHFP	3 1 2f1baf6bf8d66c0615a205b7628475a419563f4b
cian		SSHFP	3 2 21ec08609d41e94cad66a2cc06b8b47bb753a2400aeba2221ed9938979f6436b

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
_443._tcp			TLSA	1 0 1 8dc0411a9b721ddbca53f37df9e1269aab30a3c43d1b54692f5e9b550cce41c3
_443._tcp.www		TLSA	1 0 1 8dc0411a9b721ddbca53f37df9e1269aab30a3c43d1b54692f5e9b550cce41c3
_5222._tcp			TLSA	1 0 1 8dc0411a9b721ddbca53f37df9e1269aab30a3c43d1b54692f5e9b550cce41c3
_5269._tcp			TLSA	1 0 1 8dc0411a9b721ddbca53f37df9e1269aab30a3c43d1b54692f5e9b550cce41c3
; According to https://tools.ietf.org/html/draft-ietf-dane-smtp-with-dane-15,
; for SMTP, we can't use PKIX-EE (1) and have to use DANE-EE (3) as the whole
; certificate chain isn't validated for opportunistic DANE TLS.
_25._tcp.mail		TLSA	3 0 1 4a3ef37db926db56145d341bb72308d6edea982d88c19806c15580a1c94f77d4
_143._tcp.mail		TLSA	3 0 1 4a3ef37db926db56145d341bb72308d6edea982d88c19806c15580a1c94f77d4
_587._tcp.mail		TLSA	3 0 1 4a3ef37db926db56145d341bb72308d6edea982d88c19806c15580a1c94f77d4
_993._tcp.mail		TLSA	3 0 1 4a3ef37db926db56145d341bb72308d6edea982d88c19806c15580a1c94f77d4
_4190._tcp.mail		TLSA	3 0 1 4a3ef37db926db56145d341bb72308d6edea982d88c19806c15580a1c94f77d4

; vim:set filetype=dns:
