function [ indice ] = Decision_MV(x,y,Vxy_Fi)

[n,m]=size(Vxy_Fi);
indice=-1;
max=0;
for i=1 : n
       if(Vxy_Fi(i,x*4+y+1)>max)
           max=Vxy_Fi(i,x*4+y+1);
           indice=i;
       end
end   
end
