# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export PROFILE=""

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME=$HOME/.config
fi

if [ -z "$XDG_DATA_HOME" ] ; then
    export XDG_DATA_HOME=$HOME/.local/share
fi

PATH=".:$PATH"

export PROJ="/home/raphael/Projects"
export CONF="$HOME/.config"
export SCHOOL="/media/shared/Ecole"
export EDITOR=$(which vim)
export EMAIL="raphi@babinux.com"

export GOPATH="$HOME/.go"
PATH="$GOPATH/bin:$PATH"

source "$HOME/.cargo/env"
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library/
