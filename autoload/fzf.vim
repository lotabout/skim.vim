" Glue functions for plugins calling fzf#run and/or fzf#wrap directly
function! fzf#wrap(...)
  return call('skim#wrap', a:000)
endfunction

function! fzf#run(...) abort
  return call('skim#run', a:000)
endfunction
