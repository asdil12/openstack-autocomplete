# bash completion for openstack nova-manage
# by Dominik Heidler <dheidler suse.de>

_nova_manage_opts="" # lazy init
_nova_manage_opts_exp="" # lazy init

# this will only work with bash 4
## declare dict
#declare -A _nova_manage_subopts

# dict hack for bash 3
# ...yea yea and eval is evil and you
# could use it to inject malicious
# code to .....yourself?
# bash 3 sucks...

_set_nova_manage_subopts () {
  eval _nova_manage_subopts_"$1"='$2'
}

_get_nova_manage_subopts () {
  eval echo '${_nova_manage_subopts_'"$1"'#_nova_manage_subopts_}'
}

_nova_manage()
{
	local cur prev subopts
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"

	if [ "x$_nova_manage_opts" == "x" ] ; then
		_nova_manage_opts="`nova-manage bash-completion 2>/dev/null | sed -e "1d" -e "s/^\s*//g"`"
		_nova_manage_opts_exp="`echo $_nova_manage_opts | sed -e "s/\s/|/g"`"
	fi

	if [[ " `echo $_nova_manage_opts` " =~ " $prev " ]] ; then
		#if [ "x${_nova_manage_subopts["$prev"]}" == "x" ] ; then
		if [ "x$(_get_nova_manage_subopts "$prev")" == "x" ] ; then
			subopts="`nova-manage $prev bash-completion 2>/dev/null | sed -e "1d"`"
			#_nova_manage_subopts+=( ["$prev"]="$subopts" )
			_set_nova_manage_subopts "$prev" "$subopts"
		fi
		#COMPREPLY=($(compgen -W "${_nova_manage_subopts["$prev"]}" -- ${cur}))
		COMPREPLY=($(compgen -W "$(_get_nova_manage_subopts "$prev")" -- ${cur}))
	elif [[ ! " ${COMP_WORDS[@]} " =~ " "($_nova_manage_opts_exp)" " ]] ; then
		COMPREPLY=($(compgen -W "${_nova_manage_opts}" -- ${cur}))  
	fi
	return 0
}
complete -F _nova_manage nova-manage
