SHELL=/bin/bash
PACKAGE_NAME=postfix_exporter
FOLDER=build


.PHONY: all

all: build


build:
	go build -tags nosystemd -ldflags="-s -w" -o $(FOLDER)/$(PACKAGE_NAME) $(PACKAGE_NAME)/*.go
	ls -sh $(FOLDER)/$(PACKAGE_NAME)
	upx --best --lzma $(FOLDER)/$(PACKAGE_NAME)
	ls -sh $(FOLDER)/$(PACKAGE_NAME)

create-tar:
	cd $(FOLDER)/; tar -zcf $(PACKAGE_NAME)-linux64.tar.gz $(PACKAGE_NAME)
	ls -sh $(FOLDER)/



install-upx:
	apt-get -qq update
	apt-get install -yqq xz-utils curl
	curl -skLO https://github.com/upx/upx/releases/download/v3.96/upx-3.96-amd64_linux.tar.xz
	tar -xf upx-3.9*-amd64_linux.tar.xz
	cp upx-3.9*-amd64_linux/upx /usr/local/bin/
	chmod +x /usr/local/bin/upx
	rm -rf upx-3.9*
