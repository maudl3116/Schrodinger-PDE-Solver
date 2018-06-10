function s = hermite( x,alpha,nbiter )

	% Souvent réutilisés
	N=length(x);
	e=exp(-0.5*(x.*x));
	
	% Formation du premier terme de la somme
	c0=exp(-0.5*(abs(alpha).^2));
	hermite=1;
	a=(pi^0.5)^(-0.5)
	s=a*(c0.*hermite).*e;
	
	% Fonctions de Hermites non normalisées
	G=zeros(10,N);
	G(1,:)=2*x;
	G(2,:)=4*(x.^2)-2;
	G(3,:)=8*(x.^3)-12*x;
	G(4,:)=16*(x.^4)-48*(x.^2)+12; 
	G(5,:)=32*(x.^5)-160*(x.^3)+120*x; 
	G(6,:)=64*(x.^6)-480*(x.^4)+720*(x.^2)-120; 
	G(7,:)=128*(x.^7)-1344*(x.^5)+3360*(x.^3)-1680*x; 
	G(8,:)=256*(x.^8)-3584*(x.^6)+13440*(x.^4)-13440*(x.^2)+1680; 
	G(9,:)=512*(x.^9)-9216*(x.^7)+48384*(x.^5)-80640*(x.^3)+30240*x;
	
	% Formation des autres termes de la somme
	for n=1:nbiter-1
		cn=(exp(-0.5*abs(alpha).^2)).*((alpha^n)/sqrt(factorial(n))); 
		norm=((2.^n)*(factorial(n))*(sqrt(pi))).^(-1/2); 
		norm2=norm*e;
		hermiten=G(n,:);
		s=s+(norm2.*(cn.*hermiten));
	end;
	
	% Représentation de la fonction obtenue
	figure(1)
	plot(x,abs(s),'b')
	title('CL des fonctions de Hermites')
	
end
