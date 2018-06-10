function M = solutionexacte( x,alpha,nbiter,w,t)
	
	% Utile
	N=length(x);
	g=exp(-0.5*(x.*x));
	delta=0.01;
	
	% Fonctions de Hermites non normalisées (on évite de faire des dérivées sur Matlab
	G(1,:)=2*x;
	G(2,:)=4*(x.^2)-2;
	G(3,:)=8*(x.^3)-12*x;
	G(4,:)=16*(x.^4)-48*(x.^2)+12; 
	G(5,:)=32*(x.^5)-160*(x.^3)+120*x; 
	G(6,:)=64*(x.^6)-480*(x.^4)+720*(x.^2)-120; 
	G(7,:)=128*(x.^7)-1344*(x.^5)+3360*(x.^3)-1680*x; 
	G(8,:)=256*(x.^8)-3584*(x.^6)+13440*(x.^4)-13440*(x.^2)+1680; 
	G(9,:)=512*(x.^9)-9216*(x.^7)+48384*(x.^5)-80640*(x.^3)+30240*x;
	
	M=zeros(length(t),N);
	
	for k=1:length(t) 
	
		c0=exp(-0.5*(abs(alpha).^2)); 
		hermite=1;
		a=(sqrt(pi)).^(-0.5);
		energie=exp(-1i*w*(0.5)*k*delta);
		s=(a*(c0.*hermite).*g).*energie;
		M(k,:)=s;
	
		for n=1:nbiter-1
			cn=(exp(-0.5*abs(alpha).^2)).*((alpha^n)/sqrt(factorial(n))); 
			energie=exp(-1i*w*(n+0.5)*delta*k); 
			norm=((2.^n)*(factorial(n))*(sqrt(pi)))^(-1/2);
			norm2=norm*g;
			hermiten=G(n,:);
			M(k,:)=M(k,:)+(norm2.*(cn.*hermiten).*energie);
		end 
	end
	
end
