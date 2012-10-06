fs = require 'fs'

pow = Math.pow

lines = (String fs.readFileSync 'mul.coffee').split '\n'

for radix in [26, 28, 30]
  base = 1 << radix
  demiradix = radix >> 1
  demibase = 1 << demiradix

  codex =
    radix:     String radix
    base:      '0x' + base.toString 16
    base2:     '0x' + (pow base, 2).toString 16
    mask:      '0x' + (base - 1).toString 16
    demiradix: String demiradix
    demibase:  '0x' + demibase.toString 16
    demimask:  '0x' + (demibase - 1).toString 16

  skipRE   = /%% Begin Remove for Specialize %%/
  unskipRE = /%% End Remove for Specialize %%/
  targetRE = /__(radix|base|base2|mask|demiradix|demibase|demimask)__/g
  result = []
  skip = false
  for x in lines
    if      x.match skipRE   then skip = true
    else if x.match unskipRE then skip = false
    else if not skip
      result.push x.replace targetRE, (match, keyword) -> codex[keyword]

  fs.writeFileSync 'mul-' + radix + '-bit.coffee', result.join '\n'