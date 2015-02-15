: ${omg_ungit_prompt:=$PS1}
: ${omg_is_a_git_repo_symbol:=''}
: ${omg_has_untracked_files_symbol:=''} #          ?  
: ${omg_has_adds_symbol:=''}
: ${omg_has_deletions_symbol:=''}
: ${omg_has_cached_deletions_symbol:=''}
: ${omg_has_modifications_symbol:=''}
: ${omg_has_cached_modifications_symbol:=''}
: ${omg_ready_to_commit_symbol:=''} #  →
: ${omg_is_on_a_tag_symbol:=''} #  
: ${omg_needs_to_merge_symbol:='ᄉ'}
: ${omg_detached_symbol:=''}
: ${omg_can_fast_forward_symbol:=''}
: ${omg_has_diverged_symbol:=''} #  
: ${omg_not_tracked_branch_symbol:=''}
: ${omg_rebase_tracking_branch_symbol:=''} #  
: ${omg_merge_tracking_branch_symbol:=''} # 
: ${omg_should_push_symbol:=''} #  
: ${omg_has_stashes_symbol:=''}
: ${omg_has_action_in_progress_symbol:=''} #         
autoload -U colors && colors



for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
eval $COLOR='%{$fg_no_bold[${(L)COLOR}]%}' #wrap colours between %{ %} to avoid weird gaps in autocomplete
eval BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
eval RESET='%{$reset_color%}'


on=$WHITE
off=$WHITE
red=$RED
green=$GREEN
yellow=$YELLOW
violet=$CYAN
branch_color=$BLUE
black=$BLACK
reset=$RESET


if [[ $EUID -ne 0 ]]; then
  # no root
PROMPT='
$(build_prompt)
%{$fg_no_bold[blue]%}%~
%{$fg[cyan]%}❯ $ '
RPROMPT='%{$reset_color%} ⌚ %T %{$fg_no_bold[black]%}|%n @ %m|%{$reset_color%}'
else
  # root
PROMPT='
$(build_prompt)
%{$fg_no_bold[blue]%}%~
%{$fg_bold[red]%}❯ # '
RPROMPT='%{$reset_color%} ⌚ %T %{$fg_no_bold[red]%}|%n @ %m|%{$reset_color%}'
fi


#ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}- on %{$fg_bold[magenta]%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%} branch %{$fg_bold[green]%}✔"
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%} branch %{$fg_bold[yellow]%}✗"
