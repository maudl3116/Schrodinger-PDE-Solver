	function varargout = choixinterface(varargin)

gui_Singleton = 1;
gui_State = struct( 'gui_Name', mfilename, ...
					'gui_Singleton', gui_Singleton, ... 
					'gui_OpeningFcn', @choixinterface_OpeningFcn, ... 
					'gui_OutputFcn', @choixinterface_OutputFcn, ... 
					'gui_LayoutFcn', [], ...
					'gui_Callback', []);
					
if nargin && ischar(varargin{1}) 
	gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
	[varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
	gui_mainfcn(gui_State, varargin{:});
end

	function choixinterface_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);
X = imread('schro.jpg', 'jpg'); % Charge l'image de fond

ax = axes('Units', 'Normalized', 'Position', [0 0 1 1]); % Création d'un objet Axes prenant toute la fenêtreimagesc(X, 'Parent', ax) % Affiche l'image
uistack(ax, 'bottom') % Place l'objet Axes en arrière-plan
set(ax, 'Visible', 'off') % Cache les marques "ticks"
text(100,20,'\fontname{Arial}\fontsize{20}\bf Représentation graphique de la propagation de votre condition initiale');
text(70,80,'\fontname{Arial}\fontsize{12}\bf\bullet Entrez votre condition initiale f(x)');
text(250,90,'\fontname{Arial}\fontsize{12}\bf\bullet Pulsation \omega');
text(70,175,'\fontname{Arial}\fontsize{12}\bf\bullet Vecteur spatial x');
text(200,175,'\fontname{Arial}\fontsize{12}\bf\bullet Vecteur temporel t');
text(70,220,'\fontname{Arial}\fontsize{9}\bf Nombre de points'); 
text(70,250,'\fontname{Arial}\fontsize{9}\bf Longueur du vecteur'); 
text(200,220,'\fontname{Arial}\fontsize{9}\bf Durée observation');
text(200,250,'\fontname{Arial}\fontsize{9}\bf Pas temporel');

	function pushbutton1_Callback(hObject, eventdata, handles)

a= str2double(get(handles.textachoix, 'string')); 
N=str2double(get(handles.textNchoix, 'string')); 
b=a/2;
x=linspace(-b,b,N);

chaine=get(handles.textf, 'string');

f = eval(chaine) ; %calcul de f(x) 
tmax=str2double(get(handles.texttmaxchoix, 'string'));
w=str2double(get(handles.textwchoix, 'string'));
delta=str2double(get(handles.textdeltachoix, 'string')); 
t=0:delta:tmax;
b=a/2;
psi=BPM1Dchoix(b,N,w,delta,tmax,f);
axes(handles.axes1)
opengl software %trouvé sur internet, car sinon le texte se renversait 
mesh(x,t,abs(psi).^2);
title('\fontname{Arial}\fontsize{12}\bf Propagation'); 
zlabel('\fontname{Arial}\fontsize{10}\bf abs(psi)2'); 
ylabel('\fontname{Arial}\fontsize{10}\bf temps '); 
xlabel('\fontname{Arial}\fontsize{10}\bf espace');

function textf_Callback(hObject, eventdata, handles) 

function textf_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'),get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end 

function textNchoix_Callback(hObject, eventdata, handles) 

function textNchoix_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'),get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white'); 
end

function textachoix_Callback(hObject, eventdata, handles) 

function textachoix_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white'); 
end

function pushbutton2_Callback(hObject, eventdata, handles) 

cla(handles.axes1);%permet d'effacer le graphique

function textdeltachoix_Callback(hObject, eventdata, handles)

function textdeltachoix_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white'); 
end

function textwchoix_Callback(hObject, eventdata, handles) 

function textwchoix_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end

function texttmaxchoix_Callback(hObject, eventdata, handles) 

function texttmaxchoix_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white'); 
end

function varargout = choixinterface_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function pushbutton3_Callback(hObject, eventdata, handles) 

cla(handles.axes2);

function pushbutton4_Callback(hObject, eventdata, handles) 
a= str2double(get(handles.textachoix, 'string')); 
N=str2double(get(handles.textNchoix, 'string'));
b=a/2;
x=linspace(-b,b,N);

chaine=get(handles.textf, 'string'); 

f= eval(chaine) ; %calcul de f(x)

axes(handles.axes2)

opengl software %solution trouvée sur http://www.mathworks.com/matlabcentral/newsreader/view_thread/243468, car sinon le texte se renversait !
plot(x,abs(f).^2,'linewidth',2);
title('\fontname{Arial}\fontsize{10}\bf Représentation du module au carré de la condition initiale');
ylabel('\fontname{Arial}\fontsize{10}\bf abs(psi(x,t=0)2'); 
xlabel('\fontname{Arial}\fontsize{10}\bf espace');

