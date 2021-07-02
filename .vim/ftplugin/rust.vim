" Rust tags
setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
"silent! exec "!rusty-tags vi --quiet --start-dir=" .. expand('%:p:h') .. "&" | redraw!
