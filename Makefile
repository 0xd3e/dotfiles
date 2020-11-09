.PHONY: run
run:
	ansible-playbook --ask-become-pass site.yaml
