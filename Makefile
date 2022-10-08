
ROOT_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

# Targets
DOT_CONFIG = ${HOME}/.config
TMUX_TPM = ${HOME}/dotfiles/dots/tmux/plugins/tpm
NVIM = ${HOME}/.config/nvim

# Default target
all: $(TMUX_TPM)

$(DOT_CONFIG): ${HOME}/dotfiles/config
	mkdir -p $@
	ln -sf $< $@

$(TMUX_TPM):
	git clone https://github.com/tmux-plugins/tpm $@


.PHONY: brew
brew:
	brew install vivaldi
	brew install neovim
	brew install tmux
	brew install viu
	brew install iterm2

.PHONY: brew-hackgen
brew-font:
	brew tap homebrew/cask-fonts
	brew install font-hackgen
	brew install font-hackgen-nerd

# $(dot_nvim): config_dir  $(ROOT_DIR)/dot.config/nvim
# 	ln -sf $(ROOT_DIR)/dot.config/nvim $${HOME}/.config/


