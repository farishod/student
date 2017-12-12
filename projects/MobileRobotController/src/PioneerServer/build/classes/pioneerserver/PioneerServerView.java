/*
 * Glavni okvir aplikacije
 */

package pioneerserver;

import java.awt.Graphics;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.nio.channels.IllegalBlockingModeException;
import org.jdesktop.application.Action;
import org.jdesktop.application.SingleFrameApplication;
import org.jdesktop.application.FrameView;
import java.util.TimerTask;
import java.util.Timer;
import java.util.Vector;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.KeyStroke;

/**
 * 
 * @author Faris Hodzic
 */
public class PioneerServerView extends FrameView {
    /** Indikacija da li je otvorena konekcija za server*/
    private boolean ServerConnection=false;
    /** Tajmer za osluskivanje socket porta*/
    public Timer ServerSockTimer;
    /** Server socket */
    private ServerSocket serverSock = null;
    /** Socket klienta*/
    private Socket sock = null;
    
    public PioneerServerView(SingleFrameApplication app) {
        super(app);
        initComponents();
        this.jLabel1.setText("Started ...");
        Log.getInstance().write("Started ... ");
        this.jLabel2.setText("1 : "+GlobalVariables.RATIO);
        //Onemogucuje se konekcija dok se ne postavi server
        this.jMenuItem1.setEnabled(false);
        //Onemogucuje se konekcija na http
        this.jMenuItem4.setEnabled(false);
    }
    //Otvaranje http:// servera
    @Action
    public void openHttp(){
        try{
            //Otvaranje Internet Explorera
            Runtime.getRuntime().exec("C:\\Program Files\\Internet Explorer\\IEXPLORE.EXE "+GlobalVariables.ServerAddress);
        }catch(IOException ex){
            Log.getInstance().write("ERROR Log PioneerServerView 1: "+ex);
            JOptionPane.showMessageDialog(PioneerServerApp.getApplication().getMainFrame(),"Internet Explorer can not be open!","Error",JOptionPane.ERROR_MESSAGE);
        }catch(NullPointerException ex){
            Log.getInstance().write("ERROR PioneerServerView 2: "+ex);
        }catch(SecurityException ex){
            Log.getInstance().write("ERROR PioneerServerView 3: "+ex);
        }catch(IllegalArgumentException ex){
            Log.getInstance().write("ERROR PioneerServerView 4: "+ex);
        }
    }
    
    @Action
    /**
     * Akcija koja se izvrsava nakon klikana About ...
     */
    public void showAboutBox() {
        //Ako okvir nije kreiran, kreirati ga
        if (aboutBox == null) {
            JFrame mainFrame = PioneerServerApp.getApplication().getMainFrame();
            aboutBox = new PioneerServerAboutBox(mainFrame);
            aboutBox.setLocationRelativeTo(mainFrame);
        }
        PioneerServerApp.getApplication().show(aboutBox);
    }
    
    @Action
    /**
     * Akcija koja se izvrsava nakon pritiska na Connect...
     */
    public void OpenServerPort() {           
        try{
            //Ako nije uspostavljena konekcija
            if(!this.ServerConnection){
                this.jLabel1.setText("Server connection is open ...");
                Log.getInstance().write("Server connection is open ...");
                //Kreira se novi server soket
                serverSock=new ServerSocket(GlobalVariables.socketPort);
                //Postvalja se menuItem na sljedecu komandu
                jMenuItem1.setText("Disconnect");
                //Postavlja se kratica
                KeyStroke DisConnect = KeyStroke.getKeyStroke(KeyEvent.VK_D,InputEvent.SHIFT_MASK);
                jMenuItem1.setAccelerator(DisConnect);
                //Kreira se tajmer osluskivanja porta
                ServerSockTimer = new Timer();
                ServerSockTimer.schedule(new ServerSockTask(), 0, 1000);   
                //postavlaj se flag na true
                ServerConnection=true;
                //Ukida se dugme za setovanje konekcije
                jMenuItem2.setEnabled(false);
            } else {
                //Ako je vec uspostavljena konekcija
                this.jLabel1.setText("Server connection is closed ...");
                ServerSockTimer.cancel();
                serverSock.close();
                this.jMenuItem1.setText("Connect");
                KeyStroke Connect = KeyStroke.getKeyStroke(KeyEvent.VK_C,InputEvent.SHIFT_MASK);
                this.jMenuItem1.setAccelerator(Connect);
                ServerConnection=false;
                jMenuItem2.setEnabled(true);
            }
        } catch(IOException ex){
           Log.getInstance().write("ERROR Log PioneerServerView 5: "+ex);
            JOptionPane.showMessageDialog(PioneerServerApp.getApplication().getMainFrame(),"Local Area Connection Status is No Connectivity!","Error",JOptionPane.ERROR_MESSAGE);
        } catch(NullPointerException ex){
            Log.getInstance().write("ERROR PioneerServerView 6: "+ex);
        } catch(IllegalArgumentException ex){
            Log.getInstance().write("ERROR PioneerServerView 7: "+ex);
        }catch(IllegalStateException ex){
            Log.getInstance().write("ERROR PioneerServerView 8: "+ex);
        }
    }
    
    @Action 
    /**
     * Akcija koja se izvrsava nakon odabira setovanja omjera.
     */
    public void setScalingRatio(){
        //Ako okvir nije formiran formirati ga
        if (setRatio == null) {
            JFrame mainFrame = PioneerServerApp.getApplication().getMainFrame();
            setRatio = new SetRatio(mainFrame);
            setRatio.setLocationRelativeTo(mainFrame);
        }
        PioneerServerApp.getApplication().show(setRatio);
    }
    
    @Action 
    /**
     * Akcija koja s eizvrsava nakon odabira setovanja servera
     */
    public void setServer(){
        //Ako okvir nije kreiran kreirati ga
        if (setServer == null) {
            JFrame mainFrame = PioneerServerApp.getApplication().getMainFrame();
            setServer = new SetServer(mainFrame);
            setServer.setLocationRelativeTo(mainFrame);
        }
        PioneerServerApp.getApplication().show(setServer);
    }
    /**
     * Timer task za osluskivanje socket porta servera.
     */
    class ServerSockTask extends TimerTask {
        public void run() {                
	    try {     
                jLabel1.setText("Waiting for client ...");
                //Ako postoji zahtjev prihvatiti ga
		sock = serverSock.accept();        
		JFrame mainFrame = PioneerServerApp.getApplication().getMainFrame();
                //Formirati nou klinet nit
                ClientThread client = new ClientThread(sock,mainFrame);
		//Pokrenuti nit
                client.start();
                jLabel1.setText("New client ...");
                Log.getInstance().write("New Client ... ");
            } catch(SocketTimeoutException ex){
                Log.getInstance().write("ERROR PioneerServerView 9: "+ex);
            } catch (IOException ex){
		Log.getInstance().write("ERROR PioneerServerView 10: "+ex);
            }catch (NullPointerException ex){
                Log.getInstance().write("ERROR PioneerServerView 11: "+ex);
            }catch(SecurityException ex){
                Log.getInstance().write("ERROR PioneerServerView 12: "+ex);
            }catch(IllegalBlockingModeException ex){
                Log.getInstance().write("ERROR PioneerServerView 13: "+ex);
            }
        }
    }
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        menuBar = new javax.swing.JMenuBar();
        javax.swing.JMenu fileMenu = new javax.swing.JMenu();
        jMenuItem1 = new javax.swing.JMenuItem();
        javax.swing.JMenuItem exitMenuItem = new javax.swing.JMenuItem();
        jMenu1 = new javax.swing.JMenu();
        jMenuItem2 = new javax.swing.JMenuItem();
        jMenuItem3 = new javax.swing.JMenuItem();
        jMenuItem4 = new javax.swing.JMenuItem();
        javax.swing.JMenu helpMenu = new javax.swing.JMenu();
        javax.swing.JMenuItem aboutMenuItem = new javax.swing.JMenuItem();
        statusPanel = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        mainPanel = new DrawingPanel();

        menuBar.setName("menuBar"); // NOI18N

        org.jdesktop.application.ResourceMap resourceMap = org.jdesktop.application.Application.getInstance(pioneerserver.PioneerServerApp.class).getContext().getResourceMap(PioneerServerView.class);
        fileMenu.setText(resourceMap.getString("fileMenu.text")); // NOI18N
        fileMenu.setName("fileMenu"); // NOI18N

        javax.swing.ActionMap actionMap = org.jdesktop.application.Application.getInstance(pioneerserver.PioneerServerApp.class).getContext().getActionMap(PioneerServerView.class, this);
        jMenuItem1.setAction(actionMap.get("OpenServerPort")); // NOI18N
        jMenuItem1.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_C, java.awt.event.InputEvent.SHIFT_MASK));
        jMenuItem1.setText(resourceMap.getString("jMenuItem1.text")); // NOI18N
        jMenuItem1.setName("jMenuItem1"); // NOI18N
        fileMenu.add(jMenuItem1);

        exitMenuItem.setAction(actionMap.get("quit")); // NOI18N
        exitMenuItem.setName("exitMenuItem"); // NOI18N
        fileMenu.add(exitMenuItem);

        menuBar.add(fileMenu);

        jMenu1.setText(resourceMap.getString("jMenu1.text")); // NOI18N
        jMenu1.setName("jMenu1"); // NOI18N

        jMenuItem2.setAction(actionMap.get("setServer")); // NOI18N
        jMenuItem2.setText(resourceMap.getString("jMenuItem2.text")); // NOI18N
        jMenuItem2.setName("jMenuItem2"); // NOI18N
        jMenu1.add(jMenuItem2);

        jMenuItem3.setAction(actionMap.get("setScalingRatio")); // NOI18N
        jMenuItem3.setText(resourceMap.getString("jMenuItem3.text")); // NOI18N
        jMenuItem3.setName("jMenuItem3"); // NOI18N
        jMenu1.add(jMenuItem3);

        jMenuItem4.setAction(actionMap.get("openHttp")); // NOI18N
        jMenuItem4.setText(resourceMap.getString("jMenuItem4.text")); // NOI18N
        jMenuItem4.setName("jMenuItem4"); // NOI18N
        jMenu1.add(jMenuItem4);

        menuBar.add(jMenu1);

        helpMenu.setText(resourceMap.getString("helpMenu.text")); // NOI18N
        helpMenu.setName("helpMenu"); // NOI18N

        aboutMenuItem.setAction(actionMap.get("showAboutBox")); // NOI18N
        aboutMenuItem.setName("aboutMenuItem"); // NOI18N
        helpMenu.add(aboutMenuItem);

        menuBar.add(helpMenu);

        statusPanel.setName("statusPanel"); // NOI18N

        jLabel1.setText(resourceMap.getString("StatusLabel.text")); // NOI18N
        jLabel1.setName("StatusLabel"); // NOI18N

        jLabel2.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        jLabel2.setText(resourceMap.getString("jLabel2.text")); // NOI18N
        jLabel2.setName("jLabel2"); // NOI18N

        org.jdesktop.layout.GroupLayout statusPanelLayout = new org.jdesktop.layout.GroupLayout(statusPanel);
        statusPanel.setLayout(statusPanelLayout);
        statusPanelLayout.setHorizontalGroup(
            statusPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(statusPanelLayout.createSequentialGroup()
                .addContainerGap()
                .add(jLabel1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 242, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(jLabel2, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 59, Short.MAX_VALUE)
                .addContainerGap())
        );
        statusPanelLayout.setVerticalGroup(
            statusPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(statusPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                .add(jLabel1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 22, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .add(jLabel2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 22, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
        );

        jLabel1.getAccessibleContext().setAccessibleName(resourceMap.getString("StatusLabel.AccessibleContext.accessibleName")); // NOI18N

        jScrollPane1.setBorder(null);
        jScrollPane1.setHorizontalScrollBarPolicy(javax.swing.ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
        jScrollPane1.setVerticalScrollBarPolicy(javax.swing.ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
        jScrollPane1.setAutoscrolls(true);
        jScrollPane1.setFocusable(false);
        jScrollPane1.setName("jScrollPane1"); // NOI18N

        mainPanel.setBackground(resourceMap.getColor("mainPanel.background")); // NOI18N
        mainPanel.setName("mainPanel"); // NOI18N
        mainPanel.setPreferredSize(new java.awt.Dimension(10000, 10000));

        org.jdesktop.layout.GroupLayout mainPanelLayout = new org.jdesktop.layout.GroupLayout(mainPanel);
        mainPanel.setLayout(mainPanelLayout);
        mainPanelLayout.setHorizontalGroup(
            mainPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(0, 10000, 10000)
        );
        mainPanelLayout.setVerticalGroup(
            mainPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(0, 10000, 10000)
        );

        jScrollPane1.setViewportView(mainPanel);

        setComponent(jScrollPane1);
        setMenuBar(menuBar);
        setStatusBar(statusPanel);
    }// </editor-fold>//GEN-END:initComponents

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JMenu jMenu1;
    public javax.swing.JMenuItem jMenuItem1;
    private javax.swing.JMenuItem jMenuItem2;
    private javax.swing.JMenuItem jMenuItem3;
    public javax.swing.JMenuItem jMenuItem4;
    private javax.swing.JScrollPane jScrollPane1;
    private static javax.swing.JPanel mainPanel;
    private javax.swing.JMenuBar menuBar;
    private javax.swing.JPanel statusPanel;
    // End of variables declaration//GEN-END:variables

    private JDialog aboutBox;
    private JDialog setRatio;
    private JDialog setServer;
    /**
     * Vraca instancu glavnog okvira
     * @param h stanje horizontalnog skrol bara
     * @param v stanje vertikalnog skrol bara
     * @return glavni okvir
     */
    public javax.swing.JPanel getMainPanel(int h, int v){
        if(h>0&&v>0){
            this.jScrollPane1.getHorizontalScrollBar().setValue(h);
            this.jScrollPane1.getVerticalScrollBar().setValue(v);
        }
        return mainPanel;
        
    }
    /**
     * Vraca instancu label2
     * @return label2
     */
    public javax.swing.JLabel getLabel2(){
        return jLabel2;
    }
    /**
     * Okvir za crtanje putanja
     */
    class DrawingPanel extends JPanel {
        @Override
        protected void paintComponent(Graphics g){
            super.paintComponent(g);
            for(int i=0;i<GlobalVariables.forPaintx.size();i++){
                Vector x=(Vector) GlobalVariables.forPaintx.get(i);
                Vector y=(Vector) GlobalVariables.forPainty.get(i);
                int[] xArray=new int[x.size()];
                int[] yArray=new int[y.size()];
                for(int j=0;j<x.size();j++){
                    xArray[j]=Integer.parseInt(String.valueOf(x.elementAt(j)));
                    yArray[j]=Integer.parseInt(String.valueOf(y.elementAt(j)));
                }
                g.drawPolyline(xArray, yArray, x.size());
            }
        }
    }
}