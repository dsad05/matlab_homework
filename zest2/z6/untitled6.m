clc;
clear;
close all;

x = 0.2:0.1:0.8;
y = [0 0 1 1 0 0 0.5];
m = length(x);
n = m-1;
a = x(1);
b = x(end);
h=(b-a)/n;
l=h*(n+1)/2;
c=pi/l;
m=2;

M=zeros(n+1,(m*2)+1);
    for i=1:n+1
        M(i,1)=1;
        for j=2:2:((m*2)+1)
            M(i,j)=(cos(x(i)*c*k));
        end
        for j=3:2:((m*2)+1)
            M(i,j)=(sin(x(i)*c*k));
        end
    end


MT=M';

MTY=zeros(5,1);
for i=1:5
MTY(i,1)=sum(y.*MT(i,:));
end

MTM=zeros(5,1);
MTM(1,1)=n+1;
for i=2:5
    MTM(i,i)=(n+1)/2;
end

A=MTM\MTY

syms z;

T=A(1);
j=2;
for i=1:m;
    T=T+A(j)*cos(i*c*z);
    j=+1;
    T=T+A(j)*sin(i*c*z);
    j=+1;
end
disp(T);

%T(z)=A(1)+A(2)*cos(c*z)+A(3)*sin(c*z)+A(4)*cos(2*c*z)+A(5)*sin(2*c*z)
%T1(z)=A(1)+A(2)*cos(c*z)+A(3)*sin(c*z);

xd=a:0.01:b;
ap=eval(subs(T, z, xd));

figure;
plot(x, y, 'o', ...
    xd, ap, '-');
legend('Data', 'Approximation');
ylabel('y');
xlabel('x');
xlim([0.2 0.8]);
title("Approximation by trigonometric polynomials");
grid on;