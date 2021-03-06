/**
 * Kratke informacije o aplikaciji
 */
package pioneerserver;

import org.jdesktop.application.Action;

public class PioneerServerAboutBox extends javax.swing.JDialog {
    
    /**
     * Konstruktor okvira
     * @param parent maticni okvir
     */
    public PioneerServerAboutBox(java.awt.Frame parent) {
        super(parent);
        initComponents();
        //getRootPane().setDefaultButton(closeButton);
    }
    
    /**
     * Akcija koja se izvrsava klikom na dugme Close
     */
    @Action public void closeAboutBox() {
        setVisible(false);
    }
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        javax.swing.JLabel imageLabel = new javax.swing.JLabel();
        javax.swing.JLabel appTitleLabel = new javax.swing.JLabel();
        javax.swing.JLabel imageLabel6 = new javax.swing.JLabel();
        javax.swing.JLabel appDescLabel = new javax.swing.JLabel();
        javax.swing.JLabel versionLabel = new javax.swing.JLabel();
        javax.swing.JLabel homepageLabel = new javax.swing.JLabel();
        javax.swing.JLabel vendorLabel = new javax.swing.JLabel();
        javax.swing.JLabel appHomepageLabel = new javax.swing.JLabel();
        javax.swing.JLabel appVendorLabel = new javax.swing.JLabel();
        javax.swing.JLabel appVersionLabel = new javax.swing.JLabel();
        javax.swing.JLabel imageLabel9 = new javax.swing.JLabel();
        javax.swing.JLabel imageLabel10 = new javax.swing.JLabel();
        javax.swing.JLabel imageLabel11 = new javax.swing.JLabel();
        jSeparator1 = new javax.swing.JSeparator();
        jSeparator2 = new javax.swing.JSeparator();
        javax.swing.JLabel imageLabel8 = new javax.swing.JLabel();
        javax.swing.JLabel imageLabel12 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        org.jdesktop.application.ResourceMap resourceMap = org.jdesktop.application.Application.getInstance(pioneerserver.PioneerServerApp.class).getContext().getResourceMap(PioneerServerAboutBox.class);
        setTitle(resourceMap.getString("title")); // NOI18N
        setAlwaysOnTop(true);
        setBackground(java.awt.Color.white);
        setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        setFocusCycleRoot(false);
        setModal(true);
        setName("aboutBox"); // NOI18N
        setResizable(false);

        jPanel1.setBackground(new java.awt.Color(255, 255, 255));
        jPanel1.setName("jPanel1"); // NOI18N
        jPanel1.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        imageLabel.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pioneerserver/resources/pioneer_dx.jpg"))); // NOI18N
        imageLabel.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED));
        imageLabel.setName("imageLabel"); // NOI18N
        jPanel1.add(imageLabel, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 40, -1, -1));

        appTitleLabel.setFont(appTitleLabel.getFont().deriveFont(appTitleLabel.getFont().getStyle() | java.awt.Font.BOLD, appTitleLabel.getFont().getSize()+4));
        appTitleLabel.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pioneerserver/resources/Logo Template - Logo_33.gif.gif"))); // NOI18N
        appTitleLabel.setText(resourceMap.getString("Application.title")); // NOI18N
        appTitleLabel.setName("appTitleLabel"); // NOI18N
        jPanel1.add(appTitleLabel, new org.netbeans.lib.awtextra.AbsoluteConstraints(190, 10, 300, 150));

        imageLabel6.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pioneerserver/resources/java_logo2.jpg"))); // NOI18N
        imageLabel6.setName("imageLabel6"); // NOI18N
        jPanel1.add(imageLabel6, new org.netbeans.lib.awtextra.AbsoluteConstraints(410, 320, 80, 50));

        java.util.ResourceBundle bundle = java.util.ResourceBundle.getBundle("pioneerserver/Bundle"); // NOI18N
        appDescLabel.setText(bundle.getString("PioneerServerAboutBox.appDescLabel.text")); // NOI18N
        appDescLabel.setName("appDescLabel"); // NOI18N
        jPanel1.add(appDescLabel, new org.netbeans.lib.awtextra.AbsoluteConstraints(220, 160, -1, -1));

        versionLabel.setFont(versionLabel.getFont().deriveFont(versionLabel.getFont().getStyle() | java.awt.Font.BOLD));
        versionLabel.setText(bundle.getString("PioneerServerAboutBox.versionLabel.text")); // NOI18N
        versionLabel.setName("versionLabel"); // NOI18N
        jPanel1.add(versionLabel, new org.netbeans.lib.awtextra.AbsoluteConstraints(170, 190, 80, -1));

        homepageLabel.setFont(homepageLabel.getFont().deriveFont(homepageLabel.getFont().getStyle() | java.awt.Font.BOLD));
        homepageLabel.setText(bundle.getString("PioneerServerAboutBox.homepageLabel.text")); // NOI18N
        homepageLabel.setName("homepageLabel"); // NOI18N
        jPanel1.add(homepageLabel, new org.netbeans.lib.awtextra.AbsoluteConstraints(170, 230, 80, -1));

        vendorLabel.setFont(vendorLabel.getFont().deriveFont(vendorLabel.getFont().getStyle() | java.awt.Font.BOLD));
        vendorLabel.setText(bundle.getString("PioneerServerAboutBox.vendorLabel.text")); // NOI18N
        vendorLabel.setName("vendorLabel"); // NOI18N
        jPanel1.add(vendorLabel, new org.netbeans.lib.awtextra.AbsoluteConstraints(170, 210, 70, -1));

        appHomepageLabel.setText(resourceMap.getString("Application.homepage")); // NOI18N
        appHomepageLabel.setName("appHomepageLabel"); // NOI18N
        jPanel1.add(appHomepageLabel, new org.netbeans.lib.awtextra.AbsoluteConstraints(270, 230, -1, -1));

        appVendorLabel.setText(resourceMap.getString("Application.vendor")); // NOI18N
        appVendorLabel.setName("appVendorLabel"); // NOI18N
        jPanel1.add(appVendorLabel, new org.netbeans.lib.awtextra.AbsoluteConstraints(270, 210, -1, -1));

        appVersionLabel.setText(resourceMap.getString("Application.version")); // NOI18N
        appVersionLabel.setName("appVersionLabel"); // NOI18N
        jPanel1.add(appVersionLabel, new org.netbeans.lib.awtextra.AbsoluteConstraints(270, 190, -1, -1));

        imageLabel9.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pioneerserver/resources/Cinterion_logo.png"))); // NOI18N
        imageLabel9.setName("imageLabel9"); // NOI18N
        jPanel1.add(imageLabel9, new org.netbeans.lib.awtextra.AbsoluteConstraints(400, 270, -1, 50));

        imageLabel10.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pioneerserver/resources/nb-logo-frontpage.png"))); // NOI18N
        imageLabel10.setName("imageLabel10"); // NOI18N
        jPanel1.add(imageLabel10, new org.netbeans.lib.awtextra.AbsoluteConstraints(30, 330, -1, -1));

        imageLabel11.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pioneerserver/resources/matlablogo.gif"))); // NOI18N
        imageLabel11.setName("imageLabel11"); // NOI18N
        jPanel1.add(imageLabel11, new org.netbeans.lib.awtextra.AbsoluteConstraints(270, 330, -1, -1));

        jSeparator1.setName("jSeparator1"); // NOI18N
        jPanel1.add(jSeparator1, new org.netbeans.lib.awtextra.AbsoluteConstraints(160, 180, 380, 10));

        jSeparator2.setName("jSeparator2"); // NOI18N
        jPanel1.add(jSeparator2, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 260, 530, -1));

        imageLabel8.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        imageLabel8.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pioneerserver/resources/etflogo.png"))); // NOI18N
        imageLabel8.setDoubleBuffered(true);
        imageLabel8.setName("imageLabel8"); // NOI18N
        jPanel1.add(imageLabel8, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 270, 260, -1));

        imageLabel12.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pioneerserver/resources/mrlogo.gif"))); // NOI18N
        imageLabel12.setName("imageLabel12"); // NOI18N
        jPanel1.add(imageLabel12, new org.netbeans.lib.awtextra.AbsoluteConstraints(270, 260, -1, -1));

        org.jdesktop.layout.GroupLayout layout = new org.jdesktop.layout.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 557, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 382, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JPanel jPanel1;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JSeparator jSeparator2;
    // End of variables declaration//GEN-END:variables
   
}