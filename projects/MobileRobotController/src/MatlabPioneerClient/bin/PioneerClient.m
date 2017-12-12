function varargout = PioneerClient(varargin)
% PIONEERCLIENT M-file za PioneerClient.fig
%      PIONEERCLIENT, sama po sebi, stvara novi PIONEERCLIENT ili 
%      podize postojeci Singleton.
%
%      H = PIONEERCLIENT vraca handle na novu PIONEERCLIENT ili 
%      handle na postojeæe Singleton.
%
%      PIONEERCLIENT('CALLBACK',hObject,eventData,handles,...) poziva 
%      lokalnu funkciju pod nazivom CALLBACK u PIONEERCLIENT.M sa datim 
%      ulaznim argumentima.
%
%      PIONEERCLIENT('Property','Value',...) kreira novi PIONEERCLIENT ili 
%      realizuje postojeci singleton.
%
% -------------------------------------------------------------------------
% Autor: Faris Hodzic                                Sarajevo, 15.08.2010.

% Pocetak inicijalizacionog koda - NE MIJENJATI
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PioneerClient_OpeningFcn, ...
                   'gui_OutputFcn',  @PioneerClient_OutputFcn, ...
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
% Kraj inicijalizacionog koda - NE MIJENJATI


% --- Izvrsava se neposredno prije nego sto PioneerClient postane vidljiva
function PioneerClient_OpeningFcn(hObject, eventdata, handles, varargin)
    % Indikacija stanja inicijalizacije sistema
    global init;
    % Linijska brzina kretanja Pioneer robota
    global speed;
    % Globalna varijabla ID klienta
    global clientid;
    % Prioritetizvrsavanja komande
    global priority;
    % Distanca na kojoj robot pocinje reagovati an prednju ivicu
    global obstacleDist;
    % Brzina izbjegavanja prepreke
    global avoidSpeed;
    % Ugao zakretanja
    global turnAmount;
    % Inicijalne vrijednosti globalnih varijabli
    speed=0;
    init=0;
    clientid=0;
    priority=90;
    obstacleDist=500;
    avoidSpeed=80;
    turnAmount=10;
    % Odaberite zadatu komandnu izlaznu liniju za PioneerClient
    handles.output = hObject;
    % Osvjezavanje strukture
    guidata(hObject, handles);
    % Brise komandni prozor
    clc

% --- Izlazi iz ove funkcije se vracaju u komandnu liniju.
function varargout = PioneerClient_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;

% -------------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)

% --- Izvrsava se nakon klika na dugme About u Help meniju
function About_Callback(hObject, eventdata, handles)
    % Otvara novu formu u kojoj je dat opis forme , autor ...
    try
        AboutForm;
    catch exception
        err = lasterror
        % Gresku ispisati u vidu poruke
        errordlg(err.message);
    end

% --- Izvrsava se nakon klika na dugme UserManual
function UserManual_Callback(hObject, eventdata, handles)
    %Otvara se korisnicki manual
    if exist('UserManual.pdf')
        % ako postoji otvoriti
        open('UserManual.pdf')
    else
        % Ako en postojiti izbaciti poruku
        warndlg('User manual do not exist!')
    end

% -------------------------------------------------------------------------
function selectPriority_Callback(hObject, eventdata, handles)

function selectPriority_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

% -------------------------------------------------------------------------
function SelectObstacleDist_Callback(hObject, eventdata, handles)

function SelectObstacleDist_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

% -------------------------------------------------------------------------
function SelectAvoidSpeed_Callback(hObject, eventdata, handles)

function SelectAvoidSpeed_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

% -------------------------------------------------------------------------
function SelectTurnAmount_Callback(hObject, eventdata, handles)

function SelectTurnAmount_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

% --- Izvrsava se nakon odabita algoritma kretanja
function SelectAlgorithm_Callback(hObject, eventdata, handles)
    %Uzima se tip algoritma
    temp=get(handles.SelectAlgorithm,'Value');
    % Ako je manualno kretanje
    if temp==2
        enableAlgorithmPanel(handles,0)
    % Ako je automatsko kretanje
    elseif temp==1
        enableAlgorithmPanel(handles,1)
    end

function SelectAlgorithm_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

% -------------------------------------------------------------------------
function SelectPioneerPort_Callback(hObject, eventdata, handles)

function SelectPioneerPort_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

% -------------------------------------------------------------------------
function SelectCinterionPort_Callback(hObject, eventdata, handles)

function SelectCinterionPort_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

% --- Izvrsava se nakon pritiska na dugme Play
function play_ClickedCallback(hObject, eventdata, handles)
    % Globalna varijabla ID klienta
    global clientid;
    % Serijski port prema Cinterion modulu
    global Serial2Cinterion;
    try
        % Uzima se vrijednost korisnickog broja (ID)
        clientid=str2num(get(handles.seectId,'String'));
        %Izbor algoritma kretanja
        % Lista portova
        ComList=get(handles.SelectPioneerPort,'String');
        PioneerCom=get(handles.SelectPioneerPort,'Value');
        % 
        s=ComList(PioneerCom)
        % otvara se simulator
        OpenMobileSim();
        % Pozivanje funkcije za inicijalizaciju mobilnog robota
        robotinit(s);
        % Setovanje maksimalne rotacione brzine
        setRotVelMax(40);
        % Postaviti flag da je izvrsena inicijalizacija
        algorithm=get(handles.SelectAlgorithm,'Value');
        
        switch algorithm
            % Izbjegavanje prednje prepreke
            case 1
                avoidFront(handles);
                % Setovanje linijske brzine
                setVel(40);
                % Ugasiti kontrolu sa tastature
                set(handles.figure1,'KeyPressFcn','');
            %Manuelno kretanje    
            case 2
                %Omoguciti upravljanje tastaturom
                set(handles.figure1,'KeyPressFcn',@KeyPress);
        end
        % Sakriti dugme play
        set(handles.play, 'Enable','off');
        % Otkriti dugme stop i pause
        set(handles.stop, 'Enable','on');
        set(handles.pause, 'Enable','on');
        % Onemoguciti panele za izbor portova i algoritma kretanja robota
        enableAlgorithmPanel(handles,0);
        enablePortPanels(handles,0);
    catch exception
        err = lasterror
        % Ako je nastupila greska izbaciti odgovarajucu poruku
        errordlg(err.message);
        % U svakom slucaju zatvoriti port prema Cinterion modulu
        fclose(Serial2Cinterion);
        % Zaustaviti kretanje robota
        stop();
        % Iskljuciti robot
        shutdown();
        % Postaviti flag da nije izvrsena inicijalizacija
        init=0;
    end

% --- Funkcija koja izvrsava inicijalizaciju izbjegavanja prepreka
function avoidFront(handles)
    % Prioritetizvrsavanja komande
    global priority;
    % Distanca na kojoj robot pocinje reagovati an prednju ivicu
    global obstacleDist;
    % Brzina izbjegavanja prepreke
    global avoidSpeed;
    % Ugao zakretanja
    global turnAmount;
    try
        % Uzima se vrijednost prioriteta sa forme
        priority=str2double(get(handles.selectPriority,'String'));
        % Uzima se vrijednost distance na reagovanje
        obstacleDist=str2double(get(handles.SelectObstacleDist,'String'));
        % Uzima se brzina sa forme 
        avoidSpeed=str2double(get(handles.SelectAvoidSpeed,'String'));
        % Uzima se ugao zakretanja sa forme
        turnAmount=str2double(get(handles.SelectTurnAmount,'String'));
        % Izbjegavanje prepreka: actionAvoidFront(prioritet,mm,mm/s,stepeni)
        actionAvoidFront(priority,obstacleDist,avoidSpeed,turnAmount);
    catch exception
        err = lasterror
        errordlg(err.message);
    end        
            
% --- Izvrsava se nakon klika na dugme pause
function pause_ClickedCallback(hObject, eventdata, handles)
    % Globalna varijabla, linijska brzina kretanja robota
    global speed;
    try
        % Brzina kretanja se postavlja na 0
        speed=0;
        % Zaustavlja se kretanje robota
        stop();
        % Omogucuje se tipka Play
        set(handles.play, 'Enable','on');
        % Onemogucuje se tipka pause
        set(handles.pause, 'Enable','off');
        % Onemogucuje se tipka stop
        set(handles.stop, 'Enable','on');
        % Omogucuje se panel za podesavanje algoritma kretanja
        enableAlgorithmPanel(handles,1);
    catch exception
        err = lasterror
        errordlg(err.message);
    end 

% --- Izvrsava se nakon klika na dugme Stop
function stop_ClickedCallback(hObject, eventdata, handles)
    % Globalna varijabla, stanje inicijalizacije robota
    global init;
    % Globalna varijabla, linijska brzina kretanja robota
    global speed;
    % Globalna varijabla, serijski port za Cinterion modul
    global Serial2Cinterion;
    try
        % Saljse se naredba za stopiranje
        fprintf(Serial2Cinterion,'#S');
        % Omogucuje se tipka play
        set(handles.play, 'Enable','on');
        % Onemogucuje se tipka pause
        set(handles.pause, 'Enable','off');
        % Onemogucuje se tipka stop
        set(handles.stop, 'Enable','off');
        % Postavlja se brzina kretanja na 0
        speed=0;
        % Zaustavlja se kretanje mobilnog robota
        stop();
        % Gasi se mobilni robot
        shutdown();
        % Omogucuje se panel za odabir algoritma kretanja robota
        enableAlgorithmPanel(handles,1);
        % Onemogucuje se upravljanje tastaturom
        set(handles.figure1,'KeyPressFcn','');
    catch exception
        err = lasterror
        errordlg(err.message);
    end  

% --- Izvrsava se pri zatvaranju forme
function figure1_CloseRequestFcn(hObject, eventdata, handles)
    % Globalna varijabla, serijski port sa Cinterion modulom
    global Serial2Cinterion;
    try
        % Zatvara se serijski port sa Cinterion modulom
        fclose(Serial2Cinterion);
        % Zaustavlja se kretanje robota
        stop();
        % Gasi se mobilni robot
        shutdown();
        % Brise se forma
        delete(hObject);
    catch exception
        err = lasterror
        errordlg(err.message);
        close(handles.figure1)
    end     

% --- Otvaranje MobileSim simulatora
function OpenMobileSim()
    try
        % Putanja instalacije MobilSima
        simPath = 'C:\Program Files\MobileRobots\MobileSim\MobileSim.exe';
        % Putanja mape koja se otvara
        mapPath = 'C:\Program Files\MobileRobots\MobileSim\AMROffice.map';
        % Otvara se MobilSim
        openMobileSim(simPath,mapPath)
    catch exception
        err = lasterror
        errordlg(err.message);
    end 
    
% --- Kretanje unatrag
function goDown()
    % Globalna varijabla, linijska brzina kretanja robota
    global speed;
    try
        % Mjeri se trnutna brzina kretanja robota
        speed = getVel();
        % Trnutna brzina se umanjuje za 10
        speed=speed-10;
        % Postavlja se nova brzina kretanja
        setVel(speed)
    catch exception
        err = lasterror
        errordlg(err.message);
    end 

% --- Kretanje ulijevo
function goLeft()
    try
        % Uzima se vrijednost pozicije
        pos=position();
        % Uzima se vrijednost zakreta
        h = pos(3);
        % Ugao zakretanja se uvecaje za 20
        setHeading(h+20)
    catch exception
        err = lasterror
        errordlg(err.message);
    end 

% --- Kretanje udesno
function goRight()
    try
        % Uzima se vrijednost pozicije
        pos = position();
        % Uzima se ugao zakretanja
        h = pos(3);
        % Ugao zakretanja umanjiti za 20
        setHeading(h-20)
    catch exception
        err = lasterror
        errordlg(err.message);
    end 
    
% --- Kretanje unaprijed
function goUp()
    % Globalna varijabl,, linijska brzina kretanja robota
    global speed;
    try
        % Ocitanje trenutne brzine kretanja
        speed = getVel();
        % uvecati trenutnu brzinu kretanja za 10
        speed=speed+10;
        % Postaviti novu brzinu kretanja
        setVel(speed);
    catch exception
        err = lasterror
        errordlg(err.message);
    end 

% --- Interapt serijske komunikacije, poziva se nakon sto pristigne CR+LF
function SeriallInterrupt(obj,event)
    % Globalna varijabla, serijski port prema Cinterion modulu
    global Serial2Cinterion;
    % Globalna varijabla, prioritet izbjegavanja prepreka
    global priority;
    % Globalna varijabla, distanca reagovanja
    global obstacleDist;
    % Brzina izbjegavanja prepreka
    global avoidSpeed;
    % Ugao zakretanja tokom izbjegavanja
    global turnAmount;
    % Stanje inicijalizacije robota
    global init;
    try
        % Ocitava se string sa serijskog porta
        stemp=fscanf(Serial2Cinterion);
        disp(stemp);
        if(stemp(1)=='#')
            temp=stemp(2);
            % u zavisnosti od pristigle komande
            switch temp
                % Zaustavlja se kretanje robota uz shutdown
                case 'S'
                    fprintf(Serial2Cinterion,'#S');
                    stop();
                    shutdown();
                % Zaustavlja se kretanje robota bez shutDowna    
                case 'P'
                    stop();
                % Automatsko izbjegavanje prepreka
                case 'M'
                    %izbjegavanje prepreka: actionAvoidFront(prioritet,mm,mm/s,stepeni)
                    setVel(40);
                    actionAvoidFront(priority,obstacleDist,avoidSpeed,turnAmount);
                % Kretanje unaprijed
                case 'F'
                    goUp();
                % Kretanje ulijevo
                case 'L'
                    goLeft();
                % Kretanje andesno
                case 'R'
                    goRight();
                % Kretanje unatrag
                case 'B'
                    goDown();
                case 'C'
                    stop();
                    a=findstr(stemp,'#');
                    b=findstr(stemp,',');
                    x=stemp(a+1:b-1);
                    y=stemp(b:end);
            end
        end
    catch exception
        err = exception
        errordlg(err.message);
    end
    
%--- Izvrsava se nakon pritiska tipke sa tastature 
function KeyPress(src,evnt)
    try
        % Prepisati pritisnutu tipku
        k=evnt.Key;
        switch k
            % Ako je strelica za naprijed, ici naprijed
            case  'uparrow'
                goUp();
            % Ako je strelica za lijevo, okret nalijevo
            case  'leftarrow'
                goLeft();
            % Ako je strelica za dolje, ici unatrag
            case  'downarrow'
                goDown();
            % Ako je strelica za desno, okret nadesno
            case  'rightarrow'
                goRight();
            % Ako je pritisnut space, zaustaviti robota bez shutdowna
            case  'space'
                stop();
        end
    catch exception
        err = lasterror
        errordlg(err.message);
    end 

% -------------------------------------------------------------------------
function seectId_Callback(hObject, eventdata, handles)

function seectId_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -------------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)

% --- Izvrsava se nakon pritiska na Quit u fajl meniju
function quit_Callback(hObject, eventdata, handles)
    % Globalna varijabla, serijski port ka Cinterion modulu
    global Serial2Cinterion;
    try
        % Zatvara se serijska komunikacija ka cinterion modulu
        fclose(Serial2Cinterion);
        % Zaustavlaj se kretanje mobilnog robota
        stop();
        % Gasi se robot
        shutdown();
        % Zatvara se forma
        close(handles.figure1)
    catch exception
        err = lasterror
        errordlg(err.message);
        close(handles.figure1)
    end 
 
 % --- Funkcija za omogucavanje/onemogucavanje panela za podesavanje
 % algoritma kretanja mobilnog robota.
 function enableAlgorithmPanel(handles, i)
    try
        % Ako je potrebno onemoguciti
        if i==0
            set(handles.selectPriority,'Enable','off');
            set(handles.SelectObstacleDist,'Enable','off');
            set(handles.SelectAvoidSpeed,'Enable','off');
            set(handles.SelectTurnAmount,'Enable','off');
            set(handles.SelectAlgorithm,'Enable','off');
        % Ako je potrebno omoguciti
        elseif i==1
            set(handles.selectPriority,'Enable','on');
            set(handles.SelectObstacleDist,'Enable','on');
            set(handles.SelectAvoidSpeed,'Enable','on');
            set(handles.SelectTurnAmount,'Enable','on');
            set(handles.SelectAlgorithm,'Enable','on');
        end
    catch exception
        err = lasterror
        errordlg(err.message);
    end 
    
 % --- Funkcija za omogucavanje panela za setovanej portova
 function enablePortPanels(handles, i)
    try
        % Ako je potrebno omoguciti panel
        if i==0        
            set(handles.SelectPioneerPort,'Enable','off');
            set(handles.seectId,'Enable','off');
            set(handles.SelectCinterionPort,'Enable','off');
        % Ako je potrebno onemoguciti panel
        elseif i==1
            set(handles.SelectPioneerPort,'Enable','on');
            set(handles.seectId,'Enable','on');
            set(handles.SelectCinterionPort,'Enable','on');
        end
    catch exception
        err = lasterror
        errordlg(err.message);
    end 

% -------------------------------------------------------------------------
function Tools_Callback(hObject, eventdata, handles)

% --- Funkcija koja se izvrsava nakon pritiska na Refresh, sluzi za
% prikuplajnje dostupnih serijskih portova
function Refresh_Callback(hObject, eventdata, handles)
    try
        % Prikupljaju se informacije o dostupnim serijskim portovima
        serialInfo = instrhwinfo('serial');
        % u odgovarajuci PopUp meni se upisuju ovi portovi
        set(handles.SelectCinterionPort,'String',serialInfo.AvailableSerialPorts);
    catch exception
        err = lasterror
        errordlg(err.message);
    end


% --------------------------------------------------------------------
function Connect2Serial_Callback(hObject, eventdata, handles)
    % Globalna varijabla koja indicira inicijalno stanje
    global init;
    % Serijski port prema Cinterion modulu
    global Serial2Cinterion;
    if(init==0)
        % Port na koji je prikljucen Cinterion modul
        CinterionCom=get(handles.SelectCinterionPort,'Value');
        % Lista portova
        ComList=get(handles.SelectCinterionPort,'String');
        % Kreira se port
        Serial2Cinterion=serial(ComList(CinterionCom),'BaudRate',9600);
        % Ako su stigla cetiri nova bajta obraditi ih
        Serial2Cinterion.BytesAvailableFcnCount=4;
        % Interapt se poziva ukoliko je dosao terminator
        Serial2Cinterion.BytesAvailableFcnMode = 'terminator';
        % Funkcija koja se poziva pri pristigloj komandi od modula
        Serial2Cinterion.BytesAvailableFcn =@SeriallInterrupt;
        % Kraj poruke zavrsava sa CR+LF
        Serial2Cinterion.Terminator='CR/LF';
        % Serijski port prema Pioneer Robotu
        try
            %Pokusaj otvaranja konekcije
            fopen(Serial2Cinterion);
        catch exception
            err = lasterror
            % Poslati poruku ako je doslo do greske prilikom otvaranja
            % konekcije
             errordlg(err.message);
            return;
        end
        init=1;
        set(handles.play, 'Enable','on');
        set(handles.Connect2Serial,'Label','Disconnect')
        % Omogucuje se panel za odabir portova
        enablePortPanels(handles,0);
    else
        try
            % Saljse se naredba za stopiranje
            fprintf(Serial2Cinterion,'#S');
            % Postavlja se flag da nije izvrsena inicijalizacija
            init=0;
            % Zatvara se serijski port sa Cinterion modulom
            %freeserial(Serial2Cinterion);
            fclose(Serial2Cinterion);
            delete(Serial2Cinterion);
            clear Serial2Cinterion
            set(handles.play, 'Enable','off');
            % Onemogucuje se tipka pause
            set(handles.pause, 'Enable','off');
            % Onemogucuje se tipka stop
            set(handles.stop, 'Enable','off');
            % Omogucuje se panel za odabir portova
            enablePortPanels(handles,1);
            set(handles.Connect2Serial,'Label','Connect')
        catch exception
            err = lasterror
            errordlg(err.message);
        end  
    end
    


% --------------------------------------------------------------------
function ConnectToServer_Callback(hObject, eventdata, handles)
    global Serial2Cinterion
    % Globalna varijabla ID klienta
    global clientid;
    clientid=get(handles.seectId,'String');
    clientid=str2num(clientid);
    try
        % Kada se konekcija uspostavi slati ID
        temp=['#A' clientid];
        fprintf(Serial2Cinterion,temp)
    catch exception
        err = lasterror
        % Poslati poruku ako je doslo do greske prilikom otvaranja
        % konekcije
        errordlg(err.message);
        return;
    end


