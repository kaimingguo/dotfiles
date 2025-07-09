#!/bin/csh -f
# -*- coding:utf-8;mode:csh -*- vim:ts=8:sts=8:sw=8:noet:ft=csh:

onintr -
if (! $?prompt ) goto end

alias h		'history \!* 25'
alias j		jobs -l
alias ls	ls --color
alias ll	ls -lAF
alias md	mkdir
alias rd	rmdir
alias cd	pushd

if ( -e `where vim` ) then
	alias vi	vim
endif

alias today	'date -u "+%Y-%m-%d %H:%M:%S"'
alias x		exit
alias .		pwd
alias ..	cd ..
alias ../	cd ../
alias ...	cd ../..
alias .../	cd ../../
alias \~	cd ~
alias -		cd -
alias /		cd /

alias tmux	'env TERM=screen-256color-bce tmux'
alias xcode	'open -a "/Applications/Xcode.app"'
alias safari	'open -a safari'
alias brave	'open -a "Brave Browser"'

# Pin to the tail of long commands for an audible alert after long processes
## curl http://downloads.com/hugefile.zip; lmk
alias lmk	'say "Process complete."'

end:
	onintr

# vim: set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab textwidth=78 :
# vim: set fileencoding=utf-8 filetype=csh nofoldenable :
