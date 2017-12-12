/*
 * Klasa u kojoj se cuvaju Globalne Variable
 */

package pioneerserver;

import java.util.Vector;
/**
 *
 * @author Administrator
 */
public class GlobalVariables {
    /** Broje soket porta*/
    public static int socketPort=5938;
    /** Adresa serveram http pristup*/
    public static String ServerAddress=null;
    /** Broj online klienata*/
    public static int noClient=0;
    /** Pozicija kursora misa pri odre?ivanju ciljne tacke*/
    public static float XmousePointer=0;
    /** Pozicija kursora misa pri odre?ivanju ciljne tacke*/
    public static float YmousePointer=0;
    /** Da li je odre?ena refrentna pozicija*/
    public static boolean referentePosition=false;
    /** Referentna geografska sirina*/
    public static float referentLatitude=0;
    /** Referentna geografska duzina*/
    public static float referentLongitude=0;
    /** Referentna pozicija po x osi za lokalni sistema*/
    public static final int XREFERENT=5000;
    /** Referentna pozicija po y osi za lokalni sistema*/
    public static final int YREFERENT=5000;
    /** Omjer sklairanja globalnog sistema na lokalni*/
    public static int RATIO=10000; //2.645833333 m
    /** Konstnta pretvorbe metara u piksele*/
    public static final double M2PIXEL=3779.527559055;
    /** Konstana srednji radius zemlje*/
    public static final long EARTHRADIUS=6371009; //m
    /** Vektor x vrijednosti tacaka za linije*/
    public static Vector forPaintx=new Vector(20);
    /** Vektor y vrijednosti tacaka za linije*/
    public static Vector forPainty=new Vector(20);
    /** Prvi dio zaglavlja za upis u klm fajlove*/
    public static final byte[] Chapter1=String.valueOf("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r"+
            "<kml xmlns=\"http://www.opengis.net/kml/2.2\" xmlns:gx=\"http://www.google.com/kml/ext/2.2\" xmlns:kml=\"http://www.opengis.net/kml/2.2\" xmlns:atom=\"http://www.w3.org/2005/Atom\">\r"+
                    "<Document>\r"+
                    "<name>ID ").getBytes();
    //izmedju ide id
    /** Drugi dio zaglavlja za upis u klm fajlove*/
    public static final byte[] Chapter2=String.valueOf("</name>\r"+
                    "<open>1</open>\r"+
                    "<Style>\r"+
                    "<ListStyle>\r"+
                    "<listItemType>check</listItemType>\r"+
                    "<bgColor>00ffffff</bgColor>\r"+
                    "<maxSnippetLines>2</maxSnippetLines>\r"+
                    "</ListStyle>\r"+
                    "</Style>\r"+
                    "<Style id=\"sn_ylw-pushpin\">\r"+
                    "<IconStyle>\r"+
                    "<scale>1.1</scale>\r"+
                    "<Icon>\r"+
                    "<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>\r"+
                    "</Icon>\r"+
                    "<hotSpot x=\"20\" y=\"2\" xunits=\"pixels\" yunits=\"pixels\"/>\r"+
                    "</IconStyle>\r"+
                    "</Style>\r"+
                    "<Style id=\"sh_ylw-pushpin\">\r"+
                    "<IconStyle>\r"+
                    "<scale>1.3</scale>\r"+
                    "<Icon>\r"+
                    "<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>\r"+
                    "</Icon>\r"+
                    "<hotSpot x=\"20\" y=\"2\" xunits=\"pixels\" yunits=\"pixels\"/>\r"+
                    "</IconStyle>\r"+
                    "</Style>\r"+
                    "<StyleMap id=\"msn_ylw-pushpin\">\r"+
                    "<Pair>\r"+
                    "<key>normal</key>\r"+
                    "<styleUrl>#sn_ylw-pushpin0</styleUrl>\r"+
                    "</Pair>\r"+
                    "<Pair>\r"+
                    "<key>highlight</key>\r"+
                    "<styleUrl>#sh_ylw-pushpin0</styleUrl>\r"+
                    "</Pair>\r"+
                    "</StyleMap>\r"+
                    "<Style id=\"sh_ylw-pushpin0\">\r"+
                    "<IconStyle>\r"+
                    "<scale>1.3</scale>\r"+
                    "<Icon>\r"+
                    "<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>\r"+
                    "</Icon>\r"+
                    "<hotSpot x=\"20\" y=\"2\" xunits=\"pixels\" yunits=\"pixels\"/>\r"+
                    "</IconStyle>\r"+
                    "</Style>\r"+
                    "<Style id=\"sn_ylw-pushpin0\">\r"+
                    "<IconStyle>\r"+
                    "<scale>1.1</scale>\r"+
                    "<Icon>\r"+
                    "<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>\r"+
                    "</Icon>\r"+
                    "<hotSpot x=\"20\" y=\"2\" xunits=\"pixels\" yunits=\"pixels\"/>\r"+
                    "</IconStyle>\r"+
                    "</Style>\r"+
                    "<Style id=\"yellowLine\">\r"+
                    "<LineStyle>\r"+
                    "<color>7f00ffff</color>\r"+
                    "<width>4</width>\r"+
                    "</LineStyle>\r"+
                    "<PolyStyle>\r"+
                    "<color>7f00ff00</color>\r"+
                    "</PolyStyle>\r"+
                    "</Style>\r"+
                    "<StyleMap id=\"msn_ylw-pushpin0\">\r"+
                    "<Pair>\r"+
                    "<key>normal</key>\r"+
                    "<styleUrl>#sn_ylw-pushpin</styleUrl>\r"+
                    "</Pair>\r"+
                    "<Pair>\r"+
                    "<key>highlight</key>\r"+
                    "<styleUrl>#sh_ylw-pushpin</styleUrl>\r"+
                    "</Pair>\r"+
                    "</StyleMap>\r"+
                    "<Style id=\"sn_ylw-pushpin1\">\r"+
                    "<LineStyle>\r"+
                    "<color>ff7fff00</color>\r"+
                    "<width>2</width>\r"+
                    "</LineStyle>\r"+
                    "</Style>\r"+
                    "<Placemark>\r"+
                    "<name>ID: ").getBytes();
    //izmedju ide id
    /** Treci dio zaglavlja za upis u klm fajlove*/
    public static final byte[] Chapter3=String.valueOf("</name>\r"+
                    "<description>The trajectory of movement of mobile robot Pioneer 3D-X, ID: ").getBytes();
    //izmedju ide id
    /** Cetvrti dio zaglavlja za upis u klm fajlove*/
    public static final byte[] Chapter4=String.valueOf("</description>\r"+
                    "<styleUrl>#sn_ylw-pushpin1</styleUrl>\r"+
                    "<LineString>\r"+
                    "<extrude>1</extrude>\r"+
                    "<tessellate>1</tessellate>\r"+
                    "<coordinates>\r").getBytes();
    //idu pozicije za trajektoriju
    /** Peti dio zaglavlja za upis u klm fajlove*/
    public static final byte[] Chapter5=String.valueOf("</coordinates>\r"+
                    "</LineString>\r"+
                    "</Placemark>\r"+
                    "<Placemark>\r"+
                    "<name>ID ").getBytes();
    //ide id
    /** Sedmi dio zaglavlja za upis u klm fajlove*/
    public static final byte[] Chapter7=String.valueOf("</name>\r"+
                    "<LookAt>\r"+
                    "<gx:TimeStamp><when>\r").getBytes();
    //ide vrijeme oblika 2010-07-24T23:07:00Z
    /** Osmi dio zaglavlja za upis u klm fajlove*/
    public static final byte[] Chapter8=String.valueOf("</when>\r"+
                    "</gx:TimeStamp>\r"+
                    "<tilt>0</tilt>"+
                    "<altitudeMode>relativeToGround</altitudeMode>"+
                    "<gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode>"+
                    "</LookAt>"+
                    "<styleUrl>#msn_ylw-pushpin</styleUrl>"+
                    "<Point>"+
                    "<coordinates>\r").getBytes();
    //ide zadnja pozicija
    /** Deveti dio zaglavlja za upis u klm fajlove*/
    public static final byte[] Chapter9=String.valueOf("</coordinates>\r"+
                    "</Point>\r"+
                    "</Placemark>\r"+
                    "</Document>\r"+
                    "</kml>").getBytes();
    public static final byte[] link1=String.valueOf("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r"+
                    "<kml xmlns=\"http://www.opengis.net/kml/2.2\" xmlns:gx=\"http://www.google.com/kml/ext/2.2\" xmlns:kml=\"http://www.opengis.net/kml/2.2\" xmlns:atom=\"http://www.w3.org/2005/Atom\">\r"+
                    "<NetworkLink>\r"+
                    "<name>ID ").getBytes();
    //ide id
    public static final byte[] link2=String.valueOf("</name>\r"+
                    "<open>1</open>\r"+
                    "<Link>\r"+
                    "<href>http://faery.podzone.net/ClientsData/FromID").getBytes();
    //ide id
    public static final byte[] link3=String.valueOf(".kml</href>\r"+
                    "<refreshMode>onInterval</refreshMode>\r"+
                    "</Link>\r"+
                    "</NetworkLink>\r"+
                    "</kml>\r").getBytes();
    /** Putanja u koju se smjestaju putanje u formi kml*/
    public static final String fromIdPath="C:/PioneerServer/httpServer/ClientsData/";
    /** Putanja u koju se smjestaju linkovi u formi kml fajla*/
    public static final String linkIdPath="C:/PioneerServer/httpServer/NetworkLinks/";
    /** Putanja u koju se sjest logo fajl */
    public static final String logFilePath="C:/PioneerServer/Logo/";
}
