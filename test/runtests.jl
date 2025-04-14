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

#section 1.3 
# problems 1,2,5,6,7,9,11,13,15,17,(19),21,22,23-32,33,35,37

A = [
     1   5  -3  -4;
    -1  -4   1   3;
    -2  -7   0   h
]

A[2, :] += A[1, :]
A
A[3, :] += 2A[1, :]
A[3, :] += -3A[2,:]
A[1, :] -= 5A[2,:]
A


# 1 
u = [-1, 2]
v = [-3,3]
u + v
u - 2v

# 17
A = [
    1  -2   4;
    4  -3   1;
   -2   7   h
]
A[2, :] += -4A[1, :]
A[3, :] += 2A[1, :]
A[3,:] = 3A[2,:] - 5A[3,:]
A[1, :] = 5A[1,:] + 2A[2,:]
A

A = [
    1 -2 4;
    4 -3 1;
    -2 7 -17
]
Int.(rref(A))

A = [
    8 12
    2 3
    -6 -9
]
Int.(2rref(A))
@test allequal(A[:, 2] ./ A[:, 1])

#21 
A = [
    2 2 h
    -1 1 k
]
A[2, :] = 2A[2, :] + A[1, :]
A
A[1, :] = 2A[1, :] - A[2, :]
A
#35 
A = [
    20 30 150 
    550 500 2825 
]
rref(A)
@test all(1.5A[:, 1] + 4A[:, 2] .≈ A[:, 3])

#37
ms = [2, 5, 2, 1]
m = sum(ms)
v1 = [5, -4, 3]
v2 = [4, 3, -2]
v3 = [-4, -3, -1]
v4 = [-9, 8, 6]
vs = [v1, v2, v3, v4]
com = (1/m) .* sum(ms .* vs)

# 39 is the best exercise 

aug_matrix = [
    1 1 1 6;
    0 4 1 4;
    1 1 4 12
]
rref(aug_matrix)
#pearson
aug_matrix = [
    1   0   5   2;
   -2   1  -6  -3;
    0   3  12   3
]
rref(aug_matrix)

aug_matrix = [
    1  -6   2   2;
    0   2   3  -7;
   -2  12  -4  -2
]
rref(aug_matrix)
@variables a y 
A = [
    18 18 a
    -1 1 y
]
A[2,:]= 18A[2,:] + A[1,:]
A[1,:] = 2A[1,:] - A[2,:]
A
A

# section 1.4
# 13, 14,15,17,18,19,21,22,23-34,36,39,41,42,43,44,45,46

#13 
A = [3 -5 0;
    -2 6 4;
    1 1 4]
r = rref(A)
@test 2.5A[:,1] + 1.5A[:,2] ≈ A[:,3]
B = A[:, 1:2]
B \ [0,0,1]
residual = [0, 0, 1] - B * (B \ [0, 0, 1])
# it is clearly inconsistent 
rref(hcat(B, [0, 0, 1]))
#14 
A = [5 8 7 2;
    0 1 -1 -3;
    1 3 0 2]
rref(A)
# symbolics compatible rref 
# findfirst nonzero 
# 15
@variables b1 b2
A = [
    3 -4 b1
    -6 8 b2    
]
A[2, :] += 2A[1, :]
A
#17
A = [1 3 0 3;
    -1 -1 -1 1;
    0 -4 2 -8;
    2 0 3 -1]
rref(A)
B = [1 3 -2 2;
    0 1 1 -5;
    1 2 -3 7;
    -2 -8 2 -1]
rref(B)
#21
V = [1 0 1;
    0 -1 0;
    -1 0 0;
    0 1 -1]
rref(V)
#39
A  =[
    2 1 1
    1 2 1
    1 1 2
]
rank(A)

#online 
aug = [1 7 -5 14;
    -4 -3 -5 19;
    4 3 2 -19]

rref(aug)
aug = [3 -1 17;
    -2 4 -3;
    2 2 18]
rref(aug)
aug = [4 8 -8 -12;
    1 0 4 5;
    3 1 9 13]
rref(aug)
A = [2 4 -5 8;
    -1 -1 1 0;
    -4 0 -2 16;
    0 2 -3 12]
rref(A)
A = [1 3 -7 1;
    -1 -1 2 3;
    0 -6 15 -12;
    2 0 1 -15]
rref(A)


# section 1.5 
# 1,3,5,6,7,9,11,13,15,17,18,19,20,21,22,23,24,
# 25,26,27-36,37,38,39,40,49,52
# practice problems
A = [
    1 4 -5 0
    2 -1 8 9
]
rref(A)
A = [
    1 4 -5 0
    2 -1 8 0
]
rref(A)
# 1
aug = [2 -5 8 0;
    -2 -7 1 0;
    4 2 7 0]
rref(aug)
#3.
aug = [-3 5 -7 0;
    -6 7 1 0]
rref(aug)
#5
aug = [1 3 1 0;
    -4 -9 2 0;
    0 -3 -6 0]
rref(aug)
#7
A = [1 3 -3 7 0;
    0 1 -4 5 0]
rref(A)
#9 
A = [2 -8 6 0 
    -1 4 -3 0]
rref(A)
 
#19
aug = [1 3 1 1;
    -4 -9 2 -1;
    0 -3 -6 -3]
rref(aug)
# 20
aug = [1 3 -5 4;
    1 4 -8 7;
    -3 -7 9 -6]
rref(aug)