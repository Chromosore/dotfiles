set -q XDG_CONFIG_DIR
and set -l config $XDG_CONFIG_DIR
or set -l config ~/.config

# confed settings
# confed is awesome
# (I might be its creator)
# (but whatever)
set -gx CONFED_PATH $__fish_config_dir/{conf.d,functions,completions}
set -a CONFED_PATH $config/kitty
set -a CONFED_PATH $config/nvim

set CONFED_SPECIAL $HOME/.profile
set -a CONFED_SPECIAL $__fish_config_dir/setup.fish
set -a CONFED_SPECIAL $config/mancolors
