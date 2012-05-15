# bash completion for openstack glance
# by Dominik Heidler <dheidler suse.de>

_glance_opts="" # lazy init
_glance_opts_exp="" # lazy init
_glance()
{
	local cur prev
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"

	if [ "x$_glance_opts" == "x" ] ; then
		_glance_opts="`glance bash-completion 2>/dev/null | sed -e '/^\s\s\s\s\w/!d' -e "s/\s*\([a-z0-9_-]*\)\s.*/\1/"`"
		_glance_opts_exp="`echo $_glance_opts | sed -e "s/\s/|/g"`"
	fi

	if [[ ! " ${COMP_WORDS[@]} " =~ " "($_glance_opts_exp)" " || "$prev" == "help" ]] ; then
		COMPREPLY=($(compgen -W "${_glance_opts}" -- ${cur}))
	fi
	return 0
}
complete -F _glance glance
