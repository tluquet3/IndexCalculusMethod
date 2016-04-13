%% ECE 6280_ Project 
% In the course project, you will solve a discrete logarithm problem (? = ?^a mod p) using the index calculus method.
clc 
clear all 
close all 

p = 10930889 ; 
alpha = 2317547 ;
beta = 9791436 ; 
order = 59407 ; 
% This is the factor base I will use to solve the problem
Base = [ -1 2 3 5 7 11 13 17 19 23 29 31];
maxB = max(Base) ; 

relations = []; 
numbers = [] ; 
r = 0 ; 
exit = 0 ; 
k=1;
j=1 ; 
while ( exit == 0)
    %First I choose a random x mod p-1 
    x = randi(p-1) ; 
    s = squareAndMultiply(alpha,x,p) ; 
    % Then I factor alpha^x mod p 
    if(s > floor(p/2))
        s = s-p; 
        f = factor(-s);
    else
        f= factor(s); 
    end
    m = max(f); 
    if ( m <= maxB ) % If it can be decomposed over the factor Base B
        line = zeros(1,length(Base));
        if( s<0)
            line(1,1) = 1 ; 
        end
        for i = 1:length(f)
           index = find(f(i) == Base) ; 
           line(1,index) = line(1,index) + 1 ;
        end
        % Test of linearly dependance .
        temp = vertcat(relations, line) ;
        rTemp = rank(temp); 
        % By computing the rank of the created matrix we know if it is
        % still linearly independant 
        if( rTemp > r ) 
            r = rTemp ; 
            relations = temp ;
            numbers(length(numbers) + 1) = x ; 
        end
    end
    k = k+1 ; 
    if( r == length(Base) )
        exit = 1 ; 
    end
end
    %% We now need to solve the linear system 
    solutions = linsolve(relations, numbers') ; 
    
    %% Then we need to find a s such as alpha^s * beta mod p can be
    % decomposed over the base B
    
    exit = 0 ; 
    while (exit == 0  ) 
        s = randi(p-1) ; 
        y = squareAndMultiply(alpha,s,p) ; 
        y = mod(y*beta,p);
        if(y > floor(p/2))
             y = y-p;
             f= factor(-y) ; 
        else
            f = factor(y) ; 
        end
        if (max(f) <= maxB ) 
            line = zeros(1,length(Base));
            if(y < 0) 
                line(1) = 1 ; 
            end
            for i = 1:length(f)
               index = find(f(i) == Base) ; 
               line(index) = line(index) + 1 ;
            end
            
            a = mod(line*solutions - s,order)  ;
            if( squareAndMultiply(alpha,a,p) == beta )
                exit = 1; 
            end
        end
    end
    
    %a is the solution  = 51335
    a = mod(line*solutions - s,order) 
    squareAndMultiply(alpha,a,p)
    
 
