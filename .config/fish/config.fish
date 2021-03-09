set -U fish_user_paths

set -g -x PATH /usr/local/bin $PATH
set -g -x ANDROID_HOME $HOME/Library/Android/sdk
set -g -x PATH $PATH $ANDROID_HOME/emulator
set -g -x PATH $PATH $ANDROID_HOME/tools
set -g -x PATH $PATH $ANDROID_HOME/tools/bin
set -g -x PATH $PATH $ANDROID_HOME/platform-tools
set -g -x PATH $PATH $HOME/.emacs.d/bin
set -g -x PATH $PATH $HOME/bin
set -g -x PATH $PATH /usr/local/opt/gnu-sed/libexec/gnubin
set -g -x PATH $PATH /Applications/Racket/bin

set -Ux EDITOR nvim

set -g -x PATH $HOME/Applications $PATH

set -g -x PATH /usr/local/opt/mysql@5.7/bin $PATH

# set -g -x PATH $PATH $HOME/development/flutter/bin

set -g -x PATH $PATH $HOME/.cargo/bin
set -g -x PATH $PATH $HOME/.composer/vendor/bin

set -g fish_user_paths "/usr/local/bin" $fish_user_paths

set -x -U DENO_INSTALL $HOME/.local
set -g -x PATH $PATH $DENO_INSTALL/bin

source (pyenv init -|psub) 
status --is-interactive; and source (rbenv init -|psub)

set fish_greeting ""

source ~/.fish_aliases
source ~/.fish_variables

# set -g fish_user_paths "/usr/local/opt/llvm@6/bin" $fish_user_paths
# set -gx LDFLAGS "-L/usr/local/opt/llvm@6/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/llvm@6/include"


# golang
set -x -g GOPATH $HOME/go
set -x -U GOBIN $GOPATH/bin
set -x -U GOPRIVATE "github.com/OkadocTech/*"
set -x -U DEPCACHEDIR $GOPATH/pkg/dep
set -g -x PATH $PATH $GOBIN
set -x -U CHEAT_CONFIG_PATH $HOME/.dotfiles/cheat/conf.yml
# set -x -U JAVA_HOME "/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"

set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths

set -g fish_user_paths "/usr/local/opt/coreutils/libexec/gnubin" $fish_user_paths

# fish_vi_key_bindings insert

# --httptoolkit--
# This section will be reset each time a HTTP Toolkit terminal is opened
if [ -n "$HTTP_TOOLKIT_ACTIVE" ]
    # When HTTP Toolkit is active, we inject various overrides into PATH
    set -x PATH "/Applications/HTTP Toolkit.app/Contents/Resources/app/httptoolkit-server/overrides/path" $PATH;

    if command -v winpty >/dev/null 2>&1
        # Work around for winpty's hijacking of certain commands
        alias php=php
        alias node=node
    end
end
# --httptoolkit-end--

set -gx LDFLAGS "-L/usr/local/opt/libffi/lib"
set -gx CPPFLAGS "-I/usr/local/opt/libffi/include"

set -gx PKG_CONFIG_PATH "/usr/local/opt/libffi/lib/pkgconfig"

zoxide init fish | source

set -g -x PATH $HOME/.fnm $PATH

set -g fish_user_paths "/usr/local/opt/texinfo/bin" $fish_user_path
