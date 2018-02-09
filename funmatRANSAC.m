%funmatRANSAC    Matriu Fonemantal amb el metode Random Sampling (RANSAC)
%    [F] = funmatRANSAC(M,b,P,ep) 
%
%    M matriu de 4-per-7 amb les coordendes de 7 punts en dues imatges
%        primera fila: coordenada x de la primera imatge
%        segona fila:  coordenada y de la primera imatge
%        tercera fila: coordenada x de la segona imatge
%        quarta fila:  coordenada y de la segona imatge
%    b  buckets
%    P  probabilitat que hi hagui un F sense outliers
%    ep ratio d'ouliers
%
%    F matriu fonamental de 3-per-3 amb l'origen de coordenades del món a la segona camera
%
% by X. Armangue
% (c) Mr3D - University of Girona, September 2002
%
function [F]=funmatRANSAC(M,b,P,ep)

if (size(M,1)~=4) | (size(M,2)<8),
   disp('Error: parametres incorrectes')
else
   maxx1=max(M(1,:));
   minx1=min(M(1,:));
   bx1=maxx1-minx1;
   maxy1=max(M(2,:));
   miny1=min(M(2,:));
   by1=maxy1-miny1;
   
   bucket=zeros(2,b*b);
   pointb=[];
   
   for i=1:size(M,2),
      bucketx=fix((M(1,i)-minx1)*b/bx1);
      if bucketx==b,
         bucketx=b-1;
      end
      buckety=fix((M(2,i)-miny1)*b/by1);
      if buckety==b,
         buckety=b-1;
      end      
      pointb(i)=b*buckety+bucketx+1;
      bucket(1,pointb(i))=bucket(1,pointb(i))+1;
      bucket(2,pointb(i))=0;
   end
   
   
   mat=round(log(1-P)/log(1-(1-ep)^7));
   FF=[];
   for inf=1:mat,
		for i=1:b*b,
      	bucket(2,i)=0;
      end;
	   Mtemp=[];
	   for i=1:7,
	      bo=0;
	      while bo==0,
	         inpu=fix(rand(1,1)*size(M,2)+1);
	         if inpu==size(M,2)+1,
	            inpu=size(M,2);
	         end         
	            
            if (bucket(2,pointb(inpu))==0) & (bucket(1,pointb(inpu))>0),
               bucket(2,pointb(inpu))=1;
               Mtemp=[Mtemp M(:,inpu)];
               bo=1;
            end            
   	   end
	   end            
      FF(:,:,inf)=funmat7p(Mtemp);
      F=FF(:,:,inf);
      for i=1:size(M,2),
         r(i)=[M(1:2,i) ; 1]'*F*[M(3:4,i) ; 1];
         x1=M(1,i);
         y1=M(2,i);
         x2=M(3,i);
         y2=M(4,i);
         rx2=F(1,1)*x1+F(2,1)*y1+F(3,1);
         ry2=F(1,2)*x1+F(2,2)*y1+F(3,2);
         rx1=F(1,1)*x2+F(1,2)*y2+F(1,3);
         ry1=F(2,1)*x2+F(2,2)*y2+F(2,3);
         w(i)=sqrt(1/(rx2^2+ry2^2+rx1^2+ry1^2));
         d(i)=w(i)*r(i);
      end;
      
      sig=1.4826*(1+5/(size(M,2)-7))*sqrt(median(abs(d)));
      
      for i=1:size(M,2),
         if abs(d(i))<1.96*sig,
            ga(i,inf)=1;
         else
            ga(i,inf)=0;
         end
      end
      inliers(inf)=sum(ga(:,inf));
      sigma(inf)=std(d);      
   end
   
   inlm=max(inliers);
   sigmaact=max(sigma);
   for i=1:size(inliers,2),
      if inliers(i)==inlm,
         if sigma(i)<sigmaact,
            inli=i;
            sigmaact=sigma(i);
         end
      end
   end
   
   F=FF(:,:,inli);
   ww=ga(:,inli)';
   
   U=[];
   for i=1:size(M,2),
      if ww(i)~=0,
         U=[U; M(1,i)*M(3,i) M(1,i)*M(4,i) M(1,i) M(2,i)*M(3,i) M(2,i)*M(4,i) M(2,i) M(3,i) M(4,i) 1];
      end      
	end
	
	[V,D]=eig(U'*U);
     
   [minim,ind]=min(sum(D));
   f=V(:,ind);
	
   F=[f(1) f(2) f(3); f(4) f(5) f(6); f(7) f(8) f(9)];
end
