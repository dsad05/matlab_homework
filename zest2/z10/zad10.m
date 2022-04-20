clc;
clear;
close all;

syms x;
f  = @(x) exp(x.^2);
a=-2;
b=1;

m=6;    %intervals
n=m+1;
x=linspace(a,b,n);

I=zeros(1,m);
for i=1:m
    I(1,i)=f(x(i))*(x(i+1)-x(i));
end
I_sum=sum(I);

fprintf('Integral - rectangle method: \nI = %.3f\n', I_sum);
I_a = integral(f, a, b);
fprintf('Integral - analytical method: \nI = %.3f', I_a);

I(end+1)=I(end);
%FIGURE

xd=linspace(a,b,100);
figure;
plot(xd, f(xd));
ylabel('y');
xlabel('x');
syms x;
title(sprintf('y(x) = %s for <%.f,%.f> ', f(x),a,b));
grid on;