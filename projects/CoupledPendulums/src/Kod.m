%Incijalizacija parametara
greska='Niste slijedili upute!!!';
m=1;
a=1.5;
g=9.80665;
k = 3.25;
alfa0=0; 			%Poèetne vrijednost za alfa
beta0=0; 		%Poèetne vrijednost za beta
gama0=pi/10; 		%Poèetne vrijednost za gama
ulaz=input('Da li zelite unijeti parametre? Pritisni 1 za DA:' );
%Ako zelite unositi svoje parametra pritisnite 1
%Ako ne zelite grafik ce biti crtan na osnovu vec postavljenih vrijednosti
if ulaz==1
a=input('Unesi vrijednost a:' );
k=input('Unesi krutost opruge k:' );
m=input('Unesi masu tijela:');
alfa0=input('Unesi pocetnu vrijednost ugla alfa:' );
beta0=input('Unesi pocetnu vrijednost ugla beta:');
gama0=input('Unesi pocetnu vrijednost ugla gama:');
end;
clear ulaz;
ulaz=input('Opcije: Crtati aproksimirajuci male uglove (pritisni 1); Bez aproksimacije (0):');
if ulaz==1
open('E:\Hodzic_Faris\sa_aproksimacijom.mdl' )
sim('E:\Hodzic_Faris\sa_aproksimacijom.mdl' )
elseif ulaz==0
open('E:\Hodzic_Faris\bez_aproksimacije.mdl')
sim('E:\Hodzic_Faris\bez_aproksimacije.mdl' )
else 
greska
break
end;
plot(vrijeme,alfa,vrijeme,beta,vrijeme,gama)
grid on
xlabel('vrijeme', 'FontSize',12)
ylabel('\alpha,\beta,\gamma' ,'FontSize',15)
title('Prikaz promjene uglova u zavisnosti od vremena','FontSize',12)
legend('Ugao \alpha','Ugao \beta','Ugao \gamma')
clear ulaz
ulaz=input('Ako zelite uporediti rezultate aproksimiranja i neaproksimiranja pritisni 1:' );
if ulaz==1
open('E:\Hodzic_Faris\bez_aproksimacije.mdl')
sim('E:\Hodzic_Faris\bez_aproksimacije.mdl')
subplot(2,1,1)
plot(vrijeme,alfa,vrijeme,beta,vrijeme,gama)
grid on
xlabel('vrijeme' ,'FontSize',12)
ylabel('\alpha,\beta,\gamma' ,'FontSize',15)
title('Prikaz promjene uglova u zavisnosti od vremena bez aproksimacije','FontSize',12)
legend('Ugao \alpha','Ugao \beta','Ugao \gamma')
subplot(2,1,2)
open('E:\Hodzic_Faris\sa_aproksimacijom.mdl' );
sim('E:\Hodzic_Faris\sa_aproksimacijom.mdl' )
plot(vrijeme,alfa,vrijeme,beta,vrijeme,gama)
grid on
xlabel('vrijeme' ,'FontSize',12)
ylabel('\alpha,\beta,\gamma' ,'FontSize',15)
title('Prikaz promjene uglova u zavisnosti od vremena sa aproksimacijom' , 'FontSize',12)
legend('Ugao \alpha','Ugao \beta','Ugao \gamma')
pause
close
clear
clc
end;
