if not set -q PROFILE
	exec bash -c "source ~/.profile; exec fish"
end

if not set -qx LESSOPEN && not set -qx LESSCLOSE
	lesspipe | source
end

alias info='info --vi-keys'
alias ls='exa'
alias bat='python3 -m rich.syntax -b default -t solarized-dark'

fish_hooks
function _run_fish_hooks --on-variable PWD
	fish_hooks
end


set -q XDG_CONFIG_DIR
and set -l config $XDG_CONFIG_DIR
or set -l config ~/.config

# confed settings
# confed is awesome
# (I might be its creator)
# (but whatever)
set -gx CONFED_PATH $__fish_config_dir/functions $__fish_config_dir/completions
set -a CONFED_PATH $HOME/.vim

set CONFED_SPECIAL $HOME/.profile
set -a CONFED_SPECIAL $__fish_config_dir/setup.fish
set -a CONFED_SPECIAL $config/mancolors
