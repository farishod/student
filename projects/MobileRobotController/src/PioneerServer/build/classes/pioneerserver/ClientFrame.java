/**
 * ClientFrame.java
 * Frame koji omogucava vizuelno sagledavanje statusa robota, te izvrsavanje
 * promjena u radu robota (automatska i rucna kontrola kretanja).
 */
package pioneerserver;

import java.awt.Cursor;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.io.IOException;
import javax.swing.JComponent;
import javax.swing.KeyStroke;
import org.jdesktop.application.Action;
/**
 * 
 * @author Faris Hodzic
 */
public class ClientFrame extends javax.swing.JDialog implements MouseMotionListener, MouseListener {
    /** Maticni okvir*/
    private java.awt.Frame parent;
    /** Nit klienta*/
    private ClientThread myThread;
    /** Stara labela za oznacavanje ciljne pozicije robota*/
    public java.awt.Label OldMlabel;
    /** Nova labela za oznacavaje ciljne pozicije robota*/
    public java.awt.Label NewMlabel;
    /** Slika klienta (button) */
    public java.awt.Button client;
    /** Poruka za zaustavljanje i gasenje robota*/
    public final String sStop="#S\r\n";
    /** Poruka za zaustavljenje robota*/
    public final String sPause="#P\r\n";
    /** Poruka za pokretanje robota i izbjegavanje prepreka*/
    public final String sMove="#M\r\n";
    /** Poruka za pomjeranje unaprijed*/
    public final String sUp="#F\r\n";
    /** Poruka za okret ulijevo*/
    public final String sLeft="#L\r\n";
    /** Poruka za okret udesno*/
    public final String sRight="#R\r\n";
    /** Poruka za kretanje unatrag*/
    public final String sDown="#B\r\n";
    /** String za postavljanje ciljne tacke*/
    public final String sTarget="#C";
    /**
     * Konstruktor za kreiranje novog klient okvira.
     * @param thread maticna nit
     * @param parent maticni okvir
     */
    public ClientFrame(ClientThread thread,java.awt.Frame parent) {
        super(parent);
        this.parent=parent;
        this.myThread=thread;
        initComponents();
        //Upisuje se im robota
        jLabel4.setText(myThread.name);
        //Upisuje se model robota
        jLabel5.setText(myThread.model);
        //Upisuje se ID klienta
        jLabel6.setText(String.valueOf(myThread.ID));
        //kreira se nova lebela za cuvanje ciljen pozicije klienta
        NewMlabel=new java.awt.Label();
        Log.getInstance().write("New Client Frame, ID="+myThread.ID);
        //Onemoguciti tipke za manualnu kontrolu
        FinishPoint7.setEnabled(false);
        FinishPoint6.setEnabled(false);
        FinishPoint5.setEnabled(false);
        FinishPoint4.setEnabled(false);
        FinishPoint3.setEnabled(false);
        //Omoguciti tipku za automatsku kontrolu
        FinishPoint1.setEnabled(true);
    }
    /**
     * Akcija koja se izvrsava prilikom zatvaranje okvira
     */
    @Action
    public void closeClientFrame() {
        setVisible(false);
    }
    /**
     * Akcija koja se izvrsava prilikom klika na dugme postaviti ciljnu tacku
     */
    @Action
    public void SetFinisPoint(){
        enableMousePointer();
        closeClientFrame();
    }
    /**
     * Akcija koja se izvrsava nakon odabira manualne kontrole klienta
     */
    @Action
    public void ManuelControl(){
        //U maticnu nit postaviti nacin kontrole klienta
        myThread.ManuelControl=jCheckBox1.isSelected();
        myThread.AutomaticControl=!myThread.ManuelControl;
        //Ako je odabrana rucna kontrola klienta
        if(myThread.ManuelControl){
            //Omoguciti dugmadi za kontrolu
            FinishPoint7.setEnabled(true);
            FinishPoint6.setEnabled(true);
            FinishPoint5.setEnabled(true);
            FinishPoint4.setEnabled(true);
            FinishPoint3.setEnabled(true);
            //Onemoguciti tipku za automatsku kontrole
            FinishPoint1.setEnabled(false);
            //Omoguciti kontrolu tipkama sa tastature
            FinishPoint7.registerKeyboardAction(
                new ActionListener(){
                @Override
                    public void actionPerformed(ActionEvent e){
                        goUp();
                    }
                }, KeyStroke.getKeyStroke(KeyEvent.VK_UP, 0),JComponent.WHEN_IN_FOCUSED_WINDOW);
            FinishPoint6.registerKeyboardAction(
                new ActionListener(){
                @Override
                    public void actionPerformed(ActionEvent e){
                        goRight();
                    }
                }, KeyStroke.getKeyStroke(KeyEvent.VK_RIGHT, 0),JComponent.WHEN_IN_FOCUSED_WINDOW);
            FinishPoint5.registerKeyboardAction(
                new ActionListener(){
                @Override
                    public void actionPerformed(ActionEvent e){
                        goDown();
                    }
                }, KeyStroke.getKeyStroke(KeyEvent.VK_DOWN, 0),JComponent.WHEN_IN_FOCUSED_WINDOW);
            FinishPoint4.registerKeyboardAction(
                new ActionListener(){
                @Override
                    public void actionPerformed(ActionEvent e){
                        goLeft();
                    }
                }, KeyStroke.getKeyStroke(KeyEvent.VK_LEFT, 0),JComponent.WHEN_IN_FOCUSED_WINDOW);
            FinishPoint3.registerKeyboardAction(
                new ActionListener(){
                @Override
                    public void actionPerformed(ActionEvent e){
                        brake();
                    }
                }, KeyStroke.getKeyStroke(KeyEvent.VK_B, 0),JComponent.WHEN_IN_FOCUSED_WINDOW);
                Log.getInstance().write("Manual Control is set ...");
        //Ako je automatska kontrola klienta
        } else{
            //Onemoguciti tipke za manuelnu kontrolu
            FinishPoint7.setEnabled(false);
            FinishPoint6.setEnabled(false);
            FinishPoint5.setEnabled(false);
            FinishPoint4.setEnabled(false);
            FinishPoint3.setEnabled(false);
            //Omoguciti tipku za automatsku kontrolu
            FinishPoint1.setEnabled(true);
            Log.getInstance().write("Manual Control is unselected ...");
        }
    }
    
    @Action
    /**
     * Akcija koja se izvrsava nakon klika na dugme za okretanje nadesno (L)
     */
    public void goLeft(){
        try{
            myThread.sockOutput.write(sLeft.getBytes());
            myThread.sockOutput.flush();
            Log.getInstance().write("Send Manual Command: "+sLeft);
        }catch(IOException ex){
            Log.getInstance().write("ERROR CientFrame 1: "+ex);
        }catch(NullPointerException ex){
            Log.getInstance().write("ERROR CientFrame 2: "+ex);
        }
    }
    
    @Action
    /**
     * Akcija koja se izvrsava nakon klika na dugme za okretanje nadesno (D)
     */
    public void goRight(){
        try{
            myThread.sockOutput.write(sRight.getBytes());
            myThread.sockOutput.flush();
            Log.getInstance().write("Send Manual Command: "+sRight);
        }catch(IOException ex){
            Log.getInstance().write("ERROR CientFrame 3: "+ex);
        }catch(NullPointerException ex){
            Log.getInstance().write("ERROR CientFrame 4: "+ex);
        }
    }
    /**
     * Akcija koja se izvrsava nakon klika na dugme za kretanje unaprijed (U)
     */
    @Action
    public void goUp(){
        try{
            myThread.sockOutput.write(sUp.getBytes());
            myThread.sockOutput.flush();
            Log.getInstance().write("Send Manual Command: "+sUp);
        }catch(IOException ex){
            Log.getInstance().write("ERROR CientFrame 5: "+ex);
        }catch(NullPointerException ex){
            Log.getInstance().write("ERROR CientFrame 6: "+ex);
        }
    }
    
    @Action
    /**
     * Akcija koja se izvrsava nakon klika na dugme za kretanje unatrag (D)
     */
    public void goDown(){
        try{
            myThread.sockOutput.write(sDown.getBytes());
            myThread.sockOutput.flush();
            Log.getInstance().write("Send Manual Command: "+sDown);
        }catch(IOException ex){
            Log.getInstance().write("ERROR CientFrame 7: "+ex);
        }catch(NullPointerException ex){
            Log.getInstance().write("ERROR CientFrame 8: "+ex);
        }
    }
    
    @Action
    /**
     * Akcija koja se izvrsava nakon klika na dugme za stopiranje (Break)
     */
    public void brake(){
        try{
            myThread.sockOutput.write(sPause.getBytes());
            myThread.sockOutput.flush();
            Log.getInstance().write("Send Manual Command: "+sPause);
        }catch(IOException ex){
            Log.getInstance().write("ERROR CientFrame 9: "+ex);
        }catch(NullPointerException ex){
            Log.getInstance().write("ERROR CientFrame 10: "+ex);
        }
    }
    
    @Action
    /**
     * Akcija koja se izvrsava nakon klika na dugme za pokretanje(zaustavljanje)
     * automatskog kretanja klienta.
     */
    public void StartStop(){
        //Ako je kliknuto na stanje start
        if(this.FinishPoint1.getText().equals("Start")){
            Log.getInstance().write("Automatic moveing is started ...");
            //Sljedeci klik ce biti Stop
            FinishPoint1.setText("Stop");
            try{
                myThread.sockOutput.write(sMove.getBytes());
                myThread.sockOutput.flush();
                Log.getInstance().write("Send Command: "+sMove);
            }catch(IOException ex){
                Log.getInstance().write("ERROR CientFrame 11: "+ex);
            }catch(NullPointerException ex){
                Log.getInstance().write("ERROR CientFrame 12: "+ex);
            }
        //Ako je kliknuto na stanje Stop    
        }else{
            Log.getInstance().write("Automatic moveing is stoped ...");
            //Sljedeci klik ce biti Stop
            FinishPoint1.setText("Start");
            try{
                myThread.sockOutput.write(sPause.getBytes());
                myThread.sockOutput.flush();
                Log.getInstance().write("Send Command: "+sPause);
            }catch(IOException ex){
                Log.getInstance().write("ERROR CientFrame 13: "+ex);
            }catch(NullPointerException ex){
                Log.getInstance().write("ERROR CientFrame 14: "+ex);
            }
        }
    }
    
    @Action
    /**
     * Akcija koja se izvrsava nakon klika na dugme Disconnect
     */
    public void DisconnectClient(){
        try{
            myThread.sockOutput.write(sStop.getBytes());
            myThread.sockOutput.flush();
            Log.getInstance().write("Send Command: "+sStop);
        }catch(IOException ex){
            Log.getInstance().write("ERROR CientFrame 15: "+ex);
        }catch(NullPointerException ex){
            Log.getInstance().write("ERROR CientFrame 16: "+ex);
        }
        NewMlabel.setVisible(false);
        myThread.disconnectClient();
        Log.getInstance().write("Disconnecting client.");
    }
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        javax.swing.JLabel imageLabel = new javax.swing.JLabel();
        FinishPoint = new javax.swing.JButton();
        jFormattedTextField1 = new javax.swing.JFormattedTextField();
        jFormattedTextField2 = new javax.swing.JFormattedTextField();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        jSeparator1 = new javax.swing.JSeparator();
        jLabel7 = new javax.swing.JLabel();
        jLabel8 = new javax.swing.JLabel();
        jLabel9 = new javax.swing.JLabel();
        jLabel10 = new javax.swing.JLabel();
        jLabel11 = new javax.swing.JLabel();
        jSeparator2 = new javax.swing.JSeparator();
        jTextField1 = new javax.swing.JTextField();
        jTextField2 = new javax.swing.JTextField();
        jTextField3 = new javax.swing.JTextField();
        jTextField4 = new javax.swing.JTextField();
        jTextField5 = new javax.swing.JTextField();
        FinishPoint1 = new javax.swing.JButton();
        FinishPoint2 = new javax.swing.JButton();
        FinishPoint4 = new javax.swing.JButton();
        FinishPoint5 = new javax.swing.JButton();
        FinishPoint6 = new javax.swing.JButton();
        FinishPoint7 = new javax.swing.JButton();
        jSeparator3 = new javax.swing.JSeparator();
        jCheckBox1 = new javax.swing.JCheckBox();
        FinishPoint3 = new javax.swing.JButton();
        jLabel12 = new javax.swing.JLabel();
        jSeparator4 = new javax.swing.JSeparator();
        jTextField6 = new javax.swing.JTextField();
        jLabel13 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        setName("Form"); // NOI18N
        setResizable(false);

        org.jdesktop.application.ResourceMap resourceMap = org.jdesktop.application.Application.getInstance(pioneerserver.PioneerServerApp.class).getContext().getResourceMap(ClientFrame.class);
        imageLabel.setIcon(resourceMap.getIcon("imageLabel.icon")); // NOI18N
        imageLabel.setVerticalAlignment(javax.swing.SwingConstants.TOP);
        imageLabel.setAutoscrolls(true);
        imageLabel.setName("imageLabel"); // NOI18N

        javax.swing.ActionMap actionMap = org.jdesktop.application.Application.getInstance(pioneerserver.PioneerServerApp.class).getContext().getActionMap(ClientFrame.class, this);
        FinishPoint.setAction(actionMap.get("SetFinisPoint")); // NOI18N
        FinishPoint.setText(resourceMap.getString("FinishPoint.text")); // NOI18N
        FinishPoint.setName("FinishPoint"); // NOI18N
        FinishPoint.setPreferredSize(new java.awt.Dimension(57, 23));

        jFormattedTextField1.setBorder(null);
        jFormattedTextField1.setEditable(false);
        jFormattedTextField1.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        jFormattedTextField1.setText(resourceMap.getString("jFormattedTextField1.text")); // NOI18N
        jFormattedTextField1.setName("jFormattedTextField1"); // NOI18N
        jFormattedTextField1.setSelectionColor(null);

        jFormattedTextField2.setBorder(null);
        jFormattedTextField2.setEditable(false);
        jFormattedTextField2.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        jFormattedTextField2.setText(resourceMap.getString("jFormattedTextField2.text")); // NOI18N
        jFormattedTextField2.setFont(resourceMap.getFont("jFormattedTextField2.font")); // NOI18N
        jFormattedTextField2.setName("jFormattedTextField2"); // NOI18N
        jFormattedTextField2.setSelectionColor(null);

        jLabel1.setText(resourceMap.getString("jLabel1.text")); // NOI18N
        jLabel1.setName("jLabel1"); // NOI18N

        jLabel2.setText(resourceMap.getString("jLabel2.text")); // NOI18N
        jLabel2.setName("jLabel2"); // NOI18N

        jLabel3.setText(resourceMap.getString("jLabel3.text")); // NOI18N
        jLabel3.setName("jLabel3"); // NOI18N

        jLabel4.setText(resourceMap.getString("jLabel4.text")); // NOI18N
        jLabel4.setName("jLabel4"); // NOI18N

        jLabel5.setText(resourceMap.getString("jLabel5.text")); // NOI18N
        jLabel5.setName("jLabel5"); // NOI18N

        jLabel6.setText(resourceMap.getString("jLabel6.text")); // NOI18N
        jLabel6.setName("jLabel6"); // NOI18N

        jSeparator1.setName("jSeparator1"); // NOI18N

        jLabel7.setText(resourceMap.getString("jLabel7.text")); // NOI18N
        jLabel7.setName("jLabel7"); // NOI18N

        jLabel8.setText(resourceMap.getString("jLabel8.text")); // NOI18N
        jLabel8.setName("jLabel8"); // NOI18N

        jLabel9.setText(resourceMap.getString("jLabel9.text")); // NOI18N
        jLabel9.setName("jLabel9"); // NOI18N

        jLabel10.setText(resourceMap.getString("jLabel10.text")); // NOI18N
        jLabel10.setName("jLabel10"); // NOI18N

        jLabel11.setText(resourceMap.getString("jLabel11.text")); // NOI18N
        jLabel11.setName("jLabel11"); // NOI18N

        jSeparator2.setName("jSeparator2"); // NOI18N

        jTextField1.setEditable(false);
        jTextField1.setText(resourceMap.getString("jTextField1.text")); // NOI18N
        jTextField1.setName("jTextField1"); // NOI18N

        jTextField2.setEditable(false);
        jTextField2.setText(resourceMap.getString("jTextField2.text")); // NOI18N
        jTextField2.setName("jTextField2"); // NOI18N

        jTextField3.setEditable(false);
        jTextField3.setText(resourceMap.getString("jTextField3.text")); // NOI18N
        jTextField3.setName("jTextField3"); // NOI18N

        jTextField4.setEditable(false);
        jTextField4.setText(resourceMap.getString("jTextField4.text")); // NOI18N
        jTextField4.setName("jTextField4"); // NOI18N

        jTextField5.setEditable(false);
        jTextField5.setText(resourceMap.getString("jTextField5.text")); // NOI18N
        jTextField5.setName("jTextField5"); // NOI18N

        FinishPoint1.setAction(actionMap.get("StartStop")); // NOI18N
        FinishPoint1.setLabel(resourceMap.getString("FinishPoint1.label")); // NOI18N
        FinishPoint1.setName("FinishPoint1"); // NOI18N

        FinishPoint2.setAction(actionMap.get("DisconnectClient")); // NOI18N
        FinishPoint2.setText(resourceMap.getString("FinishPoint2.text")); // NOI18N
        FinishPoint2.setName("FinishPoint2"); // NOI18N
        FinishPoint2.setPreferredSize(new java.awt.Dimension(57, 23));

        FinishPoint4.setAction(actionMap.get("goLeft")); // NOI18N
        FinishPoint4.setFont(resourceMap.getFont("FinishPoint4.font")); // NOI18N
        FinishPoint4.setIcon(resourceMap.getIcon("FinishPoint3.icon")); // NOI18N
        FinishPoint4.setText(resourceMap.getString("FinishPoint4.text")); // NOI18N
        FinishPoint4.setMaximumSize(new java.awt.Dimension(30, 30));
        FinishPoint4.setMinimumSize(new java.awt.Dimension(30, 30));
        FinishPoint4.setName("FinishPoint4"); // NOI18N
        FinishPoint4.setPreferredSize(new java.awt.Dimension(30, 30));

        FinishPoint5.setAction(actionMap.get("goDown")); // NOI18N
        FinishPoint5.setFont(resourceMap.getFont("FinishPoint5.font")); // NOI18N
        FinishPoint5.setIcon(resourceMap.getIcon("FinishPoint3.icon")); // NOI18N
        FinishPoint5.setText(resourceMap.getString("FinishPoint5.text")); // NOI18N
        FinishPoint5.setMaximumSize(new java.awt.Dimension(30, 30));
        FinishPoint5.setMinimumSize(new java.awt.Dimension(30, 30));
        FinishPoint5.setName("FinishPoint5"); // NOI18N
        FinishPoint5.setPreferredSize(new java.awt.Dimension(30, 30));

        FinishPoint6.setAction(actionMap.get("goRight")); // NOI18N
        FinishPoint6.setFont(resourceMap.getFont("FinishPoint6.font")); // NOI18N
        FinishPoint6.setIcon(resourceMap.getIcon("FinishPoint3.icon")); // NOI18N
        FinishPoint6.setText(resourceMap.getString("FinishPoint6.text")); // NOI18N
        FinishPoint6.setMaximumSize(new java.awt.Dimension(30, 30));
        FinishPoint6.setMinimumSize(new java.awt.Dimension(30, 30));
        FinishPoint6.setName("FinishPoint6"); // NOI18N
        FinishPoint6.setPreferredSize(new java.awt.Dimension(30, 30));

        FinishPoint7.setAction(actionMap.get("goUp")); // NOI18N
        FinishPoint7.getInputMap().put(KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_UP, java.awt.event.InputEvent.ALT_MASK),actionMap.get("goUp"));
        FinishPoint7.setFont(resourceMap.getFont("FinishPoint7.font")); // NOI18N
        FinishPoint7.setIcon(resourceMap.getIcon("FinishPoint3.icon")); // NOI18N
        FinishPoint7.setText(resourceMap.getString("FinishPoint7.text")); // NOI18N
        FinishPoint7.setMaximumSize(new java.awt.Dimension(30, 30));
        FinishPoint7.setMinimumSize(new java.awt.Dimension(30, 30));
        FinishPoint7.setName("FinishPoint7"); // NOI18N
        FinishPoint7.setPreferredSize(new java.awt.Dimension(30, 30));

        jSeparator3.setOrientation(javax.swing.SwingConstants.VERTICAL);
        jSeparator3.setName("jSeparator3"); // NOI18N

        jCheckBox1.setAction(actionMap.get("ManuelControl")); // NOI18N
        jCheckBox1.setText(resourceMap.getString("jCheckBox1.text")); // NOI18N
        jCheckBox1.setName("jCheckBox1"); // NOI18N

        FinishPoint3.setAction(actionMap.get("brake")); // NOI18N
        FinishPoint3.setText(resourceMap.getString("FinishPoint3.text")); // NOI18N
        FinishPoint3.setName("FinishPoint3"); // NOI18N

        jLabel12.setText(resourceMap.getString("jLabel12.text")); // NOI18N
        jLabel12.setName("jLabel12"); // NOI18N

        jSeparator4.setName("jSeparator4"); // NOI18N

        jTextField6.setEditable(false);
        jTextField6.setName("jTextField6"); // NOI18N

        jLabel13.setText(resourceMap.getString("jLabel13.text")); // NOI18N
        jLabel13.setName("jLabel13"); // NOI18N

        org.jdesktop.layout.GroupLayout layout = new org.jdesktop.layout.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .addContainerGap()
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(jLabel7)
                    .add(jLabel8)
                    .add(jLabel9)
                    .add(jLabel13)
                    .add(jLabel10)
                    .add(jLabel11))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING, false)
                    .add(jTextField1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 195, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jTextField2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 195, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jTextField3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 195, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jTextField6, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 195, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jTextField4, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 195, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jTextField5, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 195, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .add(10, 10, 10))
            .add(layout.createSequentialGroup()
                .add(10, 10, 10)
                .add(imageLabel, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 73, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(layout.createSequentialGroup()
                        .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jLabel1)
                            .add(jLabel2)
                            .add(jLabel3))
                        .add(5, 5, 5)
                        .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jLabel6)
                            .add(jLabel5)
                            .add(jLabel4)
                            .add(jFormattedTextField2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                    .add(jFormattedTextField1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 191, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(12, Short.MAX_VALUE))
            .add(layout.createSequentialGroup()
                .add(10, 10, 10)
                .add(jSeparator1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 266, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(16, Short.MAX_VALUE))
            .add(org.jdesktop.layout.GroupLayout.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING)
                    .add(org.jdesktop.layout.GroupLayout.LEADING, jSeparator2, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 272, Short.MAX_VALUE)
                    .add(layout.createSequentialGroup()
                        .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING, false)
                                .add(FinishPoint3, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 138, Short.MAX_VALUE)
                                .add(layout.createSequentialGroup()
                                    .add(FinishPoint4, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 42, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                    .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                    .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING, false)
                                        .add(FinishPoint7, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 42, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                        .add(layout.createSequentialGroup()
                                            .add(FinishPoint5, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 42, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                            .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                            .add(FinishPoint6, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 42, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))))
                            .add(layout.createSequentialGroup()
                                .add(20, 20, 20)
                                .add(jCheckBox1)))
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jSeparator3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                        .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jLabel12)
                            .add(FinishPoint2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 110, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(FinishPoint, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 110, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(FinishPoint1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 110, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(org.jdesktop.layout.GroupLayout.TRAILING, jSeparator4, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 115, Short.MAX_VALUE))))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .addContainerGap()
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING, false)
                    .add(layout.createSequentialGroup()
                        .add(jFormattedTextField1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 16, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jFormattedTextField2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 14, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(org.jdesktop.layout.GroupLayout.TRAILING, jLabel4, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 14, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(org.jdesktop.layout.GroupLayout.TRAILING, jLabel1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 14, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(org.jdesktop.layout.GroupLayout.TRAILING, jLabel5, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 14, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(org.jdesktop.layout.GroupLayout.TRAILING, jLabel2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 14, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                            .add(jLabel3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 14, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jLabel6, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 14, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                    .add(imageLabel, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 92, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .add(8, 8, 8)
                .add(jSeparator1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .add(9, 9, 9)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.CENTER, false)
                    .add(jLabel7, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 14, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jTextField1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.CENTER)
                    .add(jTextField2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel8, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 14, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.CENTER)
                    .add(jTextField3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel9, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 14, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.CENTER)
                    .add(jTextField6, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel13))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.CENTER)
                    .add(jTextField4, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel10, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 14, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.CENTER)
                    .add(jTextField5, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel11))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(jSeparator2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 6, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(layout.createSequentialGroup()
                        .add(jCheckBox1)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(layout.createSequentialGroup()
                                .add(FinishPoint7, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 30, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE, false)
                                    .add(FinishPoint5, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                    .add(FinishPoint6, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                    .add(FinishPoint4, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(FinishPoint3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 24, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                            .add(layout.createSequentialGroup()
                                .add(37, 37, 37)
                                .add(jSeparator4, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(FinishPoint, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 25, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(FinishPoint2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 25, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))))
                    .add(layout.createSequentialGroup()
                        .add(4, 4, 4)
                        .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jSeparator3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 124, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(layout.createSequentialGroup()
                                .add(jLabel12)
                                .add(11, 11, 11)
                                .add(FinishPoint1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 25, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))))
                .addContainerGap(org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jLabel13.getAccessibleContext().setAccessibleName(resourceMap.getString("jLabel13.AccessibleContext.accessibleName")); // NOI18N

        pack();
    }// </editor-fold>//GEN-END:initComponents

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton FinishPoint;
    private javax.swing.JButton FinishPoint1;
    private javax.swing.JButton FinishPoint2;
    private javax.swing.JButton FinishPoint3;
    private javax.swing.JButton FinishPoint4;
    private javax.swing.JButton FinishPoint5;
    private javax.swing.JButton FinishPoint6;
    private javax.swing.JButton FinishPoint7;
    private javax.swing.JCheckBox jCheckBox1;
    private javax.swing.JFormattedTextField jFormattedTextField1;
    private javax.swing.JFormattedTextField jFormattedTextField2;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JSeparator jSeparator2;
    private javax.swing.JSeparator jSeparator3;
    private javax.swing.JSeparator jSeparator4;
    private javax.swing.JTextField jTextField1;
    private javax.swing.JTextField jTextField2;
    private javax.swing.JTextField jTextField3;
    private javax.swing.JTextField jTextField4;
    private javax.swing.JTextField jTextField5;
    private javax.swing.JTextField jTextField6;
    // End of variables declaration//GEN-END:variables
    
    /**
     * Osvjezavanje stanja klienta
     * @param a Datum i Vrijeme
     * @param b Latituda
     * @param c Longituda
     * @param d Kurs
     * @param e Brzina
     */
    public void refreshPositions(String a, String b, String c, String d, String e, String f){
        this.jTextField1.setText(a);
        this.jTextField2.setText(b);
        this.jTextField3.setText(c);
        this.jTextField4.setText(e);
        this.jTextField5.setText(f);
        this.jTextField6.setText(d);
    }
    /**
     * Omogucavanje oznacavanja ciljne tacke pointerom misa
     */
    public void enableMousePointer(){
        //Staro stanje ciljne zamjeniti s novim
        OldMlabel=NewMlabel;
        //Prikriti staru labelu
        OldMlabel.setVisible(false);
        //Kreira se nova lebla
        NewMlabel=new java.awt.Label();
        //Upisati prazan string
        NewMlabel.setText("");
        //Format teksta
        NewMlabel.setFont(new java.awt.Font("Verdana",java.awt.Font.BOLD,8));
        //Nulta lokacija
        NewMlabel.setLocation(0,0);
        //Postaviti velicinu labele
        NewMlabel.setSize(100, 15);
        //Na glavni okvir ispisati labelu
        PioneerServerApp.Instance.getMainPanel(myThread.xposition,myThread.yposition).add(NewMlabel); 
        //postaviti labelu da je vidljiva
        NewMlabel.setVisible(true);
        //Promjena kursora misa
        Cursor hourglassCursor = new Cursor(Cursor.CROSSHAIR_CURSOR);
        //Postaviti kursor na glavni okvir
        PioneerServerApp.Instance.getMainPanel(myThread.xposition,myThread.yposition).setCursor(hourglassCursor);
        //Na glavni okvir dodati osluskivanje kursora misa
        PioneerServerApp.Instance.getMainPanel(myThread.xposition,myThread.yposition).addMouseListener(this);
        PioneerServerApp.Instance.getMainPanel(myThread.xposition,myThread.yposition).addMouseMotionListener(this);
    }
    /**
     * Funkcija koja se izvrsava pri vuci pointera
     * @param e
     */
    @Override
    public void mouseDragged(MouseEvent e) {
        System.out.println("Not supported yet.");
    }
    /**
     * Funkcija koja se obavlja pri pomjeranju kursora misa
     * @param e
     */
    @Override
    public void mouseMoved(MouseEvent e) {
        //U globalne varijable upisati poziciju misa
        GlobalVariables.XmousePointer=e.getX()*GlobalVariables.referentLongitude/GlobalVariables.XREFERENT;
        GlobalVariables.YmousePointer=e.getY()*GlobalVariables.referentLatitude/GlobalVariables.YREFERENT;
        //Lokaciju labele pomjeriti iznad kursora misa za 10 pix
        NewMlabel.setLocation(10+e.getX(), 10+e.getY());
        //U labelu ispisati vrijednost latitude i longitude odgovarajuce tacke
        NewMlabel.setText(String.valueOf("ID"+myThread.ID+": "+GlobalVariables.XmousePointer)+"; "+GlobalVariables.YmousePointer);
    }
    /**
     * Funkcija koja se izvrsava nakon klika misem
     * @param e
     */
    @Override
    public void mouseClicked(MouseEvent e) {
        //Uklanja se osluskivanje misem
        PioneerServerApp.Instance.getMainPanel(myThread.xposition,myThread.yposition).removeMouseMotionListener(this);
        PioneerServerApp.Instance.getMainPanel(myThread.xposition,myThread.yposition).removeMouseListener(this);
        //Promjeniti izgled kursora
        Cursor hourglassCursor = new Cursor(Cursor.DEFAULT_CURSOR);
        PioneerServerApp.Instance.getMainPanel(myThread.xposition,myThread.yposition).setCursor(hourglassCursor);
        //Klientu zadati ciljnu tacku
        myThread.finisLatitude=GlobalVariables.YmousePointer;
        myThread.finishLongitude=GlobalVariables.XmousePointer;
        //Prikazati klientov okvir
        this.setVisible(true);
        byte[]tempLatitude=toBytA(myThread.finisLatitude);//4 bajta
        byte[]tempLongitude=toBytA(myThread.finishLongitude);//4 bajta
        byte[] tempPrefiks=sTarget.getBytes();//2 bajta
        byte[] tempSufiks=String.valueOf("\r\n").getBytes();// 2 bajta
        byte[] temp=new byte[12];
        temp[0]=tempPrefiks[0];
        temp[1]=tempPrefiks[1];
        temp[2]=tempLatitude[0];
        temp[3]=tempLatitude[1];
        temp[4]=tempLatitude[2];
        temp[5]=tempLatitude[3];
        temp[6]=tempLongitude[0];
        temp[7]=tempLongitude[1];
        temp[8]=tempLongitude[2];
        temp[9]=tempLongitude[3];
        temp[10]=tempSufiks[0];
        temp[11]=tempSufiks[1];
        try{
            Log.getInstance().write("Send to Client: "+myThread.ID);
            for(int i=0;i<temp.length;i++)
                Log.getInstance().write(Byte.toString(temp[i]));
            myThread.sockOutput.write(temp);
            myThread.sockOutput.flush();
        }catch(IOException ex){
            Log.getInstance().write("ERROR ClientFrame 17: "+ex);
        }
    }

    @Override
    public void mousePressed(MouseEvent e) {
        
    }

    @Override
    public void mouseReleased(MouseEvent e) {
        
    }

    @Override
    public void mouseEntered(MouseEvent e) {
        
    }

    @Override
    public void mouseExited(MouseEvent e) {

    }
        /**
     * Konvertovanje int vrijednosti u polje bajta, najvisi bajt je prvi
     * @param data integer vrijednost
     * @return 4 bajta
     * @throws java.lang.NumberFormatException
     */
    public static synchronized byte[] toBytA(int data) throws NumberFormatException {
        return new byte[]  {(byte)((data>>24)&0xff),
                            (byte)((data>>16)&0xff),
                            (byte)((data>>8)&0xff),
                            (byte)((data)&0xff)};
    }
    /**
     * Konvertovanje float vrijednosti u polje bajta
     * @param data float vrijednost
     * @return 4 bajta
     * @throws java.lang.NumberFormatException
     */
    public static synchronized byte[] toBytA(float data) throws NumberFormatException {
        return toBytA(Float.floatToIntBits(data));
    }
}