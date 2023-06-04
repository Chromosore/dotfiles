### `lga` (`lgarron` abbreviations)
# Stolen straight from https://github.com/lgarron/dotfiles
# See https://github.com/fish-shell/fish-shell/issues/9411

function _lga_define_anyarg_expansion
    set expansion $argv[1]
    set main_command $argv[2]
    set -l cmd (commandline -op)
    if [ "$cmd[1]" = $main_command ]
        echo $expansion
        return 0
    end
    return 1
end

function _lga_define_subcommand_expansion
    set expansion $argv[1]
    set main_command $argv[2]
    set sub_command_abbreviation $argv[3]
    set -l cmd (commandline -op)
    if [ "$cmd[1]" = $main_command -a (count $cmd) -eq 2 -a "$cmd[2]" = $sub_command_abbreviation ]
        echo $expansion
        return 0
    end
    return 1
end

function _lga_define_subcommand_arg_expansion
    set expansion $argv[1]
    set main_command $argv[2]
    set sub_commands $argv[3..-1]
    set -l cmd (commandline -op)
    if [ "$cmd[1]" = $main_command ]
        if contains -- "$cmd[2]" $sub_commands
            echo $expansion
            return 0
        end
    end
    return 1
end

function _lga_define_exceptsubcommand_arg_expansion
    set expansion $argv[1]
    set main_command $argv[2]
    set sub_commands $argv[3..-1]
    set -l cmd (commandline -op)
    if [ "$cmd[1]" = $main_command -a (count $cmd) -gt 2 ]
        if not contains -- "$cmd[2]" $sub_commands
            echo $expansion
            return 0
        end
    end
    return 1
end
