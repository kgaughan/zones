HOSTS:=hosts

default: zones

clean:
	find . -name \*.retry -type f -delete

zones:
	ansible-playbook -i $(HOSTS) zones.yml

.PHONY: clean default zones
