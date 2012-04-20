# bash completion for openstack keystone
# by Dominik Heidler <dheidler suse.de>

_keystone_opts="" # lazy init
_keystone_opts_exp="" # lazy init
_keystone()
{
	local cur prev
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"

	if [ "x$_keystone_opts" == "x" ] ; then
		_keystone_opts="`keystone bash-completion 2>&1 | tail -n1 | sed -e "s/^.*(choose from //" -e "s/)$//" -e "s/,//g" -e "s/'//g"`"
		_keystone_opts_exp="`echo $_keystone_opts | sed -e "s/\s/|/g"`"
	fi

	if [[ ! " ${COMP_WORDS[@]} " =~ " "($_keystone_opts_exp)" " || "$prev" == "help" ]] ; then
		COMPREPLY=($(compgen -W "${_keystone_opts}" -- ${cur}))
	fi
	return 0
}
complete -F _keystone keystone
