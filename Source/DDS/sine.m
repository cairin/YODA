x=[];
f=fopen('sine2.txt','w');

for i=0:4095 
    x(i+1) = floor(511*sin(i*2*pi/4096)+512);
  %  fprintf('sine.txt', '%u',x(i+1));
    fprintf( f,'%d%c\n',x(i+1),',');
end

plot(x);