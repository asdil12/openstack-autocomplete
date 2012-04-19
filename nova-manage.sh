_nova_manage_opts="" # lazy init
_nova_manage_opts_exp="" # lazy init
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
		subopts="`nova-manage $prev bash-completion 2>/dev/null | sed -e "1d"`"
		COMPREPLY=($(compgen -W "${subopts}" -- ${cur}))  
	elif [[ ! " ${COMP_WORDS[@]} " =~ " "($_nova_manage_opts_exp)" " ]] ; then
		COMPREPLY=($(compgen -W "${_nova_manage_opts}" -- ${cur}))  
	fi
	return 0
}
complete -F _nova_manage nova-manage
