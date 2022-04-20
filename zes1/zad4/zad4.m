clc;
clear;

%data
a = -1.5;
b = 1.5;
k = [3,5,6,8,9]; %k(i) - number of nodes we want to know
s=100; %linspace
ox=linspace(a,b,s);

syms x;
y = 1/(1+25*x^2);

l=length(k);
kmax=k(l);

%equidistant nodes
disp('Equidistant nodes');
%generating table T of k(i) nodes i.e. k(1)=3 nodes in 1st row, k(2)=6 nodes in 2nd row
T = zeros(l,kmax);
for i=1:l
    kn = k(i);
    h=(b-a)/(kn-1);
    m=0;
    for j=1:(kn)
        T(i,j)=a+m*h;
        m=m+1;
    end
end
error = Lagrange_Polynomial(k,T,y,x,s,ox,a,b);
hold on;
for j=1:s
    y1(j)=(subs(y,x,ox(j)));
end
plot(ox, y1, '-.', 'DisplayName', 'Function');
title("Lagrange interpolation for equidistant nodes");
hold off;

%{
%chebyshev nodes - eliminating Runge's phenomenon
disp('Chebyshev nodes')
%generating table T of k(i) chebyshev nodes i.e. k(1)=3 nodes in 1st row, k(2)=6 nodes in 2nd row
T = zeros(l,kmax);
for i=1:l
    kn = k(i);
    ChN = Chebyshev_nodes(a,b,kn);
    for j=1:(kn)
        T(i,j)=ChN(j);
    end
end
error = Lagrange_Polynomial(k,T,y,x,s,ox,a,b);
hold on;
for j=1:s
    y1(j)=(subs(y,x,ox(j)));
end
plot(ox, y1, '-.', 'DisplayName', 'Function');
title("Lagrange interpolation for Chebyshev nodes");
hold off;
%}


%FUNCTIONS
%Lagrange Polynomial with av_error for s points for each number of nodes
function error = Lagrange_Polynomial(k,T,y,x,s,ox,a,b)
    figure;
    ylabel('y');
    xlabel('x');
    axis([a, b -1.6 1.6]);
    grid on;
    l=length(k);
    error=zeros(l,1);
    for i=1:l
        LaPoly=0;
        f=zeros(l,1);     %vector of f's - value of function y(x) for nodes
        z=zeros(l,1);     %vector of z's - nodes from Table T(i,j)
        kn = k(i);      %number of nodes
        fprintf('\tNodes: %u\n', kn)
        for j=1:kn
            z(j)=T(i,j);
            f(j)=subs(y,x,z(j));
        end
        for j=1:kn
            p=1;
            for m=1:kn
                if j~= m
                    p = p*(x-z(m))/(z(j)-z(m));
                end
            end
            LaPoly =  LaPoly + f(j)*p;
        end
        fLP = zeros(s,1); %subs x for LaPoly
        y1 = zeros(s,1);    %function
        yLD = zeros(s,1); %function and poly difference
        err1=0;
        for j=1:s
            LPev=subs(LaPoly, x, ox(j));
            fLP(j)=LPev;
            y1(j)=(subs(y,x,ox(j)));
        end
        for j=1:s
            m=abs(y1(j)-fLP(j));
            yLD(j)=m;
            err1=err1+(m);
        end
        hold on;
        txt1 = ['Interpolation for k = ',num2str(i)];
        txt2 = ['Error for k = ',num2str(i)];
        h=plot(ox,fLP, ...
            ox,yLD, '--');
        set(h,{'DisplayName'},{txt1;txt2});
        hold off;
        legend('location','bestoutside');
        error(i)=err1/s;
        fprintf('\t\tError: %u\n', error(i));
    end
end

%{
%Chebyshev nodes
function ChN = Chebyshev_nodes(a,b,kn)
    n=kn-1;
    ChN=[];
    for j=0:n
        xk=((b-a)/2)*cos(((2*j+1)/(2*n+2))*pi)+((b+a)/2);
        ChN(end+1)=xk;
    end
end
%}