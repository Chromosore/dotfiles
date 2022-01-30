let g:sandwich_no_default_key_mappings = v:true

" I do not consider these as "user mappings"
xmap is  <Plug>(textobj-sandwich-query-i)
xmap as  <Plug>(textobj-sandwich-query-a)
omap is  <Plug>(textobj-sandwich-query-i)
omap as  <Plug>(textobj-sandwich-query-a)

xmap iss <Plug>(textobj-sandwich-auto-i)
xmap ass <Plug>(textobj-sandwich-auto-a)
omap iss <Plug>(textobj-sandwich-auto-i)
omap ass <Plug>(textobj-sandwich-auto-a)
