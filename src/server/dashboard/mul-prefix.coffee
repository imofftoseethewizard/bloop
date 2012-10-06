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

