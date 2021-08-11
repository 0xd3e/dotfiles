local helpers = require('helpers')

helpers.create_augroup({
  {'BufNewFile,BufRead', '*.cue', 'setfiletype', 'cue'}
}, 'ftcue')
