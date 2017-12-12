/*
 * Klasa koja ima zadatak logovanje dogadjaja.
 */
package pioneerserver;

import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
/**
 *
 * @author Administrator
 */
public class Log {
    /** Instanca klase log*/
    static Log instance=null;
    /** Konekcija sa fajlom proizvoljnog pristupa*/
    RandomAccessFile logFile=null;
    /** File koji sadrzi putanju kretanja*/
    File file=null;
    /** Da li fajl postoji*/
    boolean exist=false;
    /** Da li je konekcija sa fajlom otvorena*/
    boolean isOpen=false;
    /** Da li se vrsi logiranje u fajl */
    public boolean logToFile = true;
    /** Da li se vrsi ispis preko STDOUT*/
    public boolean logToSTDOUT = true;
    /**
     * Konstruktor za link fajlove i fajl putanje kretanja
     * @param id broj klienta
     */
    private Log(){
        try{
            file=new File(GlobalVariables.logFilePath+"log.txt");
            if(!file.exists())
                file.createNewFile();
            logFile = new RandomAccessFile(file,"rw");
            logFile.seek(logFile.length());
        }catch(IOException ex){
            System.out.println("ERROR Log 1: "+ex);
        }catch(NullPointerException ex){
            System.out.println("ERROR Log 2: "+ex);
        }catch(SecurityException ex){
            System.out.println("ERROR Log 3: "+ex);
        }
    }
    public static Log getInstance(){
        if(instance==null){
            instance=new Log();
        }
        return instance;
    }
    /**
     * Vraca datum i vrijeme u String formatu
     * @return datum i vrijeme
     */
    private String getDateTime() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Date date = new Date();
        return dateFormat.format(date);
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
    public void write(String s){
        try{
            if(logToSTDOUT){
                System.out.println(s);
            }
            logFile.writeBytes("["+getDateTime()+"] "+s+"\r\n");
        }catch(IOException ex){
            System.out.println("ERROR Log 4: "+ex);
        }catch(NullPointerException ex){
            System.out.println("ERROR Log 5: "+ex);
        }
    }
}