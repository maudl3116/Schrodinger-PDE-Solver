clc;
clear all;
close all;

%initialisation of constants
w=20;
delta=0.01;
N=200;
a=10;
Xe=2*a/N;
Fe=N/(2*a);

% spatial vector x, (y would be the same)
x=linspace(-a,a,N);

% initial condition
S=hermitexy(x,1);

% time vector
t=0:delta:10;

%matrix of frequencies exp(-iw/2*freq2*delta)
Lx=linspace(-Fe/2,Fe/2,N+1);
Lx=Lx(1:end-1);
Ly=linspace(-Fe/2,Fe/2,N+1);
Ly=Ly(1:end-1);
const=(2*pi)^2;
Mfreq=zeros(N,N);

for m=1:N
	for n=1:N 
		Mfreq(m,n)=exp(-0.5*1i*w*delta*const*(Lx(m).^2)).*exp(-0.5*1i*w*delta*const*(Ly(n).^2));
	end 
end

%matrix of  exp(-iw/2*spatial2*delta)
Mspat=zeros(N,N);
for m=1:N
	for n=1:N
		Mspat(m,n)=exp(-0.5*1i*w*delta*(x(m)^2)).*exp(-0.5*1i*w*delta*(y(n)^2));
	end 
end

%initialization
mat=ones(N,N*(length(t)-1));
mat(1:N,1:N)=S;

%BPM
for k=1:length(t)-1 
	fourier=fourier2D(mat(1:N,N*(k-1)+1:N*(k)),N,Xe); 
	b=Mfreq.*fourier;
	u=ifourier2D(b,N,Xe);
	v=Mspat.*u;
	mat(1:N,N*k+1:N*(k+1))=v;
end;

%Animation
aviobj = avifile('BPMH2D7.avi');
fig = figure;
for k=1:50
    figure(k);
	mesh(abs(mat(:,(k-1)*N+1:k*N)).^2);
	axis([60 160 60 160 0 0.5]); 
	drawnow
    M(k) = getframe(figure(k));
    aviobj = addframe(aviobj,M(k));
end
close(fig);
aviobj = close(aviobj);
movie(M);
