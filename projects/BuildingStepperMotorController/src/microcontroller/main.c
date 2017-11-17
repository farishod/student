#include "main.h"
#include <math.h>
/*** Incijalizacija kreiranih funkcija ***/
void korak1(unsigned int16 pauza)
   {  //*Funkcija za pravljenje prvog koraka;
      output_high(B3);  //ENA=1
      output_high(B5);  //IN1=1
      output_low(B4);   //IN2=0
      Delay_ms(pauza);  //Pravljenje pauze radi definisane brzine koraèanja
     }
void korak2(unsigned int16 pauza)
   {  //*Funkcija za pravljenje drugog koraka;
      output_high(B0);  //ENB=1
      output_high(B2);  //IN3=1
      output_low(B1);   //IN4=0
      Delay_ms(pauza);  //Pravljenje pauze radi definisane brzine koraèanja
     }
void korak3(unsigned int16 pauza)
   {  //*Funkcija za pravljenje treceg koraka;
      output_high(B3);  //ENA=1
      output_low(B5);   //IN1=0
      output_high(B4);  //IN2=1
      Delay_ms(pauza);  //Pravljenje pauze radi definisane brzine koraèanja
     }
void korak4(unsigned int16 pauza)
   {  //*Funkcija za pravljenje cetvrtog koraka;
      output_high(B0);  //ENB=1
      output_low(B2);   //IN3=0
      output_high(B1);  //IN4=1
      Delay_ms(pauza);  //Pravljenje pauze radi definisane brzine koraèanja
     }
void Kanal(unsigned int8 k)
   {  //*Funkcija za odbir ulaznog kanala za analogne ulaze;
      set_adc_channel(k);
      }
long long broj32 (int k4,int k3,int k2,int k1,int k0)
   {  //*Funkcija za realizovanje 32-bitnog broja od 5 8-bitnih brojeva;
      //k0,k1,k2,k3,k4 su 8-bitni brojevi
      long long broj;   //32-bitni broj
      broj=k0+k1*10+k2*100+k3*1000+k4*10000;
      return broj;
      }
unsigned int8 teststruje()
   {  //*Funkcija za odredjivanje maksimalne struje kroz motor
      unsigned int8 Iadc,Iadc1,Iadc2,Iadc3,Iadc4,pomoc;
      //Iadc1-maksimalna struja kroz fazu A,1 korak;
      //Iadc2-maksimalna struja kroz fazu B,2 korak;
      //Iadc3-maksimalna struja kroz fazu A,3 korak;
      //Iadc4-maksimalna struja kroz fazu B,4 korak;
      //Iadc=min(Iadc1,Iadc2,Iadc3,Iadc4);
      //pomoc-varijabla u koju se smjesti rezultat ADC;
      Kanal(0);   //Aktiviranje analognog ulaza AN0
      korak1(500);//Napravi prvi korak sa pauzom 500ms
      Iadc1=0;
      pomoc=0;
      while(1)
      {
         Iadc1=pomoc;
         pomoc=read_adc();
         if (Iadc1==pomoc) break;    
         }
      Kanal(1);      //Aktiviranje analognog ulaza AN1
      korak2(500);   //Napravi drugi korak sa pauzom 500ms
      Iadc2=0;
      pomoc=0;
      while(1)
      {
         Iadc2=pomoc;
         pomoc=read_adc();
         if (Iadc2==pomoc) break;    
         }
      Kanal(0);   //Aktiviranje analognog ulaza AN0
      korak3(500);//Napraviti treci korak sa pauzom 500ms
      Iadc3=0;
      pomoc=0;
      while(1)
      {
         Iadc3=pomoc;
         pomoc=read_adc();
         if (Iadc3==pomoc) break;    
         }
      Kanal(1);//Aktiviranje analognog ulaza AN1
      korak4(500);//Napraviti cetvrti korak sa pauzom 500ms
      Iadc4=0;
      pomoc=0;
      while(1)
      {
         Iadc4=pomoc;
         pomoc=read_adc();
         if (Iadc4==pomoc) break;    
         }
      //Trazenje minimalne vrijednosti maksimalnih struja kroz obje faze
      Iadc=Iadc1;
      if (Iadc2>Iadc) Iadc=Iadc2;
      if (Iadc3>Iadc) Iadc=Iadc3;
      if (Iadc4>Iadc) Iadc=Iadc4;
      return Iadc;
   }
unsigned int16 minPauza(unsigned int8 refStruja)
   {  //Funkcija za mjerenje vremena 
      unsigned int16 vrijeme;
      Kanal(0);   //Aktiviranje analognog ulaza AN0
      set_timer1(0); //Setovanje tajmera1 na nulu
      korak1(0);     //Pravljenje prvog koraka
      while(read_adc()<refStruja);
      //Vrti praznu petlju dok se ne napravi korak
      //korak je napravlejn kada struja dosegne svoj maskimum
      vrijeme=get_timer1(); //varijabli vrijeme dodjeli izmjerenoe vrijeme
      return vrijeme;
      }

//***Glavni program****
void main()
{
unsigned int8 rad,smjer,k4,k3,k2,k1,k0,v4,v3,v2,v1,v0;
//rad={1-testiraj motor,2-koracaj,3-zaustavi,default-cekaj novu komandu}
//smjer={1-jedan smjer,2-drugi smjer,default-cekaj novu komandu}
unsigned int8 nStruja,stanje;
//stanje-stanje koraèanja
unsigned int16 minvrijeme;
//nStruja-nominalna struja(racuna se na osnovu struje koja pravi pad napona na
//        otporu 1kOhm, nStruja=int8(5*In/255); )
unsigned long long korak,brzina;
//korak-broj koraka koje treba da napravi motor
unsigned long pauza;
//pauza-raèuna se prema definisanoj brzini vrtnje
setup_adc_ports(ALL_ANALOG);    //Svi ulazni portovi su analogni
setup_adc(ADC_CLOCK_INTERNAL);   //Klok AD konverzije interni
pocetak:
setup_timer_1(T1_INTERNAL|T1_DIV_BY_8);   //Setovanje tajmer1 brojaèa
while(1)
{
   rad=0;
   smjer=0;
   k0=0;
   k1=0;
   k2=0;
   k3=0;
   k4=0;
   v0=0;
   v1=0;
   v2=0;
   v3=0;
   v4=0;
   stanje=0;
   if(kbhit())
   if(getc()=='#')
   //Da li je stigla nova poruka?
   do {
      while(!kbhit()); //Èekanje na slijedeæi znak
      rad=getc();
      //Granjanje programa u zavisnosti od rada
      switch(rad)
      {
         case '1':
            //testiranje
            rad1:
            nStruja=testStruje();   //mjerenje maksimalne struje
            minvrijeme=minPauza(nStruja);
            //mjerenje minimalnog vremena potrebnog za pravljenje jednog koraka
            putc(nStruja); //Posalji vrijednost makismalne struje racunaru
            Delay_ms(500); //Napravi pauzu
            putc(MAKE8(minvrijeme,0));
            Delay_ms(500);
            putc(MAKE8(minvrijeme,1));
            //Slanje raèunaru minimalnog vremena po 8-bita sekvencijalno
            setup_timer_1 (T1_DISABLED);  //iskljuèi tajmer1
            goto pocetak;  //Vrati se na poèetak programa i èekaj novu komandu
         case '2':
            //koraèanje
            rad2:
            while(!kbhit());
            smjer=getc();  //primi informaciju o smjeru vrtnje
            while(!kbhit());
            k4=getc();  //Primi informaciju o broju koraka
            //Broj koraka je petocifren broj i svaka cifra se salje kao 8 bitni
            //znak. Isto vazi i za brzinu
            while(!kbhit());
            k3=getc();
            while(!kbhit());
            k2=getc();
            while(!kbhit());
            k1=getc();
            while(!kbhit());
            k0=getc();
            korak=broj32((k4-48),(k3-48),(k2-48),(k1-48),k0-48);
            //Od pet 8-bitnih cifara pravi se jedan petocifren broj od 32 bita
            while(!kbhit());
            v4=getc();
            while(!kbhit());
            v3=getc();
            while(!kbhit());
            v2=getc();
            while(!kbhit());
            v1=getc();
            while(!kbhit());
            v0=getc();
            brzina=broj32(v4-48,v3-48,v2-48,v1-48,v0-48);
            pauza=(int16)60000/brzina;
            //pauza se racuna na osnovu informacije o brzini
            switch(smjer)
            {  //Na osnovu smjera definise se redosljed okidanja faza motora
               case '1':
                  stanje=0;
                  for(;korak!=0;korak--)
                  {  //provjera da li je u meðuvremenu stigla nova poruka
                     //Ako je sljedi instrukcije
                     if(kbhit())
                     if(getch()=='#')
                     {
                        while(!kbhit());
                        rad=getch();
                        switch (rad)
                        {
                           case '1':
                              goto rad1;
                           case '2':
                              goto rad2;
                           case '3':
                              goto pocetak;
                           default:
                              goto pocetak;
                        }
                     }
                     if (stanje==4) //Resetovanje varijable stanje
                     stanje=0;
                     stanje++;
                     switch (stanje)
                     {
                        case 1:
                        korak1(pauza);
                        break;
                        case 2:
                        korak2(pauza);
                        break;
                        case 3:
                        korak3(pauza);
                        break;
                        case 4:
                        korak4(pauza);
                        break;
                     }
                  }
                  goto pocetak;
               case '2':
               //suprotan smjer
                  stanje=0;
                  for(;korak!=0;korak--)
                  {
                     if(kbhit())
                     if(getch()=='#')
                     {
                        while(!kbhit());
                        rad=getch();
                        switch (rad)
                        {
                           case '1':
                              goto rad1;
                           case '2':
                              goto rad2;
                           case '3':
                              goto pocetak;
                           default:
                              goto pocetak;
                        }
                           goto pocetak;
                     }
                     if (stanje==4)
                     stanje=0;
                     stanje++;
                     switch (stanje)
                     {
                        case 1:
                        korak4(pauza);
                        break;
                        case 2:
                        korak3(pauza);
                        break;
                        case 3:
                        korak2(pauza);
                        break;
                        case 4:
                        korak1(pauza);
                        break;
                     }
                  }
                  goto pocetak;
               default:
                  goto pocetak;
            }
         case '3':
            goto pocetak;
         default:
            goto pocetak;
      }
   }
      while(1);
   
   }
//KRAJ!!!
}

