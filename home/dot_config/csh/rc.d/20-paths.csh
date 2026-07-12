#!/bin/csh -f
# -*- mode: csh; tab-width: 8; indent-tabs-mode: t -*- ;; Emacs
# vi: set filetype=csh tabstop=8 shiftwidth=8 noexpandtab :: Vi/ViM

if ( $?ANDROID_HOME ) then
	if ( $?ANDROID_NDK ) then
		if ( -d "$ANDROID_NDK" && "$path" !~ *"$ANDROID_NDK"* ) then
			set path = ( $path $ANDROID_NDK )
		endif
	endif

	foreach _bin ( cmdline-tools/latest/bin platform-tools tools tools/bin )
		if ( -d "$ANDROID_HOME/${_bin}" && "$path" !~ *"$ANDROID_HOME/${_bin}"* ) then
			set path = ( $path "$ANDROID_HOME/${_bin}" )
		endif
	end
	unset _bin
endif

if ( $?JAVA_HOME ) then
	if ( -d "$JAVA_HOME/bin" && "$path" !~ *"$JAVA_HOME/bin"* ) then
		set path = ( $JAVA_HOME/bin $path )
	endif
endif

if ( $?FLUTTER_HOME ) then
	if ( -d "$FLUTTER_HOME/bin" && "$path" !~ *"$FLUTTER_HOME/bin"* ) then
		set path = ( $FLUTTER_HOME/bin $path )
	endif
endif

if ( $?DOTNET_ROOT ) then
	if ( -d "$DOTNET_ROOT" && "$path" !~ *"$DOTNET_ROOT"* ) then
		set path = ( $DOTNET_ROOT $path )
	endif
endif

if ( -e `where go` ) then
	set _go_bin = ( `go env GOPATH`/bin )
	if ( ! -d "${_go_bin}" ) mkdir -p ${_go_bin}
	if ( "$path" !~ *"${_go_bin}"* ) set path = ( ${_go_bin} $path )
	unset _go_bin
endif

if ( -e `where python` ) then
	set _base_bin = "`python -m site --user-base`/bin"
	if ( -d "${_base_bin}" && "$path" !~ *"${_base_bin}"* ) then
		set path = ( ${_base_bin} $path )
	endif
	unset _base_bin
endif

foreach _tool_bin ( $home/.jbang/bin $home/.yarn/bin $home/.cargo/bin $home/.pub-cache/bin )
	if ( -d "${_tool_bin}" && "$path" !~ *"${_tool_bin}"* ) then
		set path = ( ${_tool_bin} $path )
	endif
end
unset _tool_bin

if ( -e "$home/.cargo/env.tcsh" ) then
	source "$home/.cargo/env.tcsh"
endif

# User private bins last so they take precedence (prepended).
if ( -d "$home/bin" && "$path" !~ *"$home/bin"* ) then
	set path = ( $home/bin $path )
endif

if ( -d "$home/.local/bin" && "$path" !~ *"$home/.local/bin"* ) then
	set path = ( $home/.local/bin $path )
endif
