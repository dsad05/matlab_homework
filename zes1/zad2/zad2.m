clear;
clc;

syms x y z;
f=(y^2*z^2)/(x+y);  %[W]

%differentials
g = diff(f,x);
h = diff(f,y);
j = diff(f,z);

%data
C = 1.1 * 10^(-3);  %[F]
R = 1 * 10^3;       %[Ohm]
i = 1.2 * 10^(-3);  %[A]
P=eval(subs(f, {x, y, z}, {C, R, i}));

%precision
dC = 0.05;
dR = 0.02;
di = 0.01;

%absolute errors
DC = dC * C;
DR = dR * R;
Di = di * i;

%absolute error of multivariable functions P(C,R,i);
k = abs(g)*DC+abs(h)*DR+abs(j)*Di;
DP = eval(subs(k, {x, y, z}, {C, R, i}));

%relative errors
dP = DP / P;

fprintf('Moc \t\t\t\tP = %s; \nblad bezwzgledny \tdP = %o;\nblad wzgledny \t\tDP = %u;  \n',P,DP,dP);