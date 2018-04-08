BIN_DIR=/usr/local/bin
MIX_ENV=production

deps:
	@mix deps.get
	@mix deps.clean --unused

test:
	@mix test.watch

clean:
	@mix deps.clean --unused
	@rm -rf ./rel ./_build ./refactor ./test/sample/ ./*.dump ./*.DS_Store **/*.DS_Store

build: clean
	@mix escript.build 
	@chmod +x refactor

install: build
	@cp -rf ./refactor ${BIN_DIR}
	@echo "Installed \`refactor\` to ${BIN_DIR}"

.PHONY: install clean build test
.DEFAULT_GOAL := build
