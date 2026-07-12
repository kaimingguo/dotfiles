#!/bin/csh -f
# -*- mode: csh; tab-width: 8; indent-tabs-mode: t -*- ;; Emacs
# vi: set filetype=csh tabstop=8 shiftwidth=8 noexpandtab :: Vi/ViM

onintr -
if (! $?prompt ) goto end

# Starship prompt (overrides the basic prompt above when present).
if ( -e `where starship` ) then
	eval `starship init tcsh --print-full-init`
endif

end:
	onintr
