#!/bin/csh -f
# -*- coding:utf-8;mode:csh -*- vim:ts=8:sts=8:sw=8:noet:ft=csh:

onintr -
if (! $?prompt ) goto end

if (! $?hosts ) then
	set hosts = ()
	foreach _f ( $home/.hosts $home/.rhosts $home/.ssh/known_hosts )
		if ( -r "${_f}" ) then
			set hosts = ( $hosts `awk -F'[ ,:]' '/^[0-9a-zA-Z]/{sub(/\]/,"",$1); print $1}' "${_f}"` )
		endif
	end
	unset _f
endif
set hosts = ( `echo $hosts | tr ' ' '\012' | sort -u` )

if ( $?tcsh ) set _complete = 1
if ( $?_complete ) then
	set noglob

	complete {cd,pushd} 	'p/1/d/'

	complete cc 	'p/*/f:*.[cao]/'
	complete alias 	'p/1/a/'
	complete man 	'p/*/c/'
	complete set 	'p/1/s/'

	complete finger	'c/*@/$hosts/' 'p/1/u/@'

	complete git \
		'p/1/(branch commit config push push status)/'

	unset noglob
	unset _complete
endif

end:
	onintr

# vim: set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab textwidth=78 :
# vim: set fileencoding=utf-8 filetype=csh nofoldenable :
