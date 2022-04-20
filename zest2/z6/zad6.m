clc;
clear;
close all;

x = 0.2:0.1:0.8;
y = [0 0 1 1 0 0 0.5];
lx = length(x);
n = lx-1
a = x(1);
b = x(end);
h=(b-a)/n
l=h*(n+1)/2
c=pi/l
m=2;
a=x(1)-h;
i=lx+1;
b=x(end)+h;
xd=a:0.01:b;


%do poprawy! rozmiary M itd

M=zeros(n+1,5);
for i=1:n+1
    M(i,1)=1;
    M(i,2)=(cos(x(i)*c));
    M(i,3)=(sin(x(i)*c));
    M(i,4)=(cos(x(i)*2*c));
    M(i,5)=(sin(x(i)*2*c));
end

MT=M';
MTY=MT*y';
MTM=MT*M;

A=MTM\MTY

syms z;

p=A(1);
for i=2:m+1
    p=p+A(i)*z^(i-1);
end

T(z)=A(1)+A(2)*cos(c*z)+A(3)*sin(c*z)+A(4)*cos(2*c*z)+A(5)*sin(2*c*z);
T1(z)=A(1)+A(2)*cos(c*z)+A(3)*sin(c*z);

ap=eval(subs(T, z, xd));
ap1=eval(subs(T1, z, xd));

figure;
plot(x, y, 'o', ...
    xd, ap, '-', ...
    xd, ap1, '--');
legend('Data', 'Approximation (2nd order)', 'Approximation (1st order)');
ylabel('y');
xlabel('x');
xlim([a b]);
title("Approximation by trigonometric polynomials");
grid on;