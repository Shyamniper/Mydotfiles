# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
alias r='radian'
export FZF_COMPLETION_TRIGGER='~~'
# Path to your oh-my-zsh installation.
export ZSH="/home/pi/.oh-my-zsh"
		ZSH_THEME="fishy"

setopt HIST_FIND_NO_DUPS
setopt inc_append_history
setopt share_history

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line if pasting URLs and other text is messed up.
	# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
	COMPLETION_WAITING_DOTS="true"

# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-completions git bundler dotenv osx rake rbenv ruby zsh-autosuggestions extract fzf)
source $ZSH/oh-my-zsh.sh
autoload -U compinit && compinit

source ~/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundle pip
antigen bundle lein
antigen bundle chrissicool/zsh-256color
antigen bundle command-not-found
antigen bundle desyncr/auto-ls
# Tell Antigen that you're done.
antigen apply

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

#set fzf installation directory path
export FZF_BASE=/path/to/fzf/install/dir

# Uncomment the following line to disable fuzzy completion
# export DISABLE_FZF_AUTO_COMPLETION="true"

# Uncomment the following line to disable key bindings (CTRL-T, CTRL-R, ALT-C)
#export DISABLE_FZF_KEY_BINDINGS="true"

source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export LD_LIBRARY_PATH=/opt/gcc-9.1.0/lib:$LD_LIBRARY_PATH
export PATH=/opt/gcc-9.1.0/bin:$PATH
