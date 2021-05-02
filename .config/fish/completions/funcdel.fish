set funcname (basename (status filename) .fish)

ccbegin $funcname

ccdispatch -x
ccdispatch -a '(functions -n)'

ccend
