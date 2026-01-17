bindkey -e
setopt CHASE_LINKS

# UTILITIES
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
ifelse(__OS, macos,
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=1,
__OS, fedora,
export QUOTING_STYLE=literal
)dnl
alias grep="grep --colour"
ifelse(__OS, fedora,
alias open=xdg-open
)dnl

# COMPLETION
setopt GLOB_COMPLETE
zstyle ":completion:*" menu select
zstyle ":completion:*" list-colors "$LS_COLORS"
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zmodload zsh/complist
autoload -U compinit
compinit

# PROMPT
autoload -U vcs_info
zstyle ":vcs_info:*" formats "%s:%b"
zstyle ":vcs_info:*" actionformats "%s:%b"
function precmd {
    vcs_info
    psvar[1]="$vcs_info_msg_0_"
ifelse(__OS, macos,
    psvar[2]="$(scutil --get LocalHostName)"
)dnl
    printf "\e[5 q" # Set cursor to pipe
}
autoload -U add-zsh-hook
add-zsh-hook precmd precmd
`PS1="%B%n%b@%B'ifelse(__OS, macos, %2v, __OS, fedora, %m)%b %F{4}%1~%f%1(V. %F{5}%1v%f.)%1(j. %F{3}%j%f.)%(?.. %B%F{1}%?%f%b) %# "

# PLUGINS
. ifelse(__OS, macos,
    /opt/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh,
    __OS, fedora,
    /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh)
