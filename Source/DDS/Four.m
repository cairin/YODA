f=[];
L=4;
for i=-L:L
    if(i<-2)||(i>2)
        f(i+L+1)=0;
    else
        f(i+L+1)=1;
    end
end

a=[];
b=[];
for k=0:16
    fun= @(x) cos(k*pi*x/L)/L;
    a(k+1) = integral(f.*fun,-L,L);
end
for k=1:16
    fun= @(x) f(x)*sin(k*pi*x/L)/L;
    b(k) = integral(f.*fun,-L,L);
end

