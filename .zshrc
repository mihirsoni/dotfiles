DEFAULT_USER=`whoami`

#Add extra file
source ~/dotfiles/.extras
source ~/dotfiles/.aliases


# history
SAVEHIST=100000

# vim bindings
bindkey -v


# antigen time!
source ~/antigen.zsh

######################################################################
### install some antigen bundles

#Try to get rid of this

antigen use oh-my-zsh

local b="antigen-bundle"

# Guess what to install when running an unknown command.
$b command-not-found

# Helper for extracting different types of archives.
$b extract

# homebrew  - autocomplete on `brew install`
$b brew
$b brew-cask

# install oh-my-zsh plugins
$b robbyrussell/oh-my-zsh plugins/z
$b robbyrussell/oh-my-zsh plugins/git
$b robbyrussell/oh-my-zsh plugins/sudo
$b robbyrussell/oh-my-zsh plugins/common-aliases



# nicoulaj's moar completion files for zsh -- not sure why disabled.
# $b zsh-users/zsh-completions src

# Syntax highlighting on the readline
$b zsh-users/zsh-syntax-highlighting

# history search
$b zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh

# suggestions
$b zsh-users/zsh-autosuggestions

# colors for all files!
$b trapd00r/zsh-syntax-highlighting-filetypes

# dont set a theme, because pure does it all
$b mafredri/zsh-async

antigen theme agnoster

export PS2="⚡ "

# Tell antigen that you're done.
antigen apply

###
#################################################################################################


# bind UP and DOWN arrow keys for history search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

export PURE_GIT_UNTRACKED_DIRTY=0

# Automatically list directory contents on `cd`.
auto-ls () {
  emulate -L zsh;
  # explicit sexy ls'ing as aliases arent honored in here.
  hash gls >/dev/null 2>&1 && CLICOLOR_FORCE=1 gls -aFh --color --group-directories-first || ls
}
chpwd_functions=( auto-ls $chpwd_functions )


# history mgmt
# http://www.refining-linux.org/archives/49/ZSH-Gem-15-Shared-history/
setopt inc_append_history
setopt share_history


zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
