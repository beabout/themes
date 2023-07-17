# git clone https://github.com/beabout/themes.git
# cd themes
# ln -s "$(pwd)/clay.zsh-theme" ~/.oh-my-zsh/themes/clay.zsh-theme
# omz theme use clay

# mimicked ~/.oh-my-zsh/lib/git.zsh:git_prompt_info()
function custom_git_info() {
  # exit if we aren't in a git repository
  if ! __git_prompt_git rev-parse --git-dir &> /dev/null \
     || [[ "$(__git_prompt_git config --get oh-my-zsh.hide-info 2>/dev/null)" == 1 ]]; then
    return 0
  fi

  echo "$(git_current_branch) "
}

precmd() {
  # prepend PROMPT with git info
  psvar[1]=$(custom_git_info);
}

PROMPT="%{$fg_bold[green]%}%1v-%{$reset_color%} "

