[init]
	defaultBranch = master
[user]
	name = jgvanwyk
	email = __GIT_EMAIL
[pull]
	ff = only
[color]
	ui = auto
[color "decorate"]
	HEAD = 4 normal bold
	remotebranch = 2 normal
	grafted = 1 normal italic
	tag = 11 normal
	stash = 8 normal
	branch = 5 normal bold
[color "diff"]
	whitespace = normal
	commit = normal bold
    meta = normal bold
	func = 1 normal italic
    frag = 4 normal bold
[color "grep"]
	filename = 7 normal
	function = 1 normal
	column = 8 normal
	linenumber = 8 normal
[color "interactive"]
	header = normal
	help = 8 normal
	error = 1 normal italic
[color "status"]
	changed = 3 normal
	unmerged = 1 normal
	nobranch = 1 normal italic
	updated = 2 normal
	localbranch = 5 normal
	added = 2 normal
	untracked = normal dim
	header = normal
	remotebranch = 2 normal
	branch = 5 normal
[color "branch"]
	remote = 2 normal
	upstream = 2 normal
	plain = 5 normal
	current = 5 normal reverse
	local = 5 normal
[color "remote"]
	success = 2 normal
	error = 1 normal
	hint = normal dim
	warning = 3 normal
[filter "lfs"]
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
	required = true
[core]
	pager = less
	excludesfile = ~/.gitignore_global
ifelse(__OS, fedora,
[credentials]
	helper = libsecret
)dnl
