clc;
clear;
close all;

%dodać wykres


syms x1 x2;
x= [x1;
    x2];
F = [x1*x2-x1-2; 
    x1^2-x2^2-1];
y= [0; 
    0];
eps=1e-8;
i_max=30;

x0 = [-0.5;
     -0.5];

x0 = newton(F,x,eps,x0, i_max);
Fi=eval(subs(F,x,x0(:,end)));

figure;
[X,Y]=meshgrid(x1,x2);
Z=[X*Y-X-2; X^2-Y^2-1];
surf(Z,Y,Z);

function x0 = newton(F,x,eps,x0, i_max)
J=jacobian(F, x)
i=0;
    while(true)
        i=i+1;
        J_val=subs(J,x,x0(:,end));
        J_inv=inv(J_val);
        xi=eval(x0(:,end)-(J_inv*subs(F, x, x0(:,end))));
        if abs(subs(F,x,x0(:,end))-subs(F,x,xi(:,end))) < eps
            break;
        else
            x0(:,end+1)=xi;
        end
        if i == i_max
            disp('Stop!')
            break;
        end;
    end
    fprintf('%.3f \n',x0(:,end));
end