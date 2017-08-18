BIN_DIR=/usr/local/bin
MIX_ENV=production

test:
	@mix test.watch

clean:
	@rm -f ./refactor
	@rm -f ./sample_refactored.ex

build: clean
	@mix escript.build 
	@chmod +x refactor

install: build
	@cp -rf ./refactor ${BIN_DIR}
	@echo "Installed \`refactor\` to ${BIN_DIR}"

.PHONY: install clean build test
.DEFAULT_GOAL := build
