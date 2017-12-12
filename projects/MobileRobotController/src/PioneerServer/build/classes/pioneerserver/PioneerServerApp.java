/*
 * Server aplikacija
 */

package pioneerserver;

import org.jdesktop.application.Application;
import org.jdesktop.application.SingleFrameApplication;

/**
 * Main klasa plikacije
 */
public class PioneerServerApp extends SingleFrameApplication {
    public static PioneerServerView Instance=null;
    /**
     * Pri startu se kreira i prikazuje glavni okvir aplikacije.
     */
    @Override protected void startup() {
        //Kreira se instanca klase
        Instance=new PioneerServerView(this);
        //Prikazuje se instanca apleta
        show(Instance);
    }

    @Override protected void configureWindow(java.awt.Window root) {
    }

    /**
     * A convenient static getter for the application instance.
     * @return instance PioneerServerApp
     */
    public static PioneerServerApp getApplication() {
        return Application.getInstance(PioneerServerApp.class);
    }

    /**
     * Main method launching the application.
     */
    public static void main(String[] args) {
        launch(PioneerServerApp.class, args);
    }
}
