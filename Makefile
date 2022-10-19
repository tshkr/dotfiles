
ROOT_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

TMP_DIR = $(HOME)/tmp
INSTALL_DIR = $(HOME)/opt

# Targets
DOT_CONFIG = ${HOME}/.config
TMUX_TPM = ${HOME}/dotfiles/dots/tmux/plugins/tpm
NVIM = ${HOME}/.config/nvim

NEOVIM_VER = v0.8.0
NEOVIM_BIN = $(INSTALL_DIR)/bin/nvim
NEOVIM_GIT = $(TMP_DIR)/neovim

TMUX_VER = 3.3a
TMUX_BIN = $(INSTALL_DIR)/bin/tmux
TMUX_GIT = $(TMP_DIR)/tmux

ZSH_VER = zsh-5.9
ZSH_BIN = $(INSTALL_DIR)/bin/zsh
ZSH_GIT = $(TMP_DIR)/zsh

SIXEL_BIN = $(INSTALL_DIR)/bin/img2sixel
SIXEL_GIT = $(TMP_DIR)/libsixel

MAGICK_VER = 7.1.0-50
MAGICK_BIN = $(INSTALL_DIR)/bin/magick
MAGICK_GIT = $(TMP_DIR)/ImageMagick

# Default target
# all: $(TMUX_TPM)
.PHONY: linux
# linux: $(NEOVIM_BIN) $(TMUX_BIN)
# linux:  $(ZSH_BIN)
# linux:  $(TMUX_EXT)
linux:  $(MAGICK_BIN)


config_git:
	git config --global pull.rebase true

$(TMP_DIR): 
	mkdir -p $@

$(DOT_CONFIG): ${HOME}/dotfiles/config
	mkdir -p $@
	ln -sf $< $@

$(TMUX_TPM):
	git clone https://github.com/tmux-plugins/tpm $@

$(NEOVIM_GIT): $(TMP_DIR)
	cd $< && git clone https://github.com/neovim/neovim.git

$(NEOVIM_BIN): $(NEOVIM_GIT)
	# cd $< && git pull origin master
	cd $< && git checkout refs/tags/$(NEOVIM_VER)
	cd $< && make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$(INSTALL_DIR)
	cd $< && make install

$(TMUX_GIT): $(TMP_DIR)
	cd $< && git clone https://github.com/tmux/tmux.git

$(TMUX_BIN): $(TMUX_GIT)
	# cd $< && git pull origin master
	cd $< && git checkout refs/tags/$(TMUX_VER)
	cd $< && sh autogen.sh
	cd $< && ./configure --prefix=$(INSTALL_DIR)
	cd $< && make install

# TMUX_EXT = ~/dotfiles/dot
# $(TMUX_EXT): $(TMUX_BIN)
# 	cd 
# 	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

$(ZSH_GIT): $(TMP_DIR)
	cd $< && git clone https://github.com/zsh-users/zsh.git

$(ZSH_BIN): $(ZSH_GIT)
	# cd $< && git pull origin master
	cd $< && git checkout refs/tags/$(ZSH_VER)
	cd $< && autoheader && autoconf
	cd $< && ./configure --prefix=$(INSTALL_DIR) --enable-multibyte --enable-locale
	cd $< && make && make install.bin install.fns
	#cd $< && make && make install.man install.info
	

$(SIXEL_GIT): $(TMP_DIR)
	cd $< && git clone https://github.com/saitoha/libsixel.git

$(SIXEL_BIN): $(SIXEL_GIT)
	# cd $< && git pull origin master
	cd $< && ./configure --prefix=$(INSTALL_DIR)
	cd $< && make install

$(MAGICK_GIT): $(TMP_DIR)
	cd $< && git clone https://github.com/ImageMagick/ImageMagick.git

$(MAGICK_BIN): $(MAGICK_GIT)
	# cd $< && git pull origin master
	cd $< && git checkout refs/tags/$(MAGICK_VER)
	cd $< && ./configure --prefix=$(INSTALL_DIR)
	cd $< && make install

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


