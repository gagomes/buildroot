.PHONY: default
default: rpms
DIST=.el6
# FETCH_EXTRA_ARGS=--no-package-name-check
# DEPEND_EXTRA_ARGS=--no-package-name-check
# Start generated by planex-init
include /usr/share/planex/Makefile.rules
# End generated by planex-init

install: all
	scripts/install.sh
