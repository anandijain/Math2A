import sympy as sp

# Define the augmented matrix
M = sp.Matrix([
    [1,  0, -4,  4],
    [0,  3, -2,  1],
    [-2, 6,  3, -4]
])

# Compute the Reduced Row Echelon Form (RREF)
M_rref, pivot_cols = M.rref()

# Print the RREF and the pivot columns
print("RREF of the augmented matrix:")
sp.pprint(M_rref)
print("\nPivot columns:", pivot_cols)
