function varargout = es_mi_lam_PID(varargin)
% ************************************************************************
% Univerzitet u Sarajevu
% Elektrotehnicki fakultet Sarajevo
% Inteligentno upravljanje
%
%   Tema: Odredjivanje parametara PID regulatora koristenjem evolucione
%                       strategije ES (mi, lamda)
%
%                           - Seminarski rad -
%
% Formirana aplikacija sluzi za odredjivanje optimalnih parametara PID
% regulatora koristenjem evolucione strategije ES (mi, lamda). Kod ove 
% verzija ESa se bira mi najboljih potomaka i prenosi u novu generaciju.
% Izbor najboljih potencijalnih rjesenja se vrsi samo iz skupa lamda.
% Ocigledno je da mora vrijediti 1<=mi<=lamda.Za definisanje pocetne 
% populacije koristi se Ziegler - Nicholsova metoda (za sisteme reda veceg 
% od 2), cetiri Chien-Hrones-Reswick metoda od kojih su dva za
% stabilizirajucu regulaciju, a dva za pratecu regulaciju (sve cetiri vaze 
% za sisteme reda viseg od 1), a za sisteme prvog reda se koristenjem
% generatora slucajnih varijabli incijaliziraju parametri.
% ------------------------------------------------------------------------
% Sarajevo, 28.01.2010.                        Autor: Hodzic Faris
% ------------------------------------------------------------------------

% NE MIJENJATI incijalizacioni kod
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @es_mi_lam_PID_OpeningFcn, ...
                   'gui_OutputFcn',  @es_mi_lam_PID_OutputFcn, ...
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
% Kraj incijalizacionog koda

% --- Sljedeci dio koda se izvrsava prije nego apliakcija postane vidljiva.
function es_mi_lam_PID_OpeningFcn(hObject, eventdata, handles, varargin)
%
handles.output = hObject;
% Incijalizacija varijabli
G=[];
X=[];
Kp=[];
Ti=[];
rad=[];
clc
disp('Molimo pricekajte pokretanje aplikacije ....')
% Update strukture GUIa
guidata(hObject, handles);

% --- Izlazi ove funkcije se vracaju u komandnu liniju.
function varargout = es_mi_lam_PID_OutputFcn(hObject, eventdata, handles) 
disp('Molimo pricekajte pokretanje aplikacije ....')
varargout{1} = handles.output;


function rjesenja_Callback(hObject, eventdata, handles)

function rjesenja_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
            'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    
function potomci_Callback(hObject, eventdata, handles)

function potomci_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
            'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    
function generacije_Callback(hObject, eventdata, handles)

function generacije_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
            'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function num=numerator_Callback(hObject, eventdata, handles)

function numerator_CreateFcn(hObject, eventdata, handles)

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
            'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function denumerator_Callback(hObject, eventdata, handles)

function denumerator_CreateFcn(hObject, eventdata, handles)

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
            'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function kriterij_Callback(hObject, eventdata, handles)

function kriterij_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
        'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Izvrsava se nakon klika na dugme "Odrediti parametre".
function racunaj_Callback(hObject, eventdata, handles)
% Koristenje globalnih varijabli
global G;   % Prenosna funkcija objekta
global X;   % Parametri PID regulatora dobijenih razlicitim metodama
            % X=[Kp Ti Td]'
% Prenosna funkcija PID regulatora je:
% PID=Kp(1+1/Tis+Tds)
% Prenosna funkcija objekta:
% G=num(s)/den(s);
global Kp;
global Ti;
global Td;
global rad;
% Uzimanje koeficijenata polinoma num i den
num=str2num(get(handles.numerator,'String')); 
den=str2num(get(handles.denumerator,'String'));
% Da bi sistem bio dinamicki potrebno da je polinom u nazivniku bar prvog
% reda
if size(den,2)<2
    msgbox('Greska pri unosu prenosne funkcije.','Greska','error')
    return
end
% Ako je red polinoma u brojniku veci od reda polinoma u nazivniku sistem
% nije fizikalan
if size(num,2)>size(den,2)
    msgbox('Red numeratora mora biti veci od reda denumeratora,da bi sistem bio fizikalan',...
        'Greska','error')
    return
end
% Pogresan unos koeficijenata polinoma prenosne funkcije objekta: prazne
% matrice, nisu brojevi, beskonacno veliki brojevi (Inf)
if(isempty(num)||isempty(den)||max(isnan(num))||max(isnan(den))||max(isinf(num))||max(isinf(num))) 
    msgbox('Pogresno unesena prenosna funkcija!','Greska','error')
    return
end
% Formiranje prenosne funkcije objekta
G=tf(num,den);
% Odredjivanje broja potencijalnih rjesenja, ujedno i velicine pocetne
% populacije
mi=str2double(get(handles.rjesenja,'String'));
% Velicina potencijalnih rjesneja ne smije biti broj manji od 1, ne smije
% biti prazna matrica, ne smije biti znak koji nije broj, ne smije biti 
% beskonacno (Inf)
if ((mi<1)||isempty(mi)|| max(isnan(mi)) || max(isinf(mi)))
    msgbox('Broj potencijalnih rjesenja mora biti cijeli pozitivan broj.',...
        'Greska','error')
    return
end
% Odredjivanje broja potomaka od kojih ce se birati najbolja potencijalna
% rjesenja
lam=str2double(get(handles.potomci,'String'));
% Broj potomaka ne smije biti broj manji od 1, ne smije biti prazna
% matrica, ne smije biti znak koji nije broj, ne smije biti beskonacno (Inf)
if ((lam<1)||isempty(lam)||max(isnan(lam))||max(isinf(lam)))
    msgbox('Broj potomaka mora biti cijeli pozitivan broj.','Greska',...
        'error')
    return
end
% Broj potomaka ne smije biti broj manji ob broja potencijalnih rjesenja,
% jer se od lam potomaka bira mi potencijalnih rjesenja koja ulaze u novu
% generaciju
if lam<mi
    msgbox('Broj potomaka mora biti veci od broja potencijalnih rjesenja.',...
        'Greska','error')
    return
end
% Odredjivanje broja generacija
brgeneracija=str2double(get(handles.generacije,'String'));
% Broj generacija ne smije biti broj manji od 1, prazna matrica, ne smije
% biti znak koji nije broj, ne smije biti beskonacno (Inf)
if ((brgeneracija<1)||isempty(brgeneracija)||max(isnan(brgeneracija))||max(isinf(brgeneracija)))
    msgbox('Broj generacija mora biti cijeli pozitivan broj.','Greska','error')
    return
end
% Odredjivanje kriterija optimizacije za ES. Prema kriteriju racuna se
% performansa pojedinih rjesenja. Implementirana su tri kriterija:
% - ISE (eng. integrated of squared error);
% - IAE (eng. integrated absolute error);
% - ITSE (eng. integrated of time weight square error);
val = get(handles.kriterij,'Value');    % Odredjivanje odabrane pozicije
lista = get(handles.kriterij,'String'); % Odredjivanje liste kriterija
kriterij = lista{val};                  % Odabrani kriterij
% Poziva se funkcija implementirana na kraju ovog m fajla koja odredjuje
% parametre PID regulatora koristenjem ES.
% Ulazne varijable su: - numerator i denumerator prenosne funkcije objekta
%                      - Broje potencijalnih rjesenja (mi)
%                      - Broj potomaka (lam)
%                      - Broj generacija (brgeneracija)
%                      - Kriterij za optimizaciju (kriterij)
% Izlazni parametri: Matrica parametara regulatora.
if get(handles.racunaj,'String')=='STOP '
    rad=0;
    set(handles.racunaj,'String','START')
    set(handles.Kpv,'String','');
    set(handles.Tiv,'String','');
    set(handles.Tdv,'String','');
    set(handles.racunaj,'String','STOP ')
    set(handles.Crtaj,'Visible','off')
    set(handles.LTI,'Visible','off')
    set(handles.poredi,'Visible','off')
    return
end
if get(handles.racunaj,'String')=='START'
    set(handles.racunaj,'String','STOP ')
    set(handles.Crtaj,'Visible','off')
    set(handles.LTI,'Visible','off')
    set(handles.poredi,'Visible','off')
    rad=1;
end
X=setPID(num,den,mi,lam,brgeneracija,kriterij);
% Odredjivanje parametara regulatora dobijenih evolucionom strategijom. Ovi
% parametri su smjesteni u zadnjoj koloni matrice X.
Kp=X(1,end);    % Pojacanje regulatora
Ti=X(2,end);    % Vremenska konstanta
Td=X(3,end);    % Diferencijalna konstanta
% Brisanje nepotrebnih varijabli
clear mi lam brgeneracija val lista kriterij
% Davanje porukuke korisniku da su odredjeni parametri regulatora
if rad==1
    msgbox('Odredjiivanje parametara PID regulatora je uspjesno izvrseno.',...
    'Uspjesno')
    % Ispis parametara regulatora u apliakciji
    set(handles.Kpv,'String',sprintf('%4.4f',Kp));
    set(handles.Tiv,'String',sprintf('%4.4f',Ti));
    set(handles.Tdv,'String',sprintf('%4.4f',Td));
    % Omogucavanje tipki za analizu parametara
    set(handles.Crtaj,'Visible','on')
    set(handles.LTI,'Visible','on')
    set(handles.poredi,'Visible','on')
end
rad=0;
set(handles.racunaj,'String','START')


% --- Sljedeci kod se izvrsava pritiskom na dugme "Crtanje odziva".
function Crtaj_Callback(hObject, eventdata, handles)
% Definisnaje potrebnih globalnih varijabli
global G;
global X;
global Kp;
global Ti;
global Td;
global prvi;
% Odredjivanje prenosne funkcije PID regulatora: PID=Kp(1+1/Tis+Tds)   
PID=tf([Kp*Ti*Td Kp*Ti Kp],[Ti 0]);
% Odredjivanje prenosne funkcije zatvorenog sistema:
%W=PID*G/(1+PID*G)
W=feedback(PID*G,1);
% Ako je cekiran "Jedinicni odziv" crta se odgovarajuci grafik
if get(handles.step,'Value')
    t=0:0.1:50;
    figure('Name','Odziv na jedinicnu pobudnu funkciju')
    step(W,t)
    hold on
    plot(t,ones(1,size(t,2)),'g')
    legend('Jedinicni odziv','Jedinicna pobuda')
    xlabel('Vrijeme t [s]')
    ylabel('Amplituda')
    grid on
    title('Odziv zatvorenog sistema na jedinicnu pobudnu funkciju')
end
% Ako je cekiran "Impulsni odziv" crta se odgovarajuci grafik
if get(handles.impuls,'Value')
    t=0:0.1:50;
    figure('Name','Impulsni odziv zatvorenog sistema')
    impulse(W,t)
    hold on
    legend('Impulsni odziv');
    xlabel('Vrijeme t [s]')
    ylabel('Amplituda')
    title('Impulsni odziv zatvorenog sistema')
    grid on
end
% Ako je cekiran "Polovi i nule" crta se odgovarajuci grafik
if get(handles.zp,'Value')
    t=0:0.1:50;
    figure('Name','Nule i polovi')
    pzplot(G,W)
    legend('Nule i polovi objekta','Nule i polovi zatvorenog sistema')
    xlabel('Realna osa')
    ylabel('Imaginarna osa')
    grid on
end
% Ako je cekiran "Bodeovi dijagrami" crta se odgovarajuci grafik
if get(handles.bodeovi,'Value')
    t=0:0.1:50;
    figure('Name','Bodeovi dijagrami')
    bode(G,W)
    legend('Bodeovi dijagrami objekta',...
        'Bodeovi dijagrami zatvorenog sistema')
    grid on
end


%--- Sljedeci kod se izvrsava pritiskom na dugme "LTI analiza".
function LTI_Callback(hObject, eventdata, handles)
% Definisnaje globalnih varijabli koje se koriste
global G;
global X;
global Kp;
global Ti;
global Td;
% Odredjivanje prenosne funkcije PID regulatora: PID=Kp(1+1/Tis+Tds)
PID=tf([Kp*Ti*Td Kp*Ti Kp],[Ti 0]);
% Odredjivanje prenosne funkcije zatvorenog sistema:
% W=PID*G/(1+PID*G)
W=feedback(PID*G,1);
% Pokretanje ltiview toolboxa
ltiview(G,W)


%--- Sljedeci kod se izvrsava pritiskom na dugme "?" koje daju kratku
% uputu za koristenje aplikacije
function help_Callback(hObject, eventdata, handles)
helpdlg('Upute za koristenje aplikacije:                                                         1.Unijeti koeficijente polinoma prenosne funkcije.                                                                          2. Odabrati parametre evolucione strategije.                                                   3. Kliknuti na dugme "START".                                                                  4. Sacekati poruku o uspjesnom odredjivanju parametara.                                      5. Izvrsiti analizu crtajuci odzive.                                          6. Izvrsiti LTI analizu.                                                           7. Moguce je poredjenje sa parametrima dobijenim drugim metodama                                         Za detaljnije informacije kliknuti na " ?? "')

    
% --- Sljedeci kod se izvrsava pritiskom na dugme "Poredjenje". Izvrsava se
% poredjenje u odzivima sistema koristeci razlicite metode odredjivanje
% parametara PID regulatora.
function poredi_Callback(hObject, eventdata, handles)
% Definisanje globalnih varijabli koje se koriste
global X;
global G;
if size(X,2)<2
    msgbox('Za sistem prvog reda za odredjivanje parametara PID regulatora koristena je samo evoluciona strategija','Upozorenje','warn')
    return
end
% Definisanje vremena u kojem ce se vrsiti analiza
t=0:0.01:50;
% Definisanje matrice u koju ce se smjestati prenosne funkcije sistema
% dobijenih razlicitim podesavanjima PID regulatora.
W=[];
for i=1:size(X,2)
    Kp=X(1,i);
    Ti=X(2,i);
    Td=X(3,i);
    PID=tf([Kp*Ti*Td Kp*Ti Kp],[Ti 0]);
    W=[W feedback(PID*G,[1])];
end
figure('Name','Usporedba parametara regulatora')
switch size(X,2)
    case 5
        subplot(2,2,1)
        hold on
        step(W(1),t,W(2),t,W(3),t,W(4),t,W(5))
        legend('Chien-Hrones-Reswick 1','Chien-Hrones-Reswick 2',...
            'Chien-Hrones-Reswick 3','Chien-Hrones-Reswick 4','ES')
        subplot(2,2,2)
        hold on
        impulse(W(1),W(2),W(3),W(4),W(5))
        legend('Chien-Hrones-Reswick 1','Chien-Hrones-Reswick 2',...
            'Chien-Hrones-Reswick 3','Chien-Hrones-Reswick 4','ES')
        subplot(2,2,3)
        hold on
        pzplot(W(1),W(2),W(3),W(4),W(5))
        legend('Chien-Hrones-Reswick 1','Chien-Hrones-Reswick 2',...
            'Chien-Hrones-Reswick 3','Chien-Hrones-Reswick 4','ES')
        subplot(2,2,4)
        hold on
        bode(W(1),W(2),W(3),W(4),W(5))
        legend('Chien-Hrones-Reswick 1','Chien-Hrones-Reswick 2',...
            'Chien-Hrones-Reswick 3','Chien-Hrones-Reswick 4','ES')        
    case 6
        subplot(2,2,1)
        step(W(1),t,W(2),t,W(3),t,W(4),t,W(5),t,W(6),t)
        legend('Ziegler-Nichols','Chien-Hrones-Reswick 1',...
            'Chien-Hrones-Reswick 2','Chien-Hrones-Reswick 3',...
            'Chien-Hrones-Reswick 4','ES')
        subplot(2,2,2)
        impulse(W(1),W(2),W(3),W(4),W(5),W(6))
        legend('Ziegler-Nichols','Chien-Hrones-Reswick 1',...
            'Chien-Hrones-Reswick 2','Chien-Hrones-Reswick 3',...
            'Chien-Hrones-Reswick 4','ES')
        subplot(2,2,3)
        pzplot(W(1),W(2),W(3),W(4),W(5),W(6))
        legend('Ziegler-Nichols','Chien-Hrones-Reswick 1',...
            'Chien-Hrones-Reswick 2','Chien-Hrones-Reswick 3',...
            'Chien-Hrones-Reswick 4','ES')
        subplot(2,2,4)
        bode(W(1),W(2),W(3),W(4),W(5),W(6))
        legend('Ziegler-Nichols','Chien-Hrones-Reswick 1',...
            'Chien-Hrones-Reswick 2','Chien-Hrones-Reswick 3',...
            'Chien-Hrones-Reswick 4','ES')
    otherwise
end
s1='Ziegler-Nicholsova metoda.........................................................';
s2='Chien-Hrones-Reswick metoda (stabilizirajuca, aperiodski)........';
s3='Chien-Hrones-Reswick metoda (stabilizirajuca, nadvisenje).......';
s4='Chien-Hrones-Reswick metoda (prateca, aperiodski).................';
s5='Chien-Hrones-Reswick metoda (prateca, nadvisenje)................';
s6='Metod evolucione strategije........................................................';
switch size(X,2)
    case 5
        s2=strcat('1. ',s2,num2str(X(1,1),'%.4f'),'......',...
            num2str(X(2,1),'%.4f'),'......',num2str(X(3,1),'%.4f'));
        s3=strcat('2. ',s3,num2str(X(1,2),'%.4f'),'......',...
            num2str(X(2,2),'%.4f'),'......',num2str(X(3,2),'%.4f'));
        s4=strcat('3. ',s4,num2str(X(1,3),'%.4f'),'......',...
            num2str(X(2,3),'%.4f'),'......',num2str(X(3,3),'%.4f'));
        s5=strcat('4. ',s5,num2str(X(1,4),'%.4f'),'......',...
            num2str(X(2,4),'%.4f'),'......',num2str(X(3,4),'%.4f'));
        s6=strcat('5. ',s6,num2str(X(1,5),'%.4f'),'......',...
            num2str(X(2,5),'%.4f'),'......',num2str(X(3,5),'%.4f'));
        str={s2,s3,s4,s5,s6};
    case 6
        s1=strcat('1. ',s1,num2str(X(1,1),'%.4f'),'......',...
            num2str(X(2,1),'%.4f'),'......',num2str(X(3,1),'%.4f'));
        s2=strcat('2. ',s2,num2str(X(1,2),'%.4f'),'......',...
            num2str(X(2,2),'%.4f'),'......',num2str(X(3,2),'%.4f'));
        s3=strcat('3. ',s3,num2str(X(1,3),'%.4f'),'......',...
            num2str(X(2,3),'%.4f'),'......',num2str(X(3,3),'%.4f'));
        s4=strcat('4. ',s4,num2str(X(1,4),'%.4f'),'......',...
            num2str(X(2,4),'%.4f'),'......',num2str(X(3,4),'%.4f'));
        s5=strcat('5. ',s5,num2str(X(1,5),'%.4f'),'......',...
            num2str(X(2,5),'%.4f'),'......',num2str(X(3,5),'%.4f'));
        s6=strcat('6. ',s6,num2str(X(1,6),'%.4f'),'......',...
            num2str(X(2,6),'%.4f'),'......',num2str(X(3,6),'%.4f'));
        str={s1,s2,s3,s4,s5,s6};
end
 [be ok]=listdlg('ListString',str,...
     'ListSize',[550 120],...
     'Name','Parametri podesavanaj PID regulatora',...
     'PromptString',...
     'Metod:                                                                                                Kp:             Ti               Td',...
     'SelectionMode','single');
if ~ok 
    close 'Usporedba parametara regulatora'
end


% --- Sljedeci kod se izvrsava pritiskom na dugme "??" koje daje vise
% informacija o projektu, u vidu dokumentacije
function help1_Callback(hObject, eventdata, handles)
if exist('dokumentacija.pdf')
    open('dokumentacija.pdf')
else
    msgbox('Dokumentacija se ne nalazi u direktoriju.','Upozorenje','warn')
end


function Kpv_Callback(hObject, eventdata, handles)

function Kpv_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'),...
            get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function Tiv_Callback(hObject, eventdata, handles)

function Tiv_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), ...
            get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function Tdv_Callback(hObject, eventdata, handles)

function Tdv_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), ...
            get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function step_Callback(hObject, eventdata, handles)


function zp_Callback(hObject, eventdata, handles)


function bodeovi_Callback(hObject, eventdata, handles)


function impuls_Callback(hObject, eventdata, handles)


function Xr=setPID(num,den,mi,lam,brgeneracija,kriterij)
h = waitbar(0,'Obrada u toku...');
% Vektorska varijabla X=[Kp Ti Td]';
X=[];
G=tf(num,den);
Xr=[];
global rad;
%*** Podesavanje pocetnih parametara PID regulatora ***
%--------------------------------------------------------------------------
% Prenosna funkcija PID regulatora: PID=Kp(1+1/Tis+Tds)

% 1. Ziegler - Nicholsova metoda
% Metoda se može primjeniti samo za objekte upravljanja koji se mogu
% dovesti do granice stabilnosti (reda veceg od dva). U prvoj se fazi 
% regulator zatvorenog sistema podesi tako da ima smao cisti P 
% (proporcionalni) karakter (Ti=inf, Td=0). Zatim se pojacanje regulatora 
% Kkr postepeno povecava sve dok u regulisanom kolu ne nastanu neprigusene 
% oscilacije. Ovo stanje se postize pri pojacanju Kkr. Izmjeri se period 
% oscilacija Tkr.
if size(den,2)>3
    Kkr=1;  % Pocetna vrijednost Kkr=1
    W=feedback(Kkr*G,1);  % Sistem sa jedinicnom negativnom povratnom spregom
    [nw, dw]=tfdata(W,'v'); % Polinom brojnika i nazivnika po s
% Vrtiti petlju dok bar jedan pol ne predje u desnu (nestabilnu)poluravan, 
% pri povecanju pojacanja Kkr
    pomoc=1;
    while (max(real(roots(dw)))<0)
        Kkr=Kkr+1;  %povecanje Kkr za +1
        W=feedback(Kkr*G,1);
        [nw, dw]=tfdata(W,'v');
        if Kkr>1000
            pomoc=0;
            msgbox('Primjena Ziegler - Nicholsove metode je neuspjesno.',...
            'Greska','error')
        break;
        end
    end
% Vracamo pojacanje na prethodnu, jos uvijek je stabilan sistem
    if pomoc
        Kkr=Kkr-1;
        W=feedback(Kkr*G,1);
        [nw, dw]=tfdata(W,'v');
% Preciziranje na dvije decimale
        while (max(real(roots(dw)))<0)
            Kkr=Kkr+0.01;   
            W=feedback(Kkr*G,1);
            [nw, dw]=tfdata(W,'v');
        end
% Odredivanje perioda oscilacija iz najmanje frekvencije
        polovi=roots(dw);   % Polovi prenosne funkcije W
        poz=find(imag(polovi)~=0);  % Pronaci polove kod koji je imaginarni 
                                    % dio razlicit od 0
        polovi=polovi(poz);         
        polovi=abs(polovi); % Uzimaju se kao apsolutna vrijednost
        Tkr=2*pi/min(polovi); % Frekvencija oscilacija odgovara minimalnoj 
        % frekvenciji odreðenoj imaginarnim dijelom polova
        % Parametri regulatora se biraju na osnovu Kkr i Tkr prema izratima:
        % Kp=0.6*Kkr, Ti=0.5*Tkr, Td=0.125*Tkr
        X=[X [0.6*Kkr 0.5*Tkr 0.125*Tkr]'];
        clear Kkr Tkr polovi poz dw nw W 
    end
end

% 2. Chien - Hrones - Reswick metoda
%- objekat se aproksimira prenosnom funkcijom prvog reda i
%  transportnim kasnjenjem
%- trazenje prevojne tacke:
if size(den,2)<size(num,2)+1
    msgbox('Primjena Chien - Hrones - Reswick metode je neuspjesno.',...
        'Greska','error')
end
if (size(den,2)>2) && (size(den,2)>size(num,2)+1)
    t=0:0.01:50;    %vrijeme simulacije
    y=step(G,t);    %odziv na jedinicnu pobudnu funkciju A=1
    pomoc=1;
    if(y(end)>1)
        pomoc=0;
    end
    if pomoc
    y=y';           %odziv je vektor red matrica
    y1=(y(2:end)-y(1:end-1))./0.01;  %racunanje funkcije prvog izvoda
    %Tacka inflekcija (prevojna tacka) se dobija kada je prvi izvod maksimalan
    poz=find(y1==max(y1));  %trazenje pozicije za koju je prvi izvod maksimalan  
    %U tacki infleksije povuce se prava q=k*t-n
    k=max(y1);  %nagib pravca je jednak maksimalnom prvom izvodu
    n=k*t(poz)-y(poz);  %pomak se racuna na osnovu vrijednosti y u tacki
                        %infleksije
    q=k.*t-n;
    % odredjivanje vremenskog kasnjenja tauob, udaljnost od t=0 do trenutka
    % kada prava q sijece vremensku osu
    tauob=t(max(find(q<=0)));
    %odredjivanje Kob, je stacionarno stanje podjeljeno sa ulaznom amplitudom A
    Kob=y(end);
    %odredjivanje vremenske konstante objekta Tob, vrijeme kada prava q sijece
    %stacionarno stanje umanjeno za vrijeme tauob
    Tob=t(min(find(q>=y(end))))-tauob;
    %Brisanje nepotrebnih varijabli
    clear t y y1 poz k n q
    % Odredjivanje parametara PID regulatora stabilizirajuce regulacije:
    % aperiodski odziv: 
    % Kp=0.95*Tob/tauob, Ti=2.4*tauob, Td=0.42*tauob
    X=[X [0.95*Tob/tauob 2.4*tauob 0.42*tauob]'];
    % 20% nadvisenje: 
    % Kp=1.2*Tob/tauob, Ti=2*tauob, Td=0.42*tauob
    X=[X [1.2*Tob/tauob 2*tauob 0.42*tauob]'];
    % Odredjivanje parametara PID regulatora pratece regulacije:
    % aperiodski odziv: 
    % Kp=0.6*Tob/tauob, Ti=Tob, Td=0.5*tauob
    X=[X [0.6*Tob/tauob Tob 0.5*tauob]'];
    % 20% nadvisenje: 
    % Kp=0.95*Tob/tauob, Ti=1.35*Tob, Td=0.47*tauob
    X=[X [0.95*Tob/tauob 1.35*Tob 0.47*tauob]'];
    clear Kob tauob Tob
    end
end
Xr=X;
% Pocetna populacija treba da sadrzi mi clanova
% Za sistem prvog reda treba randum izabrati mi clanova pocetne populacije
% Za sistem drugog reda potrebno je odabrati mi od n*4 parametara dobijenih
% drugom metodom sa n varijacija.
% Za sisteme reda tri i više potrebno je odabrati mi od n*5 parametara
% dobijenih prvim i drugim metodom sa n varijacija.
if size(X)==0
    X=rand(3,mi);
end
red=size(den,2)-1;
switch red
    case 1
        X=[X [10 0 0; 0.001 0 0; 0 0 0]*rand(3,mi)];
    case 2
        for i=2:mi/4+1
            X=[X X(:,1:4)];
        end
    otherwise
        for i=2:mi/5+1
            X=[X X(:,1:5)];
        end
end
X=X(:,1:mi);
clear red

%--------------------------------------------------------------------------
% *** Evoluciona strategija ES(mi,lam) ***
% -------------------------------------------------------------------------
% Matrica u koju ce se smjestati potomci:
Xp=[];
% Matrica u koju ce se smjestati vrijednosti fitnesa potomaka
Fitnes=[];
% Kriterij performanse:
% - ISE (eng. integrated of squared error);
% - IAE (eng. integrated absolute error);
% - ITSE (eng. integrated of time weight square error);
% brgeneracija = broj generacija
for i=1:brgeneracija
    % Diskretnom rekombinacija
    % lam - broj potomaka
    for j=1:lam
        %Slucajni odabir dva roditelja (ne ista)
        a=1;
        b=1;
        if mi>1
            a=1;
            b=1;
            while a==b
                a=1+round((mi-1)*rand);
            	b=1+round((mi-1)*rand);
            end
        end
        z=round(rand(3,1));
        Xp=[Xp X(:,a).*z+X(:,b).*(1-z)];
    end
    clear j a b z  
    % Pocetni vektor jedinica standardne devijacije, 3xlam
    Sigma=ones(3,lam);
    % Primjena rekombinacija na vektor Sigma
    for j=1:lam
        %Slucajni odabir dva roditelja (ne ista)
        a=1;
        b=1;
        if mi>1
            a=1;
            b=1;
            while a==b
                a=1+round((mi-1)*rand);
            	b=1+round((mi-1)*rand);
            end
        end
        Sigma(:,j)=0.5*(Sigma(:,a)+Sigma(:,b));
    end
    clear j a b
    % Sluèajno modificiranje elemenata hromozoma
    % Xk=Xk + b.*c.*sigma*N(0,sigma);
    % c - korak mutiranja
    c=[10 1 0.1]';
    for j=1:lam;
        % b moze biti -1 ili 1
        b=2*round(rand(3,1))-1;
        N=(1/sqrt(2*pi)./Sigma(:,j)).*exp(((-(Xp(:,j).^2))/2./Sigma(:,j).^2));
        Xp(:,j)=Xp(:,j)+b.*c.*Sigma(:,j).*N;
    end
    %Odredjivanje Fitnesa na step ulaz;
    clear b Sigma j N
    for j=1:lam
        Kp=Xp(1,j);
        Ti=Xp(2,j);
        Td=Xp(3,j);
        PID=tf([Kp*Ti*Td Kp*Ti Kp],[Ti 0]);
        W=feedback(PID*G,[1]);
        t=0:0.01:50;
        y=step(W,t);
        y=y';
        greska=1-y;
        switch kriterij
            case 'ISE'
                Fitnes=[Fitnes 1/trapz(t,greska.*greska)];
            case 'IAE'
                Fitnes=[Fitnes 1/trapz(t,abs(greska))];
            case 'ITSE'
                Fitnes=[Fitnes 1/trapz(t,t.*greska.*greska)];
        end
    end
    clear j Kp Ti Td PID W t y greska
    %Odreðivanje mi najboljih fitnesa;
    Xp=[Fitnes;Xp];
    clear Fitnes
    Xp=sort(Xp,2,'descend');
    %uzikma se mi najboljih fitnesa
    X=Xp(2:end,1:mi);
    clear Xp
    Xp=[];
    Fitnes=[];
    waitbar(i/brgeneracija)
    if rad==0
        close(h);
        msgbox('Odredjivanje parametara PID regulatora je zaustavljeno!',...
            'Zaustavljeno!')
        return
        
    end
end
close(h);
Xr=[Xr X(:,1)];

function text1_CreateFcn(hObject, eventdata, handles)

function racunaj_CreateFcn(hObject, eventdata, handles)