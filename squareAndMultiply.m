function [ z ] = squareAndMultiply( b,N,m )
%UNTITLED2 Summary of this function goes here
%   calcul de b^N mod m 
    c = dec2bin(N);
    l = length(c) ;
    z =1 ; 
    for i=0:l-1
        z = mod(z^2,m);
        if(c(i+1) == '1')
           z = mod(z*b,m);  
        end
    end
end

