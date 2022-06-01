fun! chromosore#guifont#default(fontspec)
	let l:size = get(a:fontspec, 'size', v:null)
	let l:size = size is v:null ? '' : printf(':h%d', size)
	return a:fontspec.family .. size
endfun

fun! chromosore#guifont#gtk(fontspec)
	let l:size = get(a:fontspec, 'size', v:null)
	let l:size = size is v:null ? '' : printf(' %d', size)
	return a:fontspec.family .. size
endfun
