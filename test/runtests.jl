using Symbolics, LinearAlgebra, Test
using RowEchelon, SpecialMatrices

# 1.1 35)
@variables g h k
A = [
    1 -3 5 g;
    0 2 -3 h;
    -3 5 -9 k
]

A[3, :] += 3A[1, :]
A
A[3, :] += 2A[2, :]
A
A[1, :] = 2A[1, :] + 3A[2, :]
A
# the equation for consistency is that A[3,4] = 0 
A[3, 4]

@variables T[1:4]
A = [
    4 -1 0 -1 30
    -1 4 -1 0 60
    0 -1 4 -1 70
    -1 0 -1 4 40
]
# A[1,:] += 3A[2,:]
A[2, :] = 4A[2, :] + A[1, :]
A
A[4, :] = 4A[4, :] + A[1, :]
A
A[3, :] = 15A[3, :] + A[2, :]
A
A[4, :] = 15A[4, :] + A[2, :]
A

A = [
    1 -5 5 g;
    0 9 -7 h;
    -3 6 -8 k
]
A[3, :] += 3A[1, :]
A
A[3, :] += A[2, :]
A

# 1.2 section
# practice problems 
# 1,2 5, 7, 9, 15, 19, 21, 23, 25-34, 45, 46

# check 1,2 

A = [
    1 -2 -1 3 0;
    -2 4 5 -5 3;
    3 -6 -6 8 2
]

A[2, :] += 2A[1, :]
A
A[3, :] -= 3A[1, :]
A
A[3, :] += A[2, :]
A # the system is inconsistent 

#7
A = [
    1 2 3 4;
    4 8 9 4
]

A[2, :] -= 4A[1, :]
A[2, :] = A[2, :] / -3
A[1, :] -= 3A[2, :]
A
Int.(rref(A))
aug_matrix_9 = [
    0 1 -6 5;
    1 -2 7 -4
]
Int.(rref(aug_matrix_9))

@variables h
A = [
    2 3 h;
    4 6 7
]
A[2, :] -= 2A[1, :]
# fucking symbolics lol
# rref!(aug_matrix_21, 0)
A

A = [
    1 -4 -3;
    6 h -9
]
A[2, :] -= 6A[1, :]
A
# the only case when we get a 0=1 type equation is when h = -24

A = [
    1 h 2
    4 8 k
]
A[2, :] -= 4A[1, :]
A

A = [
    1 4 5
    2 h k
]
A[2, :] -= 2A[1, :]
A

A = [
    1 1 1 11
    1 2 4 16
    1 3 9 19
]
Int.(rref(A))

# 46
vel = [0, 2,4,6,8,10]
force = [0, 2.9, 14.8, 39.6, 74.3, 119]
@variables t a[1:6]

p(t, a) = sum(collect(a .* (t .^ (0:5))))
rows = []
for v in vel 
    push!(rows, substitute(t .^ (0:5), Dict([t=>v])))
end
A = [stack(rows;dims=1) force]
rref(A)
# alternatively
a = collect(0:2:10)
A2 = [Vandermonde(a) force]

# Apparently The backslash operator \ is overloaded to solve Vandermonde and adjoint Vandermonde systems in O(n^2) time using the algorithm of Björck & Pereyra (1970).
B = Vandermonde(a)
x = B \ force # is faster 
@test all(p.(vel, (x,)) .≈ force)
