#include <16F877A.h>
#device adc=8

#FUSES NOWDT                    //Isklju�en WDT tajmer
#FUSES XT                       //Tip oscilatora: kvarcni
#FUSES NOPUT                    //Isklju�en Power up tajmer
#FUSES NOPROTECT                //Isklju�ena za�tita koda
#FUSES NODEBUG                  //Isklju�en Debug mode za ICD
#FUSES NOBROWNOUT               //Isklju�en Brown on reset
#FUSES NOLVP                    
#FUSES NOCPD                    //Isklu�ena EE za�tita
#FUSES WRT_50%                  //Pola programske memorije 
                                //za�ti�eno od upisivanja
#use delay(clock=3276800)       //Radna frekvencija oscilatora
//Definise se RS232 komunikacija
#use rs232(baud=2400,parity=N,xmit=PIN_C6,rcv=PIN_C7,bits=8)
//Definisanje pinova radi lakse upotrebe
#define B0 PIN_B0
#define B1 PIN_B1
#define B2 PIN_B2
#define B3 PIN_B3
#define B4 PIN_B4
#define B5 PIN_B5

