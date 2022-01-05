set -- subcommands -C -G -S -V

complete -c signify -x -a -C -n "not __fish_seen_subcommand_from $subcommands" -d "Verify a signed checksum list"
complete -c signify -x -a -G -n "not __fish_seen_subcommand_from $subcommands" -d "Generate a new key pair"
complete -c signify -x -a -S -n "not __fish_seen_subcommand_from $subcommands" -d "Sign specified message"
complete -c signify -x -a -V -n "not __fish_seen_subcommand_from $subcommands" -d "Verify a signed message and sig"

complete -c signify -s c -x -d "add a comment during key generation"
complete -c signify -s q -d "quiet mode"

complete -c signify -s e -n '__fish_seen_argument -s S' -d "embed the message after the sig"
complete -c signify -s e -n '__fish_seen_argument -s V' -d "extract the message from the sig"

complete -c signify -s m -n '__fish_seen_argument -s S' -d "the file containing the message to sign"
complete -c signify -s m -n '__fish_seen_argument -s V' -d "the file containing the message to verify"

complete -c signify -s n -n '__fish_seen_argument -s G' -d "do not ask for a passphrase"
complete -c signify -s n -n '__fish_seen_argument -s z' -d "store a zero time stamp in the gzip header"

complete -c signify -s p -n '__fish_seen_argument -s G' -d "public key"
complete -c signify -s p -n '__fish_seen_argument -s V' -d "key to use to check the sig"

complete -c signify -s s -n '__fish_seen_argument -s G' -d "private key"
complete -c signify -s s -n '__fish_seen_argument -s S' -d "key to use to sign the message"

complete -c signify -s x -n '__fish_seen_argument -s S' -d "the signature file to create"
complete -c signify -s x -n '__fish_seen_argument -s V' -d "the signature file to verify"

complete -c signify -s z -n '__fish_seen_argument -s S -s V' -d "sign and verify gzip archives"
