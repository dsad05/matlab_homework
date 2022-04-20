clc;
clear;


%data
x = 0.1:0.1:0.3;
y = [-2.79 -2.26 -1.99];
l = length(y);
alpha = 4.02;
beta = -2.62;
xp = 0.2300;  %point
a=x(1);
b=x(end);
h = (b-a)/(l-1);
s=0.01;     %space

%plot
figure;
ylabel('y');
xlabel('x');
title('Wykres y(x)');
xe=a:s:b;
plot(x, y, 'o', 'DisplayName', 'Data');
grid on;

%Ax=c;
A=zeros(l);
for i=1:l
    for j=1:l
        if i == j
            A(i,j)=4;
        elseif i==(j+1) || i==(j-1)
            A(i,j)=1;
        end
    end
end
A(1,2)=2;
A(l,l-1)=2
v=y';
v(1,1)=v(1,1)+(alpha*h/l);
v(l,1)=v(l,1)-(beta*h/l)
C=A\v
c1=C(2)-(alpha*h/3)
cnplus1=C(end-1)+(beta*h/3)
C=[c1; C; cnplus1]
disp('where C(1) is mathematicaly C-1 etc.')

%Phi
xPhi=[0 0 0 x 0 0 0];
for i=-3:l+2
    xPhi(i+4)=a+i*h;
end
xPhi=xPhi';
xi=xPhi(1):s:xPhi(end);
d=length(xi);
Phi = P(xi,xPhi,l,h,d);
hold on;
plot(xi,Phi, '--','DisplayName', 'Phi'); 
legend('location','bestoutside');
hold off;

S3=0;
for i=1:l+2
    for j=1:d
        pc(i,j)=Phi(i,j)*C(i,1);
    end
end
S3=sum(pc);
idx=find(abs(xi - xp.') < 10 * eps(max(xi, xp)));
fprintf('Interpolation for x = %o:',xp);
disp(S3(idx));
hold on;
plot(xi,S3,'DisplayName', 'Interpolation');
plot(xp, S3(idx), '*', 'DisplayName', 'Choosen point');
label1 = {xp, S3(idx)};
text(xp,S3(idx), label1,'VerticalAlignment','bottom','HorizontalAlignment','right');
axis([a b -3 4]);
xlim([a b]);
hold off;


function Phi = P(xi,xPhi,l,h,d)
    Phi=zeros(l+2,d);
    for i=3:l+4
        for j=1:d;
            ha = 1/(h^3);
            if xi(j) >= xPhi(i-2) && xi(j) <= xPhi(i-1)
                Phi(i-2,j)=ha*((xi(j)-xPhi(i-2))^3);
            elseif xi(j) >= xPhi(i-1) && xi(j) <= xPhi(i)
                Phi(i-2,j)=ha*((xi(j)-xPhi(i-2))^3-4*(xi(j)-xPhi(i-1))^3);
            elseif xi(j) >= xPhi(i) &&xi(j) <= xPhi(i+1)
                Phi(i-2,j)=ha*((xPhi(i+2)-xi(j))^3-4*(xPhi(i+1)-xi(j))^3);
            elseif xi(j) >= xPhi(i+1) && xi(j) <= xPhi(i+2)
                Phi(i-2,j)=ha*((xPhi(i+2)-xi(j))^3);
            end
        end
    end
end
