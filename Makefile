# Variables:
# OS (fedora or macos)
# GIT_EMAIL

.PHONY: all
all: gitconfig zshrc nvim/init.lua

.PHONY: install
install:
	cp zshenv ~/.zshenv
	cp zshrc ~/.zshrc
	cp gitconfig ~/.gitconfig
	cp -r nvim ~/.config/nvim

.PHONY: uninstall
uninstall:
	rm -rf ~/.zshenv ~/.zshrc ~/.config/nvim

.PHONY: clean
clean:
	rm -f zshrc nvim/init.lua

gitconfig: gitconfig.m4
	m4 -D__OS=$(OS) -D__GIT_EMAIL=$(GIT_EMAIL) $< > $@

nvim/init.lua: init.lua.m4
	m4 -D__OS=$(OS) $< > $@

%: %.m4
	m4 -D__OS=$(OS) $< > $@
