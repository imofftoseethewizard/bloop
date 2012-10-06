## %% Begin Remove for Specialize %%

__radix__  = 28
__base__   = 1 << __radix__
__base2__  = Math.pow __base__, 2
__mask__   = __base__ - 1

__demiradix__ = __radix__ >> 1
__demibase__  = 1 << __demiradix__
__demimask__  = __demibase__ - 1

## %% End Remove for Specialize %%

window.Multipliers__radix__ =

  _mul1: (xs, ys) ->
    y_0 = ys[0]
  
    zs = [0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul2: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
  
    zs = [0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul3: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
  
    zs = [0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul4: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
  
    zs = [0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul5: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
  
    zs = [0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul6: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
  
    zs = [0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul7: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
  
    zs = [0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul8: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul9: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul10: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul11: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul12: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul13: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul14: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul15: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul16: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul17: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul18: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul19: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul20: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul21: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul22: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul23: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul24: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul25: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul26: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul27: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul28: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul29: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul30: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul31: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul32: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul33: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul34: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul35: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul36: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul37: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul38: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul39: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul40: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul41: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul42: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul43: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul44: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul45: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul46: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul47: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul48: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul49: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul50: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
    y_49 = ys[49]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_49 & __demimask__
        y_h = y_49 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul51: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
    y_49 = ys[49]
    y_50 = ys[50]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_49 & __demimask__
        y_h = y_49 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_50 & __demimask__
        y_h = y_50 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul52: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
    y_49 = ys[49]
    y_50 = ys[50]
    y_51 = ys[51]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_49 & __demimask__
        y_h = y_49 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_50 & __demimask__
        y_h = y_50 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_51 & __demimask__
        y_h = y_51 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul53: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
    y_49 = ys[49]
    y_50 = ys[50]
    y_51 = ys[51]
    y_52 = ys[52]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_49 & __demimask__
        y_h = y_49 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_50 & __demimask__
        y_h = y_50 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_51 & __demimask__
        y_h = y_51 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_52 & __demimask__
        y_h = y_52 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul54: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
    y_49 = ys[49]
    y_50 = ys[50]
    y_51 = ys[51]
    y_52 = ys[52]
    y_53 = ys[53]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_49 & __demimask__
        y_h = y_49 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_50 & __demimask__
        y_h = y_50 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_51 & __demimask__
        y_h = y_51 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_52 & __demimask__
        y_h = y_52 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_53 & __demimask__
        y_h = y_53 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul55: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
    y_49 = ys[49]
    y_50 = ys[50]
    y_51 = ys[51]
    y_52 = ys[52]
    y_53 = ys[53]
    y_54 = ys[54]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_49 & __demimask__
        y_h = y_49 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_50 & __demimask__
        y_h = y_50 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_51 & __demimask__
        y_h = y_51 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_52 & __demimask__
        y_h = y_52 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_53 & __demimask__
        y_h = y_53 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_54 & __demimask__
        y_h = y_54 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul56: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
    y_49 = ys[49]
    y_50 = ys[50]
    y_51 = ys[51]
    y_52 = ys[52]
    y_53 = ys[53]
    y_54 = ys[54]
    y_55 = ys[55]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_49 & __demimask__
        y_h = y_49 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_50 & __demimask__
        y_h = y_50 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_51 & __demimask__
        y_h = y_51 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_52 & __demimask__
        y_h = y_52 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_53 & __demimask__
        y_h = y_53 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_54 & __demimask__
        y_h = y_54 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_55 & __demimask__
        y_h = y_55 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul57: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
    y_49 = ys[49]
    y_50 = ys[50]
    y_51 = ys[51]
    y_52 = ys[52]
    y_53 = ys[53]
    y_54 = ys[54]
    y_55 = ys[55]
    y_56 = ys[56]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_49 & __demimask__
        y_h = y_49 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_50 & __demimask__
        y_h = y_50 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_51 & __demimask__
        y_h = y_51 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_52 & __demimask__
        y_h = y_52 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_53 & __demimask__
        y_h = y_53 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_54 & __demimask__
        y_h = y_54 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_55 & __demimask__
        y_h = y_55 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_56 & __demimask__
        y_h = y_56 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul58: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
    y_49 = ys[49]
    y_50 = ys[50]
    y_51 = ys[51]
    y_52 = ys[52]
    y_53 = ys[53]
    y_54 = ys[54]
    y_55 = ys[55]
    y_56 = ys[56]
    y_57 = ys[57]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_49 & __demimask__
        y_h = y_49 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_50 & __demimask__
        y_h = y_50 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_51 & __demimask__
        y_h = y_51 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_52 & __demimask__
        y_h = y_52 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_53 & __demimask__
        y_h = y_53 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_54 & __demimask__
        y_h = y_54 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_55 & __demimask__
        y_h = y_55 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_56 & __demimask__
        y_h = y_56 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_57 & __demimask__
        y_h = y_57 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul59: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
    y_49 = ys[49]
    y_50 = ys[50]
    y_51 = ys[51]
    y_52 = ys[52]
    y_53 = ys[53]
    y_54 = ys[54]
    y_55 = ys[55]
    y_56 = ys[56]
    y_57 = ys[57]
    y_58 = ys[58]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_49 & __demimask__
        y_h = y_49 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_50 & __demimask__
        y_h = y_50 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_51 & __demimask__
        y_h = y_51 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_52 & __demimask__
        y_h = y_52 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_53 & __demimask__
        y_h = y_53 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_54 & __demimask__
        y_h = y_54 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_55 & __demimask__
        y_h = y_55 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_56 & __demimask__
        y_h = y_56 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_57 & __demimask__
        y_h = y_57 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_58 & __demimask__
        y_h = y_58 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul60: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
    y_49 = ys[49]
    y_50 = ys[50]
    y_51 = ys[51]
    y_52 = ys[52]
    y_53 = ys[53]
    y_54 = ys[54]
    y_55 = ys[55]
    y_56 = ys[56]
    y_57 = ys[57]
    y_58 = ys[58]
    y_59 = ys[59]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_49 & __demimask__
        y_h = y_49 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_50 & __demimask__
        y_h = y_50 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_51 & __demimask__
        y_h = y_51 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_52 & __demimask__
        y_h = y_52 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_53 & __demimask__
        y_h = y_53 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_54 & __demimask__
        y_h = y_54 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_55 & __demimask__
        y_h = y_55 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_56 & __demimask__
        y_h = y_56 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_57 & __demimask__
        y_h = y_57 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_58 & __demimask__
        y_h = y_58 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_59 & __demimask__
        y_h = y_59 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul61: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
    y_49 = ys[49]
    y_50 = ys[50]
    y_51 = ys[51]
    y_52 = ys[52]
    y_53 = ys[53]
    y_54 = ys[54]
    y_55 = ys[55]
    y_56 = ys[56]
    y_57 = ys[57]
    y_58 = ys[58]
    y_59 = ys[59]
    y_60 = ys[60]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_49 & __demimask__
        y_h = y_49 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_50 & __demimask__
        y_h = y_50 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_51 & __demimask__
        y_h = y_51 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_52 & __demimask__
        y_h = y_52 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_53 & __demimask__
        y_h = y_53 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_54 & __demimask__
        y_h = y_54 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_55 & __demimask__
        y_h = y_55 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_56 & __demimask__
        y_h = y_56 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_57 & __demimask__
        y_h = y_57 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_58 & __demimask__
        y_h = y_58 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_59 & __demimask__
        y_h = y_59 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_60 & __demimask__
        y_h = y_60 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul62: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
    y_49 = ys[49]
    y_50 = ys[50]
    y_51 = ys[51]
    y_52 = ys[52]
    y_53 = ys[53]
    y_54 = ys[54]
    y_55 = ys[55]
    y_56 = ys[56]
    y_57 = ys[57]
    y_58 = ys[58]
    y_59 = ys[59]
    y_60 = ys[60]
    y_61 = ys[61]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_49 & __demimask__
        y_h = y_49 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_50 & __demimask__
        y_h = y_50 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_51 & __demimask__
        y_h = y_51 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_52 & __demimask__
        y_h = y_52 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_53 & __demimask__
        y_h = y_53 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_54 & __demimask__
        y_h = y_54 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_55 & __demimask__
        y_h = y_55 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_56 & __demimask__
        y_h = y_56 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_57 & __demimask__
        y_h = y_57 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_58 & __demimask__
        y_h = y_58 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_59 & __demimask__
        y_h = y_59 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_60 & __demimask__
        y_h = y_60 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_61 & __demimask__
        y_h = y_61 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

  _mul63: (xs, ys) ->
    y_0 = ys[0]
    y_1 = ys[1]
    y_2 = ys[2]
    y_3 = ys[3]
    y_4 = ys[4]
    y_5 = ys[5]
    y_6 = ys[6]
    y_7 = ys[7]
    y_8 = ys[8]
    y_9 = ys[9]
    y_10 = ys[10]
    y_11 = ys[11]
    y_12 = ys[12]
    y_13 = ys[13]
    y_14 = ys[14]
    y_15 = ys[15]
    y_16 = ys[16]
    y_17 = ys[17]
    y_18 = ys[18]
    y_19 = ys[19]
    y_20 = ys[20]
    y_21 = ys[21]
    y_22 = ys[22]
    y_23 = ys[23]
    y_24 = ys[24]
    y_25 = ys[25]
    y_26 = ys[26]
    y_27 = ys[27]
    y_28 = ys[28]
    y_29 = ys[29]
    y_30 = ys[30]
    y_31 = ys[31]
    y_32 = ys[32]
    y_33 = ys[33]
    y_34 = ys[34]
    y_35 = ys[35]
    y_36 = ys[36]
    y_37 = ys[37]
    y_38 = ys[38]
    y_39 = ys[39]
    y_40 = ys[40]
    y_41 = ys[41]
    y_42 = ys[42]
    y_43 = ys[43]
    y_44 = ys[44]
    y_45 = ys[45]
    y_46 = ys[46]
    y_47 = ys[47]
    y_48 = ys[48]
    y_49 = ys[49]
    y_50 = ys[50]
    y_51 = ys[51]
    y_52 = ys[52]
    y_53 = ys[53]
    y_54 = ys[54]
    y_55 = ys[55]
    y_56 = ys[56]
    y_57 = ys[57]
    y_58 = ys[58]
    y_59 = ys[59]
    y_60 = ys[60]
    y_61 = ys[61]
    y_62 = ys[62]
  
    zs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    n_xs = xs.length
  
    if n_xs > 0
      for j in [0...n_xs] by 1
        x_l = xs[j] & __demimask__
        x_h = xs[j] >> __demiradix__
        c = 0
        k = j

        y_l = y_0 & __demimask__
        y_h = y_0 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_1 & __demimask__
        y_h = y_1 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_2 & __demimask__
        y_h = y_2 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_3 & __demimask__
        y_h = y_3 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_4 & __demimask__
        y_h = y_4 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_5 & __demimask__
        y_h = y_5 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_6 & __demimask__
        y_h = y_6 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_7 & __demimask__
        y_h = y_7 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_8 & __demimask__
        y_h = y_8 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_9 & __demimask__
        y_h = y_9 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_10 & __demimask__
        y_h = y_10 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_11 & __demimask__
        y_h = y_11 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_12 & __demimask__
        y_h = y_12 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_13 & __demimask__
        y_h = y_13 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_14 & __demimask__
        y_h = y_14 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_15 & __demimask__
        y_h = y_15 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_16 & __demimask__
        y_h = y_16 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_17 & __demimask__
        y_h = y_17 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_18 & __demimask__
        y_h = y_18 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_19 & __demimask__
        y_h = y_19 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_20 & __demimask__
        y_h = y_20 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_21 & __demimask__
        y_h = y_21 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_22 & __demimask__
        y_h = y_22 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_23 & __demimask__
        y_h = y_23 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_24 & __demimask__
        y_h = y_24 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_25 & __demimask__
        y_h = y_25 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_26 & __demimask__
        y_h = y_26 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_27 & __demimask__
        y_h = y_27 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_28 & __demimask__
        y_h = y_28 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_29 & __demimask__
        y_h = y_29 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_30 & __demimask__
        y_h = y_30 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_31 & __demimask__
        y_h = y_31 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_32 & __demimask__
        y_h = y_32 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_33 & __demimask__
        y_h = y_33 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_34 & __demimask__
        y_h = y_34 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_35 & __demimask__
        y_h = y_35 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_36 & __demimask__
        y_h = y_36 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_37 & __demimask__
        y_h = y_37 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_38 & __demimask__
        y_h = y_38 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_39 & __demimask__
        y_h = y_39 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_40 & __demimask__
        y_h = y_40 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_41 & __demimask__
        y_h = y_41 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_42 & __demimask__
        y_h = y_42 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_43 & __demimask__
        y_h = y_43 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_44 & __demimask__
        y_h = y_44 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_45 & __demimask__
        y_h = y_45 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_46 & __demimask__
        y_h = y_46 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_47 & __demimask__
        y_h = y_47 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_48 & __demimask__
        y_h = y_48 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_49 & __demimask__
        y_h = y_49 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_50 & __demimask__
        y_h = y_50 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_51 & __demimask__
        y_h = y_51 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_52 & __demimask__
        y_h = y_52 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_53 & __demimask__
        y_h = y_53 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_54 & __demimask__
        y_h = y_54 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_55 & __demimask__
        y_h = y_55 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_56 & __demimask__
        y_h = y_56 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_57 & __demimask__
        y_h = y_57 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_58 & __demimask__
        y_h = y_58 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_59 & __demimask__
        y_h = y_59 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_60 & __demimask__
        y_h = y_60 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_61 & __demimask__
        y_h = y_61 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        y_l = y_62 & __demimask__
        y_h = y_62 >> __demiradix__
        m = x_h*y_l + y_h*x_l
        z_j = zs[j] + x_l*y_l + ((m & __demimask__) << __demiradix__) + c
        c = (z_j >>> __radix__) + (m >>> __demiradix__) + x_h*y_h
        zs[j++] = z_j & __mask__
  
        zs[j] = c
    zs

