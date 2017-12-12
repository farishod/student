/**
 * Thread koji sluzi za komunikaciju sa klientom putem GPRS Tcp Socket protokola.
 */
package pioneerserver;

import java.awt.Color;
import java.awt.Frame;
import java.net.Socket;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;
import java.util.Vector;

public class ClientThread implements Runnable {
    /** Socket klienta*/
    private Socket sock = null;
    /** Ulazni stream za socket port*/
    private InputStream sockInput = null;  
    /** Izlazni stream za socket port*/
    public OutputStream sockOutput = null;
    /** Nova nit za klienta*/
    private Thread myThread = null;
    /** Dugme koje vizuelno oslikava klienta*/
    public java.awt.Button client;
    /** Okvir klienta*/
    private ClientFrame clientProporties;
    /** Maticni okvir*/
    private Frame parent;
    /** Ime klienta*/
    public String name;
    /** Model klienta*/
    public String model;
    /** Identifikaciona oznaka klienta*/
    public int ID;
    /** Aktuelni datum*/
    private byte actualDate=0;
    /** Aktuelni mjesec*/
    private byte actualMonth=0;
    /** Aktuelna godina*/
    private byte actualYear=0;
    /** Aktuelni sat*/
    private byte actualHour=0;
    /** Aktuelna minuta*/
    private byte actualMinute=0;
    /** Aktuelna sekunda*/
    private byte actualSecunde=0;
    /** Aktuelna geografska sirina*/
    private float actualLatitude=0;
    /** Aktuelna geografska duzina*/
    private float actualLongitude=0;
    /** Aktuelna nadmorska visina*/
    private int actualAltitude=0;
    /** Aktuelni kurs*/
    private float actualCourse=0;
    /** Aktuelna brzina kretanja*/
    private float actualSpeed=0;
    /** Aktivacija manuelne kontrole kretanja*/
    public boolean ManuelControl=false;
    /** Akticacija automatske kontrole kretanja*/
    public boolean AutomaticControl=true;
    /** */
    private boolean disConnectClient=false;
    /** Ciljna geografska sirina*/
    public float finisLatitude=0;
    /** Ciljna geografska duzina*/
    public float finishLongitude=0;
    /** Pozicija po x osi*/
    public int xposition=0;
    /** Stara pozicija po x osi*/
    public int oldxposition=0;
    /** Pozicija po y osi*/
    public int yposition=0;
    /** Stara pozicija po y osi*/
    public int oldyposition=0;
    /** Vektor tacaka po x osi*/
    public Vector ClientPathx=new Vector(100);
    /** Vektor tacaka po y osi*/
    public Vector ClientPathy=new Vector(100);
    /** Broj zauzetosti klientima*/
    public int num=0;
    /** Konekcija sa .kml fajlom za Google Earth*/
    FromID file;
    /**
     * Konstruktor niti za komunikaciju sa klientom
     * @param sock soket port
     * @param parent maticni okvir
     * @throws java.io.IOException
     */
    public ClientThread(Socket sock, java.awt.Frame parent) throws IOException {
        //Uvecati broj online klienata za +1 i taj broj dodjeliti ovoj niti
        num=++GlobalVariables.noClient;
        //prepisivanje maticnog okvira
        this.parent=parent;
        // Prepisivanje soket porta
        this.sock = sock;
        // Dodjeljivanje imena klientu
        this.name ="Pioneer";
        // Dodjeljivanje modela klientu
        this.model="3D-x";
        // Dodjeljivanje IDa klientu, privremeno 0
        this.ID=0;
        try{
            //Otvaranje ulaznog stream soket porta
            sockInput = sock.getInputStream();
            // Otvaranje izlaznog stream komunikacije
            sockOutput = sock.getOutputStream();
            // Kreiranje niti korisnika
            myThread=new Thread(this);
            Log.getInstance().write("New Client Thread ...");
        }catch(IOException ex){
            Log.getInstance().write("ERROR ClientThread 1: "+ex);
        }catch(NullPointerException ex){
            Log.getInstance().write("ERROR ClientThread 2: "+ex);
        }
        //U globalne varijable putanja dodati putanju ovog korisnika
        GlobalVariables.forPaintx.add(ClientPathx);
        GlobalVariables.forPainty.add(ClientPathy);
    }
    /**
     * Funkcija koja se izvrsava nakon klika na ikonu klienta
     * @param evt
     */
    private void clientActionPerformed(java.awt.event.ActionEvent evt) {
        //Prikaz okvira klienta
        PioneerServerApp.getApplication().show(clientProporties);
    }
    /**
     * Funkcija koja diskonektuje klienta
     */
    public void disconnectClient(){
        try{
            //Zatvaraju se streamovi i konekcija sa klientom
            sockInput.close();
            sockOutput.close();
            sock.close();
            //Zatvara se okvir klienta
            clientProporties.closeClientFrame();
            client.setVisible(false);
            //Broj online klienata smanjiti za -1
            GlobalVariables.noClient--;
            //Postaviti da je klient diskonektovan
            disConnectClient=true;
            //Izbrisati klientove putanje
            GlobalVariables.forPaintx.removeElementAt(num-1);
            GlobalVariables.forPainty.removeElementAt(num-1);
            //ugasiti thread nakon 50ms
            myThread.join(50);
            //Obrisati putanju
            PioneerServerApp.Instance.getMainPanel(-1, -1).updateUI();
            Log.getInstance().write("Disconnect Client ... ");
        }catch(IOException ex){
            Log.getInstance().write("ERROR ClientThread 3: "+ex);
        }catch(NullPointerException ex){
            Log.getInstance().write("ERROR ClientThread 4: "+ex);
        }catch(InterruptedException ex){
            Log.getInstance().write("ERROR ClientThread 5: "+ex);
        }catch(ArrayIndexOutOfBoundsException ex){
            Log.getInstance().write("ERROR ClientThread 6: "+ex);
        }
        disConnectClient=true;
    }
    /**
     * Pokretanje klientove niti
     */
    public void start() {
        try{
            myThread.start();
        }catch(IllegalThreadStateException ex){
            Log.getInstance().write("ERROR ClientThread 7: "+ex);
        }
    }
    /**
     * Konverzija polja bajta u float vrijednost
     * @param b polje bajta
     * @return float vrijednost
     */
    public static float byteArrayToFloat(byte[] b) {
        int value = 0;
        for (int i = 0; i < 4; i++) {
            int shift = (4 - 1 - i) * 8;
            value += (b[i]&0x000000FF) << shift;
        }
        return Float.intBitsToFloat(value);
    }
    /**
     * Konverzija polja bajta u int vrijednost
     * @param b polje bajta
     * @return int vrijednost
     */
    public static int byteArrayToInt(byte[] b) {
        int value = 0;
        for (int i = 0; i < 4; i++) {
            int shift = (4 - 1 - i) * 8;
            value += (b[i]&0x000000FF) << shift;
        }
        return value;
    }
    /**
     * 
     */
    @Override
    public void run() {
        //spremnik pristiglih bajta
        byte[] rbuffer=new byte[28];
        //dok modul nije diskonektovan
        while(!disConnectClient) {            
            try {
                //bajt check sume
                byte checksum = 0;
                //vrijednost trenutno ocitanog bajta
                int currentByte = 0;
                Log.getInstance().write("Recive from Client:");
                //ocitati trenutni bajt
                String s="Test";
                sockOutput.write(s.getBytes());
                currentByte = sockInput.read();
                Log.getInstance().write(Integer.toString(currentByte));
                //ako je trenutni bajt '#'
                if(currentByte==35) {
                    //ocitati ostalih 28 bajta
                    for(int i=0;i<28;i++){
                        currentByte=sockInput.read();
                        Log.getInstance().write(Integer.toString(currentByte));
                        //ako je trnutni bajt <0 preskoci dalje citanje
                        if(currentByte<0)
                            break;
                        //u spremnik upisati ocitani bajt
                        rbuffer[i]=(byte)currentByte;
                        //uvecati CS
                        checksum+=(byte)currentByte;
                    }
                    Log.getInstance().write("...");
                    //od CS oduzeti poslatu CS
                    checksum-=(byte)currentByte;
                    //Ako proracunata CS odgovara ocitanoj CS
                    if(checksum==(byte)currentByte){
                        byte[] temp;
                        //Prepisati ID klienta
                        ID=rbuffer[0];
                        //Prepisati 4 bajta latitude  
                        temp=new byte[] {rbuffer[1],rbuffer[2],rbuffer[3],rbuffer[4]};
                        //Pretvoriti bajte u Float vrijednost
                        actualLatitude=byteArrayToFloat(temp);
                        //Prepisati 4 bajta longitude
                        temp=new byte[] {rbuffer[5],rbuffer[6],rbuffer[7],rbuffer[8]};
                        //Pretvoriti u Float vrijednost
                        actualLongitude=byteArrayToFloat(temp);
                        //Prepisati 4 bajta brzine
                        temp=new byte[] {rbuffer[9],rbuffer[10],rbuffer[11],rbuffer[12]};
                        //Pretvoriti u int vrijednost
                        actualAltitude=byteArrayToInt(temp);
                        //Prepisati 4 bajta brzine
                        temp=new byte[] {rbuffer[13],rbuffer[14],rbuffer[15],rbuffer[16]};
                        //Pretvoriti u Float vrijednost
                        actualSpeed=byteArrayToFloat(temp);
                        //Prepisati 4 bajta kursa
                        temp=new byte[] {rbuffer[17],rbuffer[18],rbuffer[19],rbuffer[20]};
                        //Pretvoriti u Float vrijednost
                        actualCourse=byteArrayToFloat(temp);
                        //Prepisati aktuelni datum i vrijeme
                        actualDate=rbuffer[21];
                        actualMonth=rbuffer[22];
                        actualYear=rbuffer[23];
                        actualHour=rbuffer[24];
                        actualMinute=rbuffer[25];
                        actualSecunde=rbuffer[26];
                        //Pretvoriti vrijeme u String oblika dd.mm.yy hh:mm:ss
                        String date="";
                        if(actualDate<10)
                            date+="0";
                        date+=actualDate;
                        date+=".";
                        if(actualMonth<10)
                            date+="0";
                        date+=actualMonth;
                        date+=".";
                        if(actualYear<10)
                            date+="0";
                        date+=actualYear;
                        date+=" ";
                        if(actualHour<10)
                            date+="0";
                        date+=actualHour;
                        date+=":";
                        if(actualMinute<10)
                            date+="0";
                        date+=actualMinute;
                        date+=":";
                        if(actualSecunde<10)
                            date+="0";
                        date+=actualSecunde;
                        //Ako nema referentne pozicije
                        if(!GlobalVariables.referentePosition){
                            //Postaviti da postoji referentna pozicija
                            GlobalVariables.referentePosition=true;
                            //Prepisati vrijednosti u referentnu poziciju
                            GlobalVariables.referentLatitude=actualLatitude;
                            GlobalVariables.referentLongitude=actualLongitude;
                        }
                        //Preracunati lokalne varijable
                        yposition=(int) (GlobalVariables.EARTHRADIUS*(GlobalVariables.referentLatitude-actualLatitude)*GlobalVariables.M2PIXEL/GlobalVariables.RATIO*Math.PI/180+GlobalVariables.YREFERENT);
                        xposition=(int) (GlobalVariables.EARTHRADIUS*(actualLongitude-GlobalVariables.referentLongitude)*GlobalVariables.M2PIXEL/GlobalVariables.RATIO*Math.PI/180+GlobalVariables.XREFERENT);
                        //Ako nije kreiran klient okvir
                        if(clientProporties==null){
                            //napraviti fajlove
                            file=new FromID(ID);
                            //Napraviti novi klient Okvir
                            clientProporties=new ClientFrame(this, parent);
                            //Dodati naziv
                            clientProporties.setTitle("Client ID: ETF"+ID);
                            //Dodati klienta
                            client=new java.awt.Button();
                            client.setLabel(String.valueOf(ID));
                            client.setFont(new java.awt.Font("Verdana",java.awt.Font.BOLD,9));
                            client.setBackground(new Color(51, 255, 0));
                            client.setSize(30, 30);
                            PioneerServerApp.Instance.getMainPanel(xposition,yposition).add(client,PioneerServerApp.Instance.getMainPanel(xposition,yposition));
                            client.setBackground(new Color(51, 255, 0));
                            client.setVisible(true);
                            //Dodavanje osluskivanj pritiska dugmeta koje predstavlja klienta
                            client.setActionCommand("client");
                            client.addActionListener(new java.awt.event.ActionListener() {
                                @Override
                                public void actionPerformed(java.awt.event.ActionEvent evt) {
                                clientActionPerformed(evt);
                                }
                            });
                            //Prepisati nove pozicije u stare
                            oldxposition=xposition;
                            oldyposition=yposition;
                            
                        }
                        //Postavljanje klienta na proracunatu lokaciju
                        client.setLocation(xposition,yposition);
                        //Dodati lokaciju u putanje
                        ClientPathx.addElement(xposition);
                        ClientPathy.addElement(yposition);
                        GlobalVariables.forPaintx.setElementAt(ClientPathx,num-1);
                        GlobalVariables.forPainty.setElementAt(ClientPathy,num-1);
                        //Pisanje pozicije u .klm fajl
                        file.writePositions(actualLongitude,actualLatitude,(float)0,actualYear,actualMonth,actualDate,actualHour,actualMinute,actualSecunde);
                        this.clientProporties.refreshPositions(date,
                                String.valueOf(actualLatitude),String.valueOf(actualLongitude),
                                String.valueOf(actualAltitude),String.valueOf(actualCourse),String.valueOf(actualSpeed));
                        //java.awt.geom.Line2D l= new Line2D.Float(new Point(100,200),new Point(100,300));
                    }
                } else if(currentByte==-1){
                    disconnectClient();
                }
            } catch (IOException ex) {            
                Log.getInstance().write("ERROR ClientThread 7: "+ex);
                disconnectClient();
            } catch (Exception ex){
		Log.getInstance().write("ERROR ClientThread 8: "+ex);
	    }            
        }
    } 
}