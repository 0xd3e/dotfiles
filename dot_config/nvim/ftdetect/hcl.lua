local helpers = require('helpers')

helpers.create_augroup({
  {'BufNewFile,BufRead', '*.hcl', 'setfiletype', 'hcl'}
}, 'fthcl')
