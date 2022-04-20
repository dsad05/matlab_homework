clc;
clear;

%data
x = [0.1 0.3 0.6 0.8];
y = [-1 1.2 1.0 1.5];
xn = 0.55;
s = 100;
ox=linspace(x(1),x(end),s);

%plot
figure;
plot(x, y, 'o');
ylabel('y');
xlabel('x');
axis([0 0.9 -1.5 2]);
title("Newton's Polynomial Interpolate");
grid on;

%interpolation
NPol = newton_interpolation(x, y, xn)
%interpolated point on plot
hold on;
plot(xn,NPol,'r*');
label1 = {xn, NPol};
text(xn,NPol, label1,'VerticalAlignment','top','HorizontalAlignment','right');
hold off;

%function's plot
k=[];
m=[];

for i = 1:100
    m(end+1) = ox(i);
    xn = ox(i);
    NPol = newton_interpolation(x, y, xn);
    k(end+1) = NPol;
end
hold on;
plot(m,k);
hold off;


function NPol = newton_interpolation(x, y, xn)
n = length(x);
b = zeros(n,n);
b(:,1) = y(:);    %1st column of b has the y's values
for j = 2:n
    for i = 1:n-j+1
        b(i, j) = (b(i+1,j-1)-b(i,j-1))/(x(i+j-1)-x(i));
    end
end
xt = 1;
NPol = b(1,1);
for j = 1:n-1
    xt = xt*(xn-x(j));
    NPol = NPol+b(1,j+1)*xt;
end
end