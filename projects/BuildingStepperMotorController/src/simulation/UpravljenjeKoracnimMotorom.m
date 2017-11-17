function varargout = UpravljenjeKoracnimMotorom(varargin)
%
%----------------------------------------------------------------------------------------------
%
% UpravljanjeKoracnimMotorom.m je m-file za istoimenu aplikaciju
% namjenjenu za upravljanje dvofaznim bipolarnim koracnim motorima.
% Aplikacija ja razvijena u okviru zavrsnog rada pod temom "Gradnja sistema
% upravljanja koracnim motorom" ciji je realizator Hodzic Faris.
%
%									 maj 2008. godine
%---------------------------------------------------------------------------------------------

% *** Pocetak incijalizacijskog koda - NE VRSITI IZMJENE
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UpravljenjeKoracnimMotorom_OpeningFcn, ...
                   'gui_OutputFcn',  @UpravljenjeKoracnimMotorom_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% *** Kraj incijalizacijskog koda

% --- Funkcija pri otvaranju aplikacije
function UpravljenjeKoracnimMotorom_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);

function varargout = UpravljenjeKoracnimMotorom_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;

%Sljedeæe dvije funkcije su definisane za polje namjenjeno za ispis
%maksimalne struje koja je odredena testiranjem motora
function tstruja_Callback(hObject, eventdata, handles)

function tstruja_CreateFcn(hObject, eventdata, handles)
    if ispc
        set(hObject,'BackgroundColor','white');
    else
        set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
    end

%Sljedeæe dvije funkcije su definisane za polje namjenjeno za ispis
%maksimalne brzine koracanja koja je odredena testiranjem motora
function tbrzina_Callback(hObject, eventdata, handles)

function tbrzina_CreateFcn(hObject, eventdata, handles)
    if ispc
        set(hObject,'BackgroundColor','white');
    else
        set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
    end

% *Prvim otvaranjem aplikacije preporucljivo je da se izvrsi testiranje
% motora. To se obavlja pritiskom na tipku TEST
function test_Callback(hObject, eventdata, handles)
    global s1;
    odgovor=komanda(s1,'1','1','00000','00000');
    %Poslata je instrukcija mikrokontroleru da izvrsi tetiranje motora
    set(handles.tstruja,'String',5*odgovor(1,1)/255);
    %Ispisuje se vrijednost maksimalne struje dobijene testiranjem u predviden prostor
    %Mikrokontroler je takoder poslao vrijednost o minimalnom vremenu koje
    %protekna pri pravljenju jednog koraka. Poslata informacija se sastoji
    %od dva 8-bitna znaka
    bb0=num2str(dec2bin(odgovor(1,2)));
    bb1=num2str(dec2bin(odgovor(1,3)));
    bb=strcat(bb1,bb0);
    %Od dva osmobitna znaka pravi se jedan decimalni broj
    b=bin2dec(bb);
    set(handles.tbrzina,'String',int32(60000/b));
    %Proracuna se maksimalna brzina i ispise u predviden prostor
%Kraj funkcije

%Sljedeca funkcija ima zadatak da prikupi informaciju o broju koraka koje
%treba da napravi koracni motor.
function Koraci=koraci_Callback(hObject, eventdata, handles)
    Koraci=get(handles.koraci,'String');
    %Broj koraka se krece u opsegu od 0 do 99 999.
    switch size(Koraci,2)
        case 1
            Koraci=strcat('0000',Koraci);
        case 2
            Koraci=strcat('000',Koraci);
        case 3
            Koraci=strcat('00',Koraci);
        case 4
            Koraci=strcat('0',Koraci);
        case 5
            Koraci=Koraci;
        otherwise 
            Koraci='00000';
    end

function koraci_CreateFcn(hObject, eventdata, handles)
    if ispc
        set(hObject,'BackgroundColor','white');
    else
        set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
    end
%Kraj funkcije

%Sljedeca funkcija ima zadatak da prikupi informaciju o brzini kojom treba
%da koraca motor
function Brzina=brzina_Callback(hObject, eventdata, handles)
    Brzina=get(handles.brzina,'String');
    switch size(Brzina,2)
        case 1
            Brzina=strcat('0000',Brzina);
        case 2
            Brzina=strcat('000',Brzina);
        case 3
            Brzina=strcat('00',Brzina);
        case 4
            Brzina=strcat('0',Brzina);
        case 5
            Brzina=Brzina;
        otherwise 
            Brzina='00000';
    end

function brzina_CreateFcn(hObject, eventdata, handles)
    if ispc
        set(hObject,'BackgroundColor','white');
    else
        set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
    end
%Kraj funkcije

%Pritiskom n dugme START raèunar salje instrukcije mikrokontroleru koje je
%postavio korisnik aplikacije.
function start_Callback(hObject, eventdata, handles)
    %s1 vec incijalizovani serijski port
    global s1;
    %Poziva se funkcija za ocitavanja zadatog broja koraka
    Koraci=koraci_Callback(hObject, eventdata, handles);
    %Poziva se funkcija za ocitavanja zadate brzine vrtnje
    Brzina=brzina_Callback(hObject, eventdata, handles);
    %Ocitava se zadati smjer vrtnje
    Smjer1=get(handles.smjer1,'Value');
    Smjer2=get(handles.smjer2,'Value');
    if Smjer1==1
        Smjer='1';
    else 
        Smjer='2';
    end
    %Poziva se funkcija komanda koja je zaduzena za komunikaciju sa
	%mikrokontrolerom
    komanda(s1,'2',Smjer,Koraci,Brzina);
%Kraj funkcije

%Pritiskom na dugme STOP prekidaju se trenutne radnje koje je obavljao
%mikrokontroler
function stop_Callback(hObject, eventdata, handles)
global s1;
komanda(s1,'3','1','00000','00000');
%mikrokontroleru se salje narednba za zaustavljanje rad=3

%Sljedeca funkcija sluzi za ocitanje stanja za dugme smjer1
function Smjer1=smjer1_Callback(hObject, eventdata, handles)
Smjer1=get(handles.smjer1,'Value');

%Sljedeca funkcija sluzi za ocitanje stanja za dugme smjer2
function Smjer2=smjer2_Callback(hObject, eventdata, handles)
Smjer2=get(handles.smjer2,'Value');

%KRAJ!!!
