package ui;

import javax.swing.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;

public class GUI extends JFrame {
//    private JLabel label;
//    private JTextField field;

    /*
     * Create a window.  Use JFrame since this window will include
     * lightweight components.
     */
    public static void main(String[] args) {
        JFrame frame = new JFrame("TabbedPaneDemo");

        WindowListener l = new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        };
        frame.addWindowListener(l);

        frame.add("Center", new TaskTabbedPanel());
        frame.setSize(600, 600);
        frame.show();
    }
}
