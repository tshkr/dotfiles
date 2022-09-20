ROOT_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

all: $(dot_nvim)

config_dir = ${HOME}/.config
$(config_dir):
	mkdir $@


# dot_nvim = ${HOME}/.config/nvim
# $(dot_nvim): config_dir  $(ROOT_DIR)/dot.config/nvim
# 	ln -sf $(ROOT_DIR)/dot.config/nvim $${HOME}/.config/


