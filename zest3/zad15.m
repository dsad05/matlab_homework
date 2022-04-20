clc;
clear;
close all;

a=-5;
b=5;
syms x;
p=1/5+x./20+(1/(1+exp(-2.*(x-1))))-(1/(1+exp(-3.*x)));


epsx=1e-6;
epsy=1e-6;
xd=a:0.1:b;

interv = intervals(p,x,xd,a,b);

x_0 = bisection(interv, x, p, epsx, epsy);
fprintf('For interval <%.f ; %.f> ', a,b)
if (isempty(x_0))
fprintf('there is no roots of \tp(x)=%s :\n', p)
elseif (length(x_0)==1)
fprintf('there is %.f root of \tp(x)=%s :\n', length(x_0), p)
fprintf('\tx_0 = %.3f\n', x_0);
else
fprintf('there are %.f roots of p(x)=%s :\n', length(x_0), p)
fprintf('\tx_0 = %.3f\n', x_0);
end

y=subs(p,x,xd);
figure;
plot(xd,y,'-')
if (~isempty(x_0))
    hold on;
    plot(x_0, 0, 'or');
    hold off;
end
yline(0);
ylabel('f(x)');
xlabel('x');
xlim([a b]);
title(sprintf('p(x) = %s', p));

for i=1:length(x_0)
    label=sprintf('%.3f', x_0(i));
    hold on;
    text(x_0(i),0, label, ...
        'VerticalAlignment','cap', ...
        'HorizontalAlignment','left');
    hold off;
end
%xline(x1, '--');

%FUNCTIONS
%finding intervals - isolation method
function interv = intervals(p,x,xd,a,b) 
interv=a;
dpz=diff(p);                               %derivative
dpz_val=eval(subs(dpz,x,xd));
    for i=1:length(xd)-1
        if dpz_val(i)*dpz_val(i+1)<0        %if derivative changes sign
            interv(end+1)=xd(i);
        end
    end
    interv(end+1)=b;
end

function x_0 = bisection(interv, x, p, epsx, epsy)
x_0=[];
    for i=1:length(interv)-1
        a=interv(i);
        b=interv(i+1);
        fa=eval(subs(p,x,a));
        fb=eval(subs(p,x,b));
        fprintf('Interval:')
        fprintf('\t %.1f', a, b)
        fprintf('\n')
        if (fa * fb > 0)
            disp('The same sign at endpoints of the interval')
        else
            while(true)
                x_i=(a+b)/2;
                if abs(a-x_i) < epsx
                    break;
                end
                f_div=eval(subs(p,x,x_i));
                if abs(f_div) < epsy
                    break;
                end
                if (fa*f_div < 0)
                    b = x_i;
                else
                    a = x_i;
                    fa=f_div;
                end
            end
            x_0(end+1)=x_i;
            fprintf('Root:\t\t')
            fprintf('%.3f \n',x_i)
        end
        fprintf('_____________________________________________________\n\n')
    end
end