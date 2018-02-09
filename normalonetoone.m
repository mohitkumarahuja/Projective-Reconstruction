%normal   normalització de les dades d'entrada entre [-1,1]
%    [Mout,T1,T2] = normal(M) 
%
%    M matriu de 4-per-n amb les coordendes de n punts en dues imatges
%      on n és mes gran o igual que 7
%        primera fila: coordenada x de la primera imatge
%        segona fila:  coordenada y de la primera imatge
%        tercera fila: coordenada x de la segona imatge
%        quarta fila:  coordenada y de la segona imatge
%
%    Mout matriu de 4-per-n amb les coordendes normalitzades entre [-1,1]
%		 de n punts en dues imatges on n és mes gran o igual que 7
%        primera fila: coordenada x de la primera imatge
%        segona fila:  coordenada y de la primera imatge
%        tercera fila: coordenada x de la segona imatge
%        quarta fila:  coordenada y de la segona imatge
%
% by X. Armangue
% (c) Mr3D - University of Girona, September 2002
%
function [Mout,T1,T2] = normal(M)

if (size(M,1)~=4) | (size(M,2)<7),
   disp('Error: parametres incorrectes')
else
	maxx1=max(M(1,:));
	maxy1=max(M(2,:));
	maxx2=max(M(3,:));
	maxy2=max(M(4,:));
	minx1=min(M(1,:));
	miny1=min(M(2,:));
	minx2=min(M(3,:));
   miny2=min(M(4,:));
   
   Mout(1,:)=(2/(maxx1-minx1)).*(M(1,:)-minx1)-1;
   Mout(2,:)=(2/(maxy1-miny1)).*(M(2,:)-miny1)-1;
   Mout(3,:)=(2/(maxx2-minx2)).*(M(3,:)-minx2)-1;
   Mout(4,:)=(2/(maxy2-miny2)).*(M(4,:)-miny2)-1;
   
   T1=[2/(maxx1-minx1) 0 -(2/(maxx1-minx1)*minx1+1); 0 2/(maxy1-miny1) -(2/(maxy1-miny1)*miny1+1); 0 0 1];
   T2=[2/(maxx2-minx2) 0 -(2/(maxx2-minx2)*minx2+1); 0 2/(maxy2-miny2) -(2/(maxy2-miny2)*miny2+1); 0 0 1];
end
