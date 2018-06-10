%initialisation of constants
w=40;
delta=0.007;
N=2^8;
a=N/20;
Xe=2*a/N;
Fe=N/(2*a);

% spatial vector
x=linspace(-a,a,N);

% initial condition
s=exp(-0.2*pi.*((x-4*Xe).^2));

% time vector
t=0:delta:1;

%Frequency vector
F=linspace(-Fe/2,Fe/2,N+1);
L=F(1:end-1);

%initialisation of psi
psi=[s;zeros(length(t)-1,N)];
for i=1:length(t)-1
	S=fourierc(psi(i,:),N,a); 
	b=(exp(-0.5*j*w*delta*(2*pi.*L).*(2*pi*L))).*S; 
	u=ifourierc(b,N,a);
	v=(exp(-0.5*j*w*delta*(x.^2))).*u; psi(i+1,:)=v;
end;

figure(6);
surf(abs(psi)); 
title('propagation de s=exp(-0.2*pi.*((x-4*Xe).^2))') 
xlabel('vecteur spatial x');
ylabel('vecteur temporel t');
zlabel('psi(x,t)');
axis([25 225 0 142 0 5])
