import mpmath.libmp
assert mpmath.libmp.BACKEND == 'gmpy'
import numpy as np
import sympy
import math
from numpy import nan
from numpy import inf
from numpy import exp

import functools
import scipy

import scipy.io as sio

from scipy import odr
from scipy import interpolate
from scipy import optimize
from scipy import special

# setup symbols
modelSymbols = sympy.symbols('I0_1 Iph_1 Rs_1 Rsh_1 n_1 V_1 I0_2 Iph_2 Rs_2 Rsh_2 n_2 V_2 I Vth', real=True, positive=True)
I0_1, Iph_1, Rs_1, Rsh_1, n_1, V_1, I0_2, Iph_2, Rs_2, Rsh_2, n_2, V_2, I, Vth = modelSymbols


# calculate values for our model's constants now
cellTemp = 29 #degC all analysis is done assuming the cell is at 29 degC
T = 273.15 + cellTemp #cell temp in K
K = 1.3806488e-23 #boltzman constant
q = 1.60217657e-19 #electron charge
thermalVoltage = K*T/q #thermal voltage ~26mv
valuesForConstants = (thermalVoltage,)

# define cell circuit model here
lhs = Iph_1-((V_1+I*Rs_1)/Rsh_1)-I0_1*(sympy.exp((V_1+I*Rs_1)/(n_1*Vth))-1)
rhs = Iph_2-((V_2+I*Rs_2)/Rsh_2)-I0_2*(sympy.exp((V_2+I*Rs_2)/(n_2*Vth))-1)

# define cell circuit model here
electricalModel = sympy.Eq(lhs,rhs)
#electricalModelVarsOnly = electricalModel.subs(zip(modelConstants,valuesForConstants))

fastAndSloppy = False

# here we define any function substitutions we'll need for lambdification later
if fastAndSloppy:
  # for fast and inaccurate math
  functionSubstitutions = {"LambertW" : scipy.special.lambertw, "exp" : np.exp}
else:
  # this is a massive slowdown (forces a ton of operations into mpmath)
  # but gives _much_ better accuracy and aviods overflow warnings/errors...
  functionSubstitutions = {"LambertW" : mpmath.lambertw, "exp" : mpmath.exp}
  

I_sln = sympy.solve(electricalModel,I)[0]