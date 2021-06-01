if not set -q PROFILE
	exec bash -c "source ~/.profile; exec fish"
end

if not set -qx LESSOPEN && not set -qx LESSCLOSE
	lesspipe | source
end

alias info='info --vi-keys'
alias ls='exa'
alias bat='python3 -m rich.syntax -b default -t solarized-dark'

function _run_fish_hooks --on-variable PWD
	fish_hooks
end

# confed settings
# confed is awesome
# (I might be its creator)
# (but whatever)
set CONFED_PATH $CONF/fish/functions $CONF/fish/completions
set -a CONFED_PATH $HOME/.vim

set CONFED_SPECIAL $HOME/.profile $HOME/.bashrc
