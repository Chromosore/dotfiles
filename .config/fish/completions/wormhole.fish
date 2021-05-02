ccbegin wormhole

ccsub help ""
ccsub receive "Receive a text message, file, or directory (from 'wormhole send')"
ccsub send "Send a text message, file, or directory"
ccsub ssh "Facilitate sending/receiving SSH public keys"

cconce --appid ""
cconce --relay-url ""
cconce --transit-helper ""
cconce --dump-timing ""
cconce --version ""
cconce --help ""

# Files
ccafter help "" "" -x
ccafter receive "" "" -x
ccafter ssh "" "" -x
ccsub "" "" -x

ccend
