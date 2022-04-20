clc;
clear;
close all;

syms s;
f=@(s) -0.3.*s;

a=0;
b=1;

y0=2;

h1=1/2;
y1 = modified_euler(h1, y0, a, b, f)

h2=1/4;
y2 = modified_euler(h2, y0, a, b, f)

function y = modified_euler(h, y0, a, b, f)
n=(b-a)/h;
x=a:h:b;
y=zeros(1,n);
y(1)=y0;
    for i=2:n+1
        y(i)=y(i-1)+h*f(y(i-1)+f(y(i-1)*h/2));
    end
end