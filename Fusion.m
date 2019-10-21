%***** L'ensemble de d?finition Omega ******
omega =[1,2,3,4,5,6];

%******* Les probabilit?s a priori *********
p_de_omega = [1/6,1/6,1/6,1/6,1/6,1/6];

%*** les entr?es : nombre de points de C1 et C2 ***%
x=0;
y=3;

%****   mat_A repr?sente l'intersection de capture1 et capture2   ****
%****   les colonnes : nombre de points du capture 1  *****
%****   les lignes   : nombre de points du capture 2  *****
mat_A = [0 1;
         2 3;
         4 5;
         6 0];
     
%****   Combinaison mesure-mesure ****
%*** dist_vrais_C1 : distribution de vraissemblance P(xPt/Fi) pour le capture 1 ***
%*** dist_vrais_C2 : distribution de vraissemblance P(xPt/Fi) pour le capture 2 ***
dist_vrais_C1 = [0 1;
                 1 0;
                 0 1;
                 1 0;
                 0 1;
                 1 0];
             
dist_vrais_C2 = [1 0 0 0;
                 0 1 0 0;
                 0 1 0 0;
                 0 0 1 0;
                 0 0 1 0;
                 0 0 0 1];
             
%*** les lignes : les faces F1,...,F6 ***
%*** les colonnes : les combinnaisons (0Pt1,0Pt2),(0Pt1,1Pt2),...,(1Pt1,4Pt2)
Vxy_Fi = zeros(6,8); 
for i=1:6
    for j=1:4
        Vxy_Fi(i,j) = dist_vrais_C1(i,1)*dist_vrais_C2(i,j);
    end
    for j=5:8
        Vxy_Fi(i,j) = dist_vrais_C1(i,2)*dist_vrais_C2(i,j-4);
    end
end

%*** d?cision bas?e sur le maximum de vraissemblance ***
d=Decision_MV(x,y,Vxy_Fi)

% ----------------------------------------------------------------

%***** Combinaison modele-mesure *****

%**** Pfi_x = P(Fi/x)
PFi_x = zeros(2,6);
Px=[1/2,1/2];
for i=1:2
    for j=1:6
       PFi_x(i,j)=(dist_vrais_C1(j,i)*p_de_omega(j))/Px(i);
    end
end

%***** Py_x = P(y/x) ******
Py_x=[ 0 , 1/3 , 1/3 ,1/3 ;
      1/3 , 1/3 , 1/3, 0 ];
  
%**** PFi_xy = P(Fi/x,y) ***** 
PFi_xy=zeros(8,6);
for i=1 : 4
    for j=1:6
        PFi_xy(i,j)=(PFi_x(1,j)*dist_vrais_C2(j,i))/Py_x(1,i);
    end
end
for i=5 : 8
    for j=1:6
        PFi_xy(i,j)=(PFi_x(2,j)*dist_vrais_C2(j,i-4))/Py_x(2,i-4);
    end
end

%*** D?cision bas?e sur Maximum de postriori ****
d=Decision_Pos(x,y,PFi_xy)
