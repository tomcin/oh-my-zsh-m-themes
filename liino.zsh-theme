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
