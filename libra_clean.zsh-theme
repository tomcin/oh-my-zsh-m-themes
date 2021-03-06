# Oh my git - Theme - Liino

if [[ $EUID -ne 0 ]]; then
  # no root
PROMPT='
$(build_prompt)
%{$fg_bold[green]%}• %{$fg_bold[yellow]%}• %{$fg_bold[red]%}• '
RPROMPT='%{$reset_color%} ⌚ %T %{$fg_no_bold[black]%}|%n @ %m|%{$reset_color%}'
else
  # root
PROMPT='
$(build_prompt)
%{$fg_bold[green]%}• %{$fg_bold[yellow]%}• %{$fg_bold[red]%}• %{$fg_bold[red]%} # '
RPROMPT='%{$reset_color%} ⌚ %T %{$fg_no_bold[red]%}|%n @ %m|%{$reset_color%}'
fi


# : ${omg_ungit_prompt:=$PS1}

: ${omg_is_a_git_repo_symbol:=''}
: ${omg_has_untracked_files_symbol:=''}        #                ?    
: ${omg_has_adds_symbol:=''}
: ${omg_has_deletions_symbol:=''}
: ${omg_has_cached_deletions_symbol:=''}
: ${omg_has_modifications_symbol:=''}
: ${omg_has_cached_modifications_symbol:=''}
: ${omg_ready_to_commit_symbol:=''}            #   →
: ${omg_is_on_a_tag_symbol:='⌫'}                #   
: ${omg_needs_to_merge_symbol:='ᄉ'}
: ${omg_detached_symbol:=''}
: ${omg_can_fast_forward_symbol:=''}
: ${omg_has_diverged_symbol:=''}               #   
: ${omg_not_tracked_branch_symbol:=''}
: ${omg_rebase_tracking_branch_symbol:=''}     #   
: ${omg_merge_tracking_branch_symbol:=''}      #  
: ${omg_should_push_symbol:=''}                #    
: ${omg_has_stashes_symbol:=''}
: ${omg_has_action_in_progress_symbol:=''}     #                  

autoload -U colors && colors


function enrich_append {
    local flag=$1
    local symbol=$2
    local color=${3:-$omg_default_color_on}
    if [[ $flag == false ]]; then symbol=' '; fi

    echo -n "${color}${symbol}  "
}

function custom_build_prompt {
    local enabled=${1}
    local current_commit_hash=${2}
    local is_a_git_repo=${3}
    local current_branch=$4
    local detached=${5}
    local just_init=${6}
    local has_upstream=${7}
    local has_modifications=${8}
    local has_modifications_cached=${9}
    local has_adds=${10}
    local has_deletions=${11}
    local has_deletions_cached=${12}
    local has_untracked_files=${13}
    local ready_to_commit=${14}
    local tag_at_current_commit=${15}
    local is_on_a_tag=${16}
    local has_upstream=${17}
    local commits_ahead=${18}
    local commits_behind=${19}
    local has_diverged=${20}
    local should_push=${21}
    local will_rebase=${22}
    local has_stashes=${23}
    local action=${24}

    local prompt=""
    local original_prompt=$PS1


    local black_on_white="%K{white}%F{black}"
    local yellow_on_white="%K{white}%F{yellow}"
    local red_on_white="%K{white}%F{red}"
    local red_on_black="%K{black}%F{red}"
    local black_on_red="%K{red}%F{black}"
    local white_on_red="%K{red}%F{white}"
    local yellow_on_red="%K{red}%F{yellow}"

    local red_on="%F{red}"
    local green_on="%F{green}"
    local yellow_on="%F{yellow}"
    local white_on="%F{white}"
    local black_on="%F{black}"
    local blue_on="%F{blue}"
    local cyan_on="%F{cyan}"


    # Flags
    local omg_default_color_on="${yellow_on}"

    local current_path="%~"

    if [[ $is_a_git_repo == true ]]; then
        # on filesystem
        prompt="${red_on} "
        prompt+=$(enrich_append $is_a_git_repo $omg_is_a_git_repo_symbol "${cyan_on}")

        prompt+=$(enrich_append $has_stashes $omg_has_stashes_symbol "${yellow_on}")

        prompt+=$(enrich_append $has_untracked_files $omg_has_untracked_files_symbol "${red_on}")
        prompt+=$(enrich_append $has_deletions $omg_has_deletions_symbol "${red_on}")
        prompt+=$(enrich_append $has_modifications $omg_has_modifications_symbol "${red_on}")


        prompt+="  "
        # ready
        prompt+=$(enrich_append $has_adds $omg_has_adds_symbol "${green_on}")
        prompt+=$(enrich_append $has_deletions_cached $omg_has_cached_deletions_symbol "${green_on}")
        prompt+=$(enrich_append $has_modifications_cached $omg_has_cached_modifications_symbol "${green_on}")

        # next operation

        prompt+=$(enrich_append $ready_to_commit $omg_ready_to_commit_symbol "${blue_on}")
        prompt+=$(enrich_append $action "${omg_has_action_in_progress_symbol} $action" "${blue_on}")

        # where

        prompt="${prompt} ${white_on}  ${red_on}"
        if [[ $detached == true ]]; then
            prompt+=$(enrich_append $detached $omg_detached_symbol "${yellow_on}")
            prompt+=$(enrich_append $detached "(${current_commit_hash:0:7})" "${red_on}")
        else
            if [[ $has_upstream == false ]]; then
                prompt+=$(enrich_append true "-- ${omg_not_tracked_branch_symbol}  --  (${current_branch})" "${red_on}")
            else
                if [[ $will_rebase == true ]]; then
                    local type_of_upstream=$omg_rebase_tracking_branch_symbol
                else
                    local type_of_upstream=$omg_merge_tracking_branch_symbol
                fi

                if [[ $has_diverged == true ]]; then
                    prompt+=$(enrich_append true "-${commits_behind} ${omg_has_diverged_symbol} +${commits_ahead}" "${white_on}")
                else
                    if [[ $commits_behind -gt 0 ]]; then
                        prompt+=$(enrich_append true "-${commits_behind} %F{white}${omg_can_fast_forward_symbol}%F{white} --" "${red_on}")
                    fi
                    if [[ $commits_ahead -gt 0 ]]; then
                        prompt+=$(enrich_append true "-- %F{white}${omg_should_push_symbol}%F{white}  +${commits_ahead}" "${red_on}")
                    fi
                    if [[ $commits_ahead == 0 && $commits_behind == 0 ]]; then
                         prompt+=$(enrich_append true " --   -- " "${black_on}")
                    fi

                fi
                prompt+=$(enrich_append true "(${current_branch} ${type_of_upstream} ${upstream//\/$current_branch/})" "${red_on}")
            fi
        fi
        prompt+=$(enrich_append ${is_on_a_tag} "${omg_is_on_a_tag_symbol} ${tag_at_current_commit}" "${red_on}")
        prompt+="%k%F{red} %k%f"
    # else
    #     prompt="${omg_ungit_prompt}"
    fi

    echo "${prompt}"
}
