# Setup fzf
# ---------
if [[ ! "$PATH" == */home/wbollock/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/wbollock/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/wbollock/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/wbollock/.fzf/shell/key-bindings.zsh"
