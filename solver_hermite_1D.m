%initialisation des constantes
w=2;
delta=0.01;
N=200;
a=10;
Xe=2*a/N;
Fe=N/(2*a);

% vecteur spatial
x=linspace(-a,a,N);

% condition initiale
s=hermite(x,1,10);

% vecteur temporel
t=0:delta:10;

%Fréquences
F=linspace(-Fe/2,Fe/2,N+1);
L=F(1:end-1);

%initialisation de psi
psi=[s;zeros(length(t)-1,N)];
for i=1:length(t)-1
	S=dfourier(psi(i,:),N,Xe); 
	b=(exp(-0.5*j*w*delta*(2*pi.*L).*(2*pi*L))).*S; 
	u=difourier(b,N,Xe); 
	v=(exp(-0.5*j*w*delta*(x.^2))).*u; 
	psi(i+1,:)=v;
end;

% Représentation graphique
figure(2);
mesh(abs(psi).^2);
title('Propagation de la CL de 10 fonctions de Hermite'); xlabel('Vecteur spatial x');
ylabel('Vecteur temporel');
