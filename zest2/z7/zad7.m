clc;
clear;
close all;

x=-5:1:5;
syms xs;
ys=1./(1+exp(1).^(-xs));
y=eval(subs(ys,xs,x));
m=3;
a=x(1);
b=x(end);
xd=a:0.01:b;
yd=eval(subs(ys,xs,xd));

M=ones(length(x), m+1);
for i=1:length(x)
    for j=2:m+1
        M(i,j)=M(i,j-1)*x(i);
    end
end

MT=M';
MTY=MT*y';
MTM=MT*M;

A=MTM\MTY

syms z
p=A(1);
for i=2:m+1
    p=p+A(i)*z^(i-1);
end
P=eval(subs(p, z, x));
Pd=eval(subs(p, z, xd));

disp('Approximation error - formula from coursebook:')
er=(y-P).^2;
error=sqrt(sum(er)/length(x))

disp('Approximation error - formula from task:')
er1=abs(y-P);
error1=sum(er1)/length(x)

figure;
plot(x, y, 'or', ...
    xd, yd, '-r', ...
    x, P, '*b', ...
    xd, Pd, '-b');
legend('Data', 'Function', 'Approximation - points', 'Approximation function for xd', 'location','best');
ylabel('y');
xlabel('x');
xlim([a b]);
title("Approximation by algebraic polynomials");
grid on;