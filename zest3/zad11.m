clc;
clear;
close all;

syms x;
y=@(x) 1./(1+exp(-0.25.*x));
a = -2;
b = 3;
n=4;
%integral(y,a,b)

%Legendre's nodes (t) and weights (A) 
% each row for other polynomial's degree <1;4>
t=[ -0.577350 0.577350 0 0 0; 
    -0.774597 0 0.774597 0 0;
    -0.861136 -0.339981 0.339981 0.861136 0;
    -0.906180 -0.538469 0 0.538469 0.906180];

A=[ 1 1 0 0 0;
    5/9 8/9 5/9 0 0;
    0.347855 0.652145 0.652145 0.347855 0;
    0.236927 0.478629 0.568889 0.478629 0.236927];
P=zeros(n,n+1);
for i = 1 : n
    for j=1:i+1
        z=t(i,j)*((b-a)/2)+(b+a)/2;
        P(i,j)=((b-a)/2)*A(i,j)*(y(z));
    end
end
P_sum=zeros(n,1);
for i=1:n
    P_sum(i,1)=sum(P(i,:));
end
disp(P_sum)


%approximation by Simpson's rule
m=1000;
h=(b-a)/m;
q=zeros(m+1);
for i=1:m+1
    k=i-1;
    q(i)=a+k*h;
end

S=zeros(1,m+1);
for i=2:2:length(q)-1
    S(i)=2*(y(q(i)))*h/3;
end
for i=3:2:length(q)-1
    S(i)=4*(y(q(i)))*h/3;
end
S(1)=y(q(1))*h/3;
S(end)=y(q(end))*h/3;
S_sum=sum(S)