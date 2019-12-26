set -U fish_user_paths

set -g -x PATH /usr/local/bin $PATH
# set -g -x ANDROID_HOME $HOME/Library/Android/sdk
# set -g -x PATH $PATH $ANDROID_HOME/tools
# set -g -x PATH $PATH $ANDROID_HOME/platform-tools

set -Ux EDITOR nvim

set -g -x PATH $HOME/Applications $PATH

 set -g -x PATH /usr/local/opt/mysql@5.7/bin $PATH

# set -g -x PATH $PATH $HOME/.composer/vendor/bin

# set -g -x PATH $PATH $HOME/development/flutter/bin

# set -g -x PATH $PATH $HOME/.cargo/bin

set -g fish_user_paths "/usr/local/bin" $fish_user_paths

set -x -U DENO_INSTALL $HOME/.local
set -g -x PATH $PATH $DENO_INSTALL/bin

source (pyenv init -|psub)
source (rbenv init -|psub)

set fish_greeting ""

source ~/.fish_aliases
source ~/.fish_variables

# set -g fish_user_paths "/usr/local/opt/llvm@6/bin" $fish_user_paths
# set -gx LDFLAGS "-L/usr/local/opt/llvm@6/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/llvm@6/include"

# golang
set -x -U GOPATH $HOME/go
set -x -U GOBIN $GOPATH/bin
set -g -x PATH $PATH $GOBIN
# set -x -U JAVA_HOME "/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"

set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths

direnv hook fish | source

set PATH $HOME/.fnm $PATH
fnm env --multi | source

fish_vi_key_bindings insert

