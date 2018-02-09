%normal   normalització de les dades d'entrada segons Hartley
%    [Mout,T1,T2] = normal(M) 
%
%    M matriu de 4-per-n amb les coordendes de n punts en dues imatges
%      on n és mes gran o igual que 8
%        primera fila: coordenada x de la primera imatge
%        segona fila:  coordenada y de la primera imatge
%        tercera fila: coordenada x de la segona imatge
%        quarta fila:  coordenada y de la segona imatge
%
%    Mout matriu de 4-per-n amb les coordendes normalitzades entre [-1,1]
%		 de n punts en dues imatges on n és mes gran o igual que 8
%        primera fila: coordenada x de la primera imatge
%        segona fila:  coordenada y de la primera imatge
%        tercera fila: coordenada x de la segona imatge
%        quarta fila:  coordenada y de la segona imatge
%
% by X. Armangue
% (c) Mr3D - University of Girona, September 2002
%
function [Mout,T1,T2] = normalHartley(M)

if (size(M,1)~=4) | (size(M,2)<8),
    disp('Error: parametres incorrectes')
else
    cx1=sum(M(1,:))/size(M,2);
    cy1=sum(M(2,:))/size(M,2);
    cx2=sum(M(3,:))/size(M,2);
    cy2=sum(M(4,:))/size(M,2);
    
    dx1=M(1,:)-cx1;
    dy1=M(2,:)-cy1;
    dx2=M(3,:)-cx2;
    dy2=M(4,:)-cy2;
    
    d1=sum((dx1.^2+dy1.^2).^(1/2))/size(M,2);
    d2=sum((dx2.^2+dy2.^2).^(1/2))/size(M,2);
    
    Mout(1,:)=sqrt(2)./d1.*(M(1,:)-cx1);
    Mout(2,:)=sqrt(2)./d1.*(M(2,:)-cy1);
    
    Mout(3,:)=sqrt(2)./d2.*(M(3,:)-cx2);
    Mout(4,:)=sqrt(2)./d2.*(M(4,:)-cy2);
    
    T1=[sqrt(2)/d1 0 -(sqrt(2)/d1*cx1); 0 sqrt(2)/d1 -(sqrt(2)/d1*cy1); 0 0 1];
    T2=[sqrt(2)/d2 0 -(sqrt(2)/d2*cx2); 0 sqrt(2)/d2 -(sqrt(2)/d2*cy2); 0 0 1];
end
