# IndexCalculusMethod
Solve a discrete logarithm problem using the index calculus method

### Description
Solve a discrete logarithm problem (β = αa mod p) using the index calculus method. The task is to find a knowing the value of β.
You will use p = 10930889, and perform calculations to the subgroup formed by α = 2317547. This subgroup has order 59407. Please notice that this makes it easy to solve the problem without using the index calculus method.
β = 9791436 ;

---- 

### Solution 
The matlab code used to solve the problem can be found in the repository

The index calculus method needs the use of a factor base. The choice of this factor is determinant for the resolution of the problem. If the factor base is too large, the program will take a long time to operate but if the factor is too small, the program could not find a solution. Regarding the different number of this problem I chose the following factor base : [ -1 2 3 5 7 11 13 17 19 23 29 31].
Then, I chose a random integer x < p. The following step is to factor s=αx mod p. If s can be factorized over the factor base, I will store the different factor in a matrix. I will do this until I find [length(base)] linearly independent lines in the matrix. It is possible to know this by computing the rank of the matrix containing the factors.
The next step is to solve the linear system. Then, we need to find a s which can be factorized over the factor base.
When a factorization is found we have
a = f0*log(-1) + f1*log(2) + f2*log(3) + ... + f31*log(31) – s.
As we know, the order of the subgroup is 59407 so we take a mod (59407) to have the solution.
In our case, we have a = 51335.
