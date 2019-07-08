set -U fish_user_paths

set -g -x PATH /usr/local/bin $PATH
# set -g -x ANDROID_HOME $HOME/Library/Android/sdk
# set -g -x PATH $PATH $ANDROID_HOME/tools
# set -g -x PATH $PATH $ANDROID_HOME/platform-tools

set -U EDITOR nvim

set -g -x PATH $HOME/Applications $PATH

set -g -x PATH /usr/local/opt/mysql@5.7/bin $PATH

set -g -x PATH $PATH $HOME/.composer/vendor/bin

set -g fish_user_paths "/usr/local/bin" $fish_user_paths

set -g -x PATH $PATH $HOME/.deno/bin

source (pyenv init -|psub)
source (rbenv init -|psub)

set fish_greeting ""

source ~/.fish_aliases
source ~/.fish_variables

# set -g fish_user_paths "/usr/local/opt/llvm@6/bin" $fish_user_paths
# set -gx LDFLAGS "-L/usr/local/opt/llvm@6/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/llvm@6/include"

fnm env --use-on-cd | source

# fnm
set PATH $HOME/.fnm $PATH
fnm env --multi | source

# golang
set -x -U GOPATH $HOME/go
set -g -x PATH $PATH $GOPATH/bin

set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths

direnv hook fish | source

# kitty + complete setup fish | source

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

