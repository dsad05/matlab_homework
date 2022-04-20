clc;
clear;

%data
u = -1:0.25:1;
i = [0.01 -0.02 0.02 -0.01 0 0.08 0.22 0.6 0.98];
u1=-0.6;
u2=0.79;
xe=linspace(-1.5,1.5,1000); 

%interpolation 1st order with extrapolation
y1 = interp1(u,i,xe,'linear','extrap');

%interpolation 3rd order with extrapolation
y3 = spline(u, i, xe);

%interpolation of i for u1 and u2
i1=interp1(u,i,u1);
i2=spline(u,i,u2);

%plot
figure;
ylabel('i [A]');
xlabel('u [V]');
axis([-1.5, 1.5 -0.5 1.95]);
title('Plot i(u) [A] with 1st and 3rd order interpolation and extrapolation');
hold on;
plot(u, i, 'or', ...
    xe, y1,'b', ...
    xe, y3, 'g', ...
    u1,i1,'r*', ...
    u2,i2,'r*');
legend('Data', ...
    'First order interpolation with extrapolation', ...
    'Third order interpolation with extrapolation', ...
    'Choosen points', ...
    'Location', 'northwest')
label1 = {u1,i1};
text(u1,i1, label1,'VerticalAlignment','bottom','HorizontalAlignment','right');
label2 = {u2,i2};
text(u2,i2, label2,'VerticalAlignment','bottom','HorizontalAlignment','right');
