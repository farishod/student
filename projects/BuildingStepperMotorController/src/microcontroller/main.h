#include <16F877A.h>
#device adc=8

#FUSES NOWDT                    //Iskljuèen WDT tajmer
#FUSES XT                       //Tip oscilatora: kvarcni
#FUSES NOPUT                    //Iskljuèen Power up tajmer
#FUSES NOPROTECT                //Iskljuèena zaštita koda
#FUSES NODEBUG                  //Iskljuèen Debug mode za ICD
#FUSES NOBROWNOUT               //Iskljuèen Brown on reset
#FUSES NOLVP                    
#FUSES NOCPD                    //Iskluèena EE zaštita
#FUSES WRT_50%                  //Pola programske memorije 
                                //zaštiæeno od upisivanja
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

