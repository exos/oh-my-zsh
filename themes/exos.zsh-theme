autoload -U add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' actionformats \
  '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '

zstyle ':vcs_info:*' formats '%b'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git

add-zsh-hook precmd detect_pdir
add-zsh-hook precmd prompt_vcs
add-zsh-hook precmd prompt_virtualenv
add-zsh-hook precmd prompt_projectname 

EXOS_RIGHT_PATH_COLOR="236"
EXOS_BRANCH_COLOR="012"
EXOS_BRANCH_MASTER_COLOR="160"
EXOS_PROJECT_COLOR="166"
EXOS_DIVIDER_COLOR="178"
EXOS_HOST_COLOR="057"

presentation () {
    toilet -f future -F metal "$HOST $(date +%H:%m:%S)" 2> /dev/null && {
        w 
    } || {
        echo "This theme requires toilet command, please install" 
    }
}

detect_pdir () {
    pdir=$(git rev-parse --show-toplevel 2> /dev/null )
}

prompt_vcs () {
    vcs_info

    if [ "${vcs_info_msg_0_}" = "" ]; then
        dir_status=""
    elif [[ $(git diff --cached --name-status 2>/dev/null ) != "" ]]; then
        dir_status="%F{1}⬆%f"
    elif [[ $(git diff --name-status 2>/dev/null ) != "" ]]; then
        dir_status="%F{3}⬆%f"
    else
        dir_status="%F{2}✓%f"
    fi

    if [ "${vcs_info_msg_0_}" = ""  ]; then
        cbranch=""
    else
        if [ "${vcs_info_msg_0_}" = "master" ]; then 
            cbranch="%{[05m%}%F{$EXOS_BRANCH_MASTER_COLOR}⭠${vcs_info_msg_0_}%{$reset_color%}"
        else 
            cbranch="%F{$EXOS_BRANCH_COLOR}⭠${vcs_info_msg_0_}%f"
        fi
    fi

}

prompt_virtualenv () {
    if [[ -n $VIRTUAL_ENV ]]; then
        ve_status="%F{2} ⌬%f "
    elif [[ -n $pdir ]]; then
        if [[ -d $pdir/virtualenv || -d $pdir/.virtualenv || -f $pdir/requirements.txt ]]; then
            ve_status="%F{1} ⌬%f "
        else
            ve_status=""
        fi
    fi
}

prompt_projectname () {

    pname=" ${cbranch}${dir_status}${ve_status}" 

    if [[ -n $pdir ]]; then

        if [[ -f $pdir/package.json ]]; then
            ppname=$(python2 -c "import json;print json.loads(open('$pdir/package.json', 'r').read())['name']" 2> /dev/null)
        elif [[ -f $pdir/bower.json ]]; then
            ppname=$(python2 -c "import json;print json.loads(open('$pdir/bower.json', 'r').read())['name']" 2> /dev/null)
        else
            ppname=$(basename $pdir)
        fi

        if [[ -n $ppname ]]; then 
            pname=" %F{$EXOS_DIVIDER_COLOR}⁅%f ${ve_status}%F{$EXOS_PROJECT_COLOR}${ppname}%f ${cbranch} ${dir_status} %F{$EXOS_DIVIDER_COLOR}⁆%f"
        fi
    fi

}

function {
    if [[ -n "$SSH_CLIENT" ]]; then
        PROMPT_HOST="%F{$EXOS_HOST_COLOR} $HOST ➲ %f"
    else
        PROMPT_HOST=''
    fi
}

local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})➜"

PROMPT='${ret_status}%{$fg[blue]%}${PROMPT_HOST}${pname}%{$fg_bold[green]%}%p %{$fg_bold[yellow]%}%2~ ▶%{$reset_color%} '
RPROMPT='%F{$EXOS_RIGHT_PATH_COLOR}$(pwd)%f%(?: :%{$fg_bold[red]%} %? %{$reset_color%} )%F{yellow}[%*]%f'

presentation

#  vim: set ft=zsh ts=4 sw=4 et:
