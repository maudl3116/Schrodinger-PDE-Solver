function s = hermitexy(x,alpha)
	
	%Utile
	N=length(x);
	e=zeros(N,N);
	for i=1:N
		for j=1:N
			e(i,j)=exp(-0.5*(x(i)^2))*exp(-0.5*(x(j)^2));
		end 
	end
	
	% polynômes de Hermites non normalisés 1D "vectoriels"
	H=zeros(10,N);
	H(1,:)=ones(1,N);
	H(2,:)=2*x;
	H(3,:)=4*(x.^2)-2;
	H(4,:)=8*(x.^3)-12*x;
	H(5,:)=16*(x.^4)-48*(x.^2)+12;
	H(6,:)=32*(x.^5)-160*(x.^3)+120*x; 
	H(7,:)=64*(x.^6)-480*(x.^4)+720*(x.^2)-120; 
	H(8,:)=128*(x.^7)-1344*(x.^5)+3360*(x.^3)-1680*x; 
	H(9,:)=256*(x.^8)-3584*(x.^6)+13440*(x.^4)-13440*(x.^2)+1680; 
	H(10,:)=512*(x.^9)-9216*(x.^7)+48384*(x.^5)-80640*(x.^3)+30240*x;
	
	%formation des polynomes 2D "matriciels" H(i,j)(x,y) %Initialisation d'une matrice pour ranger tous les H(i,j)(x,y) Q=zeros(10*N,10*N);
	for m=1:10
		for n=1:10
			for i=1:N
				for j=1:N Q(N*(m-1)+i,N*(n-1)+j)=H(m,i)*H(n,j);
				end
			end 
		end
	end
	
	%somme des polynomes dans s
	
	%initialisation de s
	s=zeros(N,N);
	
	%Formation des H(0,n!=0)(x,y), on est obligé de faire ceci à part, à cause %de factorial(0)
	for n=2:10
		c0=exp(-0.5*(abs(alpha).^2)); 
		cn=exp(-0.5*(abs(alpha).^2))*((alpha^(n-1))/sqrt(factorial(n-1))); 
		norm0=(sqrt(pi)).^(-1/2); 
		normn=((2.^(n-1))*(factorial(n-1))*sqrt(pi)).^(-0.5);
		norm2=c0*cn*norm0*normn; 
		hermiten=Q(1:N,N*(n-1)+1:N*(n));
		s=s+(norm2*hermiten);
	end;
	
	%Formation des H(m!=0,0)(x,y), on est obligé de faire ceci à part, à cause %de factorial(0)
	for m=2:10 
		cm=(exp(-0.5*abs(alpha).^2))*((alpha^(m-1))/sqrt(factorial((m-1)))); 
		c0=exp(-0.5*(abs(alpha).^2)); 
		normm=((2.^(m-1))*(factorial(m-1))*sqrt(pi)).^(-0.5); 
		norm0=(sqrt(pi)).^(-1/2);
		norm2=cm*c0*normm*norm0; 
		hermiten=Q((N*(m-1))+1:N*(m),1:N);
		s=s+(norm2*hermiten);
	end;
	
	%ajout de H(0,0)(x,y)
	c0=(exp(-0.5*abs(alpha).^2));
	norm0=(sqrt(pi)).^(-1/2);
	norm00=c0*c0*norm0*norm0;
	s=s+norm00*Q(1:N,1:N);
	
	% Formation des autres termes de la somme, H(m!=0,n!=0)
	for n=1:9
		for m=1:9
			cn=(exp(-0.5*abs(alpha).^2)).*((alpha^n)/sqrt(factorial(n))); 
			cm=(exp(-0.5*abs(alpha).^2)).*((alpha^m)/sqrt(factorial(m))); 
			normm=((2.^m)*(factorial(m))*sqrt(pi)).^(-1/2); 
			normn=((2.^n)*(factorial(n))*sqrt(pi)).^(-1/2);
			norm2=cn*cm*normm*normn;
			hermiten=Q(N*(m)+1:N*(m+1),N*(n)+1:N*(n+1)); %attention, on ne prend que les polynomes de Q, sans de H(0,...)
			s=s+(norm2.*hermiten);
		end 
	end
	%Multiplication par la gaussienne 2D, créée au début
	s=s.*e;
end
