clc;
clear;
close all;

%in this script the isolation method has been extended by adding intervals, 
%at the ends of which the sign of the second derivative is changing
%so that the Newton's method can find all the roots.
%Unfortunately this script is not as universal as bisection method

a=-3;
b=6;
syms x;
p=-0.1*x.^4+0.8*x.^3-0.6*x.^2-2*x+1.5;

epsx=1e-5;
epsy=1e-5;
xd=a:0.1:b;

interv = intervals(p,x,xd,a,b);

x_0 = newton(interv, x, p, epsy, epsx);
if (isempty(x_0))
fprintf('There is no roots of \tp(x)=%s :\n', p)
elseif (length(x_0)==1)
fprintf('%.f root of \tp(x)=%s :\n', length(x_0), p)
fprintf('\tx_0 = %.3f\n', x_0);
else
fprintf('%.f roots of \tp(x)=%s :\n', length(x_0), p)
fprintf('\tx_0 = %.3f\n', x_0);
end

y=subs(p,x,xd);

%yd=vpa(subs(diff(p),x,xd));
%ydd=vpa(subs(diff(p,2),x,xd));
%PLOT
figure;
plot(xd,y,'-')
%plot(xd,yd,'--g', xd, ydd,'--b');
if (~isempty(x_0))
    hold on;
    plot(x_0, 0, 'or');
    hold off;
end
yline(0);
%xline(interv, '--');
ylabel('f(x)');
xlabel('x');
xlim([a b]);
title(sprintf('Newtons method for p(x) = %s', p));
grid on;
for i=1:length(x_0)
    label=sprintf('%.3f', x_0(i));
    hold on;
    text(x_0(i),0, label, ...
        'VerticalAlignment','cap', ...
        'HorizontalAlignment','left');
    hold off;
end

%FUNCTIONS
%finding intervals - isolation method
function interv = intervals(p,x,xd,a,b) 
interv=a;
dpz=diff(p);                               %derivative
dpz_val=vpa(subs(dpz,x,xd));
ddpz_val=vpa(subs(diff(p,2),x,xd));
    for i=2:length(xd)-1
        if dpz_val(i)*dpz_val(i-1)<0 || dpz_val(i)*dpz_val(i+1)<0       %if derivative changes sign
            interv(end+1)=xd(i);
        end
        if ddpz_val(i)*ddpz_val(i-1)<0 || ddpz_val(i)*ddpz_val(i+1)<0       %if second derivative changes sign
            interv(end+1)=xd(i);
        end
    end
    interv(end+1)=b;
    interv=sort(interv);
end

function x_0 = newton(interv, x, p, epsy, epsx)
x_0=[];
    for i=1:length(interv)-1
        a=interv(i);
        b=interv(i+1);
        fa=subs(p,x,a);
        fb=subs(p,x,b);
        fprintf('Interval:')
        fprintf('\t %.1f', a, b)
        fprintf('\n')
        if (fa * fb > 0)
            disp('The same sign at endpoints of the interval')
        else
            if fa*subs(diff(p,2),x,a) > 0
                x_i = a
                fi=fa
            elseif fb*subs(diff(p,2),x,b) > 0
                x_i = b
                fi= fb
            else
                break;
            end
            while(true)
                x_j=x_i-(fi/subs(diff(p),x,x_i));
                fj=subs(p,x,x_j);
                if abs(x_j-x_i) < epsx
                    break;
                end
                if abs(fj) < epsy
                    break;
                else
                    x_i=x_j;
                    fi=(subs(p,x,x_i));
                end
            end
            x_0(end+1)=x_i;
            fprintf('Root:\t\t')
            fprintf('%.3f \n',x_i)
        end
        fprintf('_____________________________________________________\n\n')
    end
end