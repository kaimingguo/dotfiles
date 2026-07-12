#!/bin/csh -f
# -*- mode: csh; tab-width: 8; indent-tabs-mode: t -*- ;; Emacs
# vi: set filetype=csh tabstop=8 shiftwidth=8 noexpandtab :: Vi/ViM

onintr -
if (! $?prompt ) goto end

if (! $?MANPATH ) then
	if ( -r /usr/share/man ) then
		if ( -r /usr/local/share/man ) then
			setenv MANPATH /usr/local/share/man:/usr/share/man
		else
			setenv MANPATH /usr/share/man
		endif
	endif
endif

# MacPorts
if ( -r /opt/local/share/man ) then
	if (! $?MANPATH ) then
		setenv MANPATH /opt/local/share/man:$MANPATH
	else
		setenv MANPATH /opt/local/share/man
	endif
endif

if ( $uid == 0 ) then
	setenv LESSHISTFILE -
	setenv VIMINIT 	':set viminfo='
endif

# ripgrep
if ( -r "$home/.config/ripgrep/config" ) then
	setenv RIPGREP_CONFIG_PATH "$home/.config/ripgrep/config"
endif

end:
    onintr
