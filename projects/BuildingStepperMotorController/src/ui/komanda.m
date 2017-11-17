function odgovor=komanda(s1,rad,smjer,koraci,brzina)
%------------------------------------------------------------------------------------------
% Ova funkcija sluzi za kreiranje komande koja ce se putem serijskog porta
%poslati modulu, koji æe odgovoriti na primljenu komandu.
%
%	odgovor=komanda(s1,rad,smjer,koraci,brzina))
%
%	Gdje je:
% 		s1 - definisani serijski objekat
% 		rad - zadatak koji treba da vrsi (
%				1 - izvrsi testiranje,
% 				2 - koracaj
%				3 - prekid svih trenutnih radnji)
% 		brzina - brzina koracanja bipolarnog motora
%
%Ova funkcija je kreirana za potrebe komunikacije sa modulom koji obavlja
%upravljanja koracnim motorima. Modul je razvijen u okviru završnog rada
%pod nazivom:"Gradnja sistema upravljanja koracnim motorima" ciji je
%realizator Hodžiæ Faris.
%									 maj 2008. godine
%------------------------------------------------------------------------------------------
%
switch rad
    case '1'
        %Ako se vrši testiranje salje se samo '#1'
        poruka=strcat('#',rad);
    case '2'
        %Ako je radni mod koracanje salju se sve informacije
        poruka=strcat('#',rad,smjer,koraci,brzina);
    case '3'
        %Ako je radni mod prekidanje radnji salje se samo '#3'
        poruka=strcat('#',rad);
    otherwise disp('Greska!!!');
end
fprintf(s1,poruka);
%Matrice u koje cemo smjestiti odgovore mikrokontrolera
%koji odgovara samo ako je poslata naredba za testom
odgovor1=[];
odgovor2=[];
odgovor3=[];
if rad=='1'
    while isempty(odgovor1)
        odgovor1=fread(s1,1);
    end
    while isempty(odgovor2)
        odgovor2=fread(s1,1);
    end
    while isempty(odgovor3)
        odgovor3=fread(s1,1);
    end
end
odgovor=[odgovor1 odgovor2 odgovor3];
%Kraj!!!