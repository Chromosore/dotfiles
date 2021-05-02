ccbegin signify

ccdispatch -x

ccsub -C "Verify a signed checksum list"
ccsub -G "Generate a new key pair"
ccsub -S "Sign specified message"
ccsub -V "Verify a signed message and sig"

cconce -c "add a comment during key generation"
cconce -q "quiet mode"

ccif -S -e "embed the message after the sig"
ccif -V -e "extract the message from the sig"

ccif -S -m "the file containing the message to sign"
ccif -V -m "the file containing the message to verify"

ccif -G -n "do not ask for a passphrase"
ccif -z -n "store a zero time stamp in the gzip header"

ccif -G -p "public key"
ccif -V -p "key to use to check the sig"

ccif -G -s "private key"
ccif -S -s "key to use to sign the message"

ccif -S -x "the signature file to create"
ccif -V -x "the signature file to verify"

ccif "-S -V" -z "sign and verify gzip archives"

ccend
