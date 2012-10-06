makeMultiplier = (n) ->
  code = []

  code.push   '  _mul' + n + ': (xs, ys) ->'
  code.push   '    y_' + j + ' = ys[' + j + ']' for j in [0...n]
  code.push   '  '
  code.push   '    zs = [' + (('0' for i in [0...n]).join ', ') + ']'
  code.push   '    n_xs = xs.length'
  code.push   '  '
  code.push   '    if n_xs > 0'
  code.push   '      for j in [0...n_xs] by 1'
  code.push   '        x_l = xs[j] & __demimask__'
  code.push   '        x_h = xs[j] >> __demiradix__'
  code.push   '        c = 0'
  code.push   '        k = j'
  code.push   ''

  for j in [0...n]
    code.push '        y_l = y_' + j + ' & __demimask__'
    code.push '        y_h = y_' + j + ' >> __demiradix__'
    code.push '        m = x_h*y_l + y_h*x_l'
    code.push '        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c'
    code.push '        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h'
    code.push '        zs[j++] = z_j & __mask__'
    code.push '  '

  code.push   '        zs[j] = c'
  code.push   '    zs'
  code.push   ''
  code.push   ''

  code.join '\n'

exports.mul = makeMultiplier



