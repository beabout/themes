# git clone https://github.com/beabout/themes.git
# cd themes
# ln -s "$(pwd)/clay.zsh-theme" ~/.oh-my-zsh/themes/clay.zsh-theme
# omz theme use clay

# Color options (ANSI 8): red, blue, magenta, green, yellow, black, cyan, white
_GIT_COLOR=green
_DASH_COLOR=blue
_ERROR_COLOR=red
# Show git branch if in a Git repo
function custom_git_info() {
  if ! __git_prompt_git rev-parse --git-dir &> /dev/null \
     || [[ "$(__git_prompt_git config --get oh-my-zsh.hide-info 2>/dev/null)" == 1 ]]; then
    echo ""
    return
  fi
  echo "%{$fg_bold[$_GIT_COLOR]%}$(git_current_branch)%{$reset_color%}"
}

# Main prompt: just a dash, nothing more
PROMPT="%{$fg_bold[$_DASH_COLOR]%}-%{$reset_color%} "

# Git info to be shown in the next prompt only (after cd)
_next_git_rprompt=""

# Called only when the directory changes
function on_directory_change() {
  _next_git_rprompt="%1v $(custom_git_info)"
}

# Called before every prompt (but after chpwd if cd was used)
function update_rprompt() {
  local status_="$?"

  RPROMPT=""
  if [[ $status_ -ne 0 ]]; then
    RPROMPT+="%{$fg[$_ERROR_COLOR]%}$status_ ↵%{$reset_color%} "
  fi

  # Add Git info only if we just changed directories
  if [[ -n "$_next_git_rprompt" ]]; then
    RPROMPT+="${_next_git_rprompt}"
    _next_git_rprompt=""  # clear it after showing once
  fi
}

# Hook them in
autoload -Uz add-zsh-hook
add-zsh-hook chpwd on_directory_change
add-zsh-hook precmd update_rprompt

# Initialize once at shell start
on_directory_change
