#!/bin/csh -f
# -*- coding:utf-8;mode:csh -*- vim:ts=8:sts=8:sw=8:noet:ft=csh:

onintr -
if (! $?prompt ) goto end

setenv EDITOR 	vi
setenv VISUAL 	${EDITOR}
setenv PAGER 	less
setenv BLOCKSIZE 	M

if ( ! $?MANPATH ) then
	if ( -r /usr/share/man ) then
		if ( -r /usr/local/share/man ) then
			setenv MANPATH /usr/local/share/man:/usr/share/man
		else
			setenv MANPATH /usr/share/man
		endif
	endif
endif
if ( -r /opt/local/share/man ) then
	if ( ! $?MANPATH ) then
		setenv MANPATH /opt/local/share/man:$MANPATH
	else
		setenv MANPATH /opt/local/share/man
	endif
endif

if ( $uid == 0 ) then
	setenv LESSHISTFILE 	-
	setenv VIMINIT 	':set viminfo='
endif


end:
	onintr

# vim: set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab textwidth=78 :
# vim: set fileencoding=utf-8 filetype=csh nofoldenable :
