HOSTS:=hosts

default: zones

clean:
	find . -name \*.retry -type f -delete

zones:
	ansible-playbook -i $(HOSTS) zones.yml --ask-vault-pass

.PHONY: clean default zones
