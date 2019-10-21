function [ indice ] = Decision_Pos(x,y,Post)

[n,m]=size(Post);
indice=-1;

max=0;
for i=1 : m
       if(Post(x*4+y+1,i)>max)
           max=Post(x*4+y,i);
           indice=i;
       end
end   
end