/*
 * Klasa koja ima zadatak manipuliranje sa .klm fajlovima za GoogleEarth. Radi se
 * o dvije vrste fajlova: prvi tip su link fajlovi za pracenje klienta, a drugi
 * tip su fajlovi u kojima se cuva putanja kretanja klienta.
 */
package pioneerserver;

import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
/**
 *
 * @author Administrator
 */
public class FromID {
    /** ID klienta*/
    int id=0;
    /** Konekcija sa fajlom proizvoljnog pristupa*/
    RandomAccessFile rafile;
    /** Konekcija sa fajlom proizvoljnog pristupa*/
    RandomAccessFile ralink;
    /** File koji sadrzi putanju kretanja*/
    File file;
    /** Fajl koji predstavlja link*/
    File link;
    /** Da li fajlovi postoje*/
    boolean exist=false;
    /** Da li je konekcija sa fajlom otvorena*/
    boolean isOpen=false;
    /** Brojac upisanih bajta*/
    long counter=0;
    /**
     * Konstruktor za link fajlove i fajl putanje kretanja
     * @param id broj klienta
     */
    public FromID(int id){
        //Prepisuje se ID klienta
        this.id=id;
        try{
            file=new File(GlobalVariables.fromIdPath+"FromID"+id+".kml");
            link=new File(GlobalVariables.linkIdPath+"LinkID"+id+".kml");
            if(file.exists())
                file.delete();
            file.createNewFile();
            if(link.exists())
                link.delete();
            link.createNewFile();
            rafile = new RandomAccessFile(file,"rw");
            ralink = new RandomAccessFile(link,"rw");
        }catch(IOException ex){
            Log.getInstance().write("ERROR From ID 1: : "+ex);
        }catch(NullPointerException ex){
            Log.getInstance().write("ERROR From ID 2: : "+ex);
        }catch(SecurityException ex){
            Log.getInstance().write("ERROR From ID 3: : "+ex);
        }
    }
    /**
     * Pisanje pozicije i vremena u fajl koji biljzi putanju kretanja
     * @param Longitude geografska duzina
     * @param Latitude geografska sirina
     * @param Altitude nadmorska visina
     * @param year godina
     * @param month mjesec
     * @param day dan
     * @param hour sat (GMT)
     * @param minute minute
     * @param secunde sekunde
     */
    public void writePositions(float Longitude, float Latitude, float Altitude, byte year, byte month, byte day, byte hour, byte minute, byte secunde){
        //Ako se fajl kreira prvi put
        if(!exist){
            try{
                rafile.write(GlobalVariables.Chapter1);
                counter+=GlobalVariables.Chapter1.length;
                rafile.write(String.valueOf(id).getBytes());
                counter+=String.valueOf(id).getBytes().length;
                rafile.write(GlobalVariables.Chapter2);
                counter+=GlobalVariables.Chapter2.length;
                rafile.write(String.valueOf(id).getBytes());
                counter+=String.valueOf(id).getBytes().length;
                rafile.write(GlobalVariables.Chapter3);
                counter+=GlobalVariables.Chapter3.length;
                rafile.write(String.valueOf(id).getBytes());
                counter+=String.valueOf(id).getBytes().length;
                rafile.write(GlobalVariables.Chapter4);
                counter+=GlobalVariables.Chapter4.length;
                //sada idu pozicije
                String temp1=String.valueOf(Longitude)+","+String.valueOf(Latitude)+","+String.valueOf(Altitude)+"\r";
                rafile.write(temp1.getBytes());
                counter+=temp1.getBytes().length;
                rafile.write(GlobalVariables.Chapter5);
                rafile.write(String.valueOf(id).getBytes());
                rafile.write(GlobalVariables.Chapter7);
                String temp="20";
                if(year<10)
                    temp+="0";
                temp+=String.valueOf(year);
                temp+="-";
                if(month<10)
                    temp+="0";
                temp+=String.valueOf(month);
                temp+="-";
                if(day<10)
                    temp+="0";
                temp+=String.valueOf(day);
                temp+="T";
                if(hour<10)
                    temp+="0";
                temp+=String.valueOf(hour);
                temp+=":";
                if(minute<10)
                    temp+="0";
                temp+=String.valueOf(minute);
                temp+=":";
                if(secunde<10)
                    temp+="0";
                temp+=String.valueOf(secunde);
                temp+="Z";
                rafile.write(temp.getBytes());
                rafile.write(GlobalVariables.Chapter8);
                temp1=String.valueOf(Longitude)+","+String.valueOf(Latitude)+","+String.valueOf(Altitude)+"\r";
                rafile.write(temp1.getBytes());
                rafile.write(GlobalVariables.Chapter9);
                exist=true;
                ralink.write(GlobalVariables.link1);
                ralink.write(String.valueOf(id).getBytes());
                ralink.write(GlobalVariables.link2);
                ralink.write(String.valueOf(id).getBytes());
                ralink.write(GlobalVariables.link3);
            }catch(IOException ex){
                Log.getInstance().write("ERROR From ID 4: : "+ex);
            }catch(NullPointerException ex){
                Log.getInstance().write("ERROR From ID 5: : "+ex);
            }
        //Ako je fajl vec kreiran    
        } else {
            try{
                rafile.seek(counter);
                String temp1=String.valueOf(Longitude)+","+String.valueOf(Latitude)+","+String.valueOf(Altitude)+"\r";
                rafile.write(temp1.getBytes());
                counter+=temp1.getBytes().length;
                rafile.write(GlobalVariables.Chapter5);
                rafile.write(String.valueOf(id).getBytes());
                rafile.write(GlobalVariables.Chapter7);
                String temp="20";
                if(year<10)
                    temp+="0";
                temp+=String.valueOf(year);
                temp+="-";
                if(month<10)
                    temp+="0";
                temp+=String.valueOf(month);
                temp+="-";
                if(day<10)
                    temp+="0";
                temp+=String.valueOf(day);
                temp+="T";
                if(hour<10)
                    temp+="0";
                temp+=String.valueOf(hour);
                temp+=":";
                if(minute<10)
                    temp+="0";
                temp+=String.valueOf(minute);
                temp+=":";
                if(secunde<10)
                    temp+="0";
                temp+=String.valueOf(secunde);
                temp+="Z";
                rafile.write(temp.getBytes());
                rafile.write(GlobalVariables.Chapter8);
                temp1=String.valueOf(Longitude)+","+String.valueOf(Latitude)+","+String.valueOf(Altitude)+"\r";
                rafile.write(temp1.getBytes());
                rafile.write(GlobalVariables.Chapter9);
            }catch(IOException ex){
                Log.getInstance().write("ERROR From ID 6: : "+ex);
            }catch(NullPointerException ex){
                Log.getInstance().write("ERROR From ID 7: : "+ex);
            }
        }
    }
}