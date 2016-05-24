%Constants
Amp=1;
T=4;
w0=2*pi/T;
n=16;
A=[];
B=[];
a=[];
b=[];
f=[];


%===========================Square Wave=========================
% a0=0;
% for i=1:n
%     sq = @(x) (Amp*square(x)).*sin(i*x);
%     a(i)=0;
%     b(i)=(1/pi)*(integral(sq, -pi,pi));    
% end



%===========================Sawtooth Wave=========================

a0=0;
for i=1:n
    fun2 = @(x) (Amp*sawtooth(x)).*sin(i*x);
    a(i)=0;
    b(i)=(1/pi)*(integral(fun2, -pi,pi));
end
%===========================tri Wave=========================
% 
% tr = @(x)sawtooth(x, 0.5);  % 0.5 specify a symmetric triangular shape
% 
% a0=(1/pi)*(integral(tr, -pi,pi))
% for i=1:n
%     fun1 = @(x) (sawtooth(x, 0.5).*cos(i*x));
%     a(i)=(1/pi)*(integral(fun1, -pi,pi));
%     
%     fun2 = @(x) (sawtooth(x, 0.5).*sin(i*x));
%     b(i)=(1/pi)*(integral(fun2, -pi,pi));
% end
% a
% b
%===========================Summation=========================
a
b
for j=0:100
    for i=1:n
        A(i)=a(i)*cos(i*j*2*pi/50);
        B(i)=b(i)*sin(i*j*2*pi/50);
    end
    f(j+1)=0.5*a0+sum(A)+sum(B);
end
plot(f);


% for i=1:n
%     s = @(x) sin(i*x);
%     c = @(x) cos(i*x);
%     func = @(x) b(i)*s+a(i)*c;
% end


% h=integral(fun,0,50)
% plot(fun(x));
% ylim([-1.5 1.5]);
% grid on; 

38196



