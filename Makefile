default: all

all: kitchen

bionic-nginx64-vbox.box: bionic-nginx64.json http/preseed.cfg scripts/provision-tools.sh scripts/provision-nginx.sh 
	packer validate bionic-nginx64.json 
	packer build -force bionic-nginx64.json

kitchen-vbox: bionic-nginx64-vbox.box
	bundle exec kitchen test

kitchen: kitchen-vbox

.PHONY: clean
clean:
	-vagrant box remove -f bionic-nginx64 --provider virtualbox
	-rm -fr output-*/ *.box