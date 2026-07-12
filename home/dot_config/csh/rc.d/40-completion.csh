#!/bin/csh -f
# -*- mode: csh; tab-width: 8; indent-tabs-mode: t -*- ;; Emacs
# vi: set filetype=csh tabstop=8 shiftwidth=8 noexpandtab :: Vi/ViM

onintr -
if (! $?prompt ) goto end
if (! $?tcsh ) goto end

uncomplete *

if (! $?hosts ) then
	set hosts = ()
	foreach _host ( $home/.hosts $home/.rhosts $home/.ssh/known_hosts )
		if ( -r "${_host}" ) then
			set hosts = ( $hosts `awk -F'[ ,:]' '/^[0-9a-zA-Z]/{sub(/\]/,"",$1); print $1}' "${_host}"` )
		endif
	end
	unset _host
endif
set hosts = ( `echo $hosts | tr ' ' '\012' | sort -u` )

if ( $?tcsh ) set _complete = 1
if ( $?_complete ) then
	set noglob

	complete {cd,pushd} 	'p/1/d/'
	complete cc 		'p/*/f:*.[cao]/'
	complete alias 		'p/1/a/'
	complete man 		'p/*/c/'
	complete set 		'p/1/s/'

	unset noglob
	unset _complete
endif

end:
	onintr
