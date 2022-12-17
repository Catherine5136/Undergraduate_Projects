package ui;

import javax.swing.*;
import java.awt.*;

// Represents a task tabbed panel

public class TaskTabbedPanel extends JPanel {


    //EFFECTS: construct a task tabbed panel with name and rough layout
    public TaskTabbedPanel() {
        JTabbedPane tabbedPane = new JTabbedPane();

        JPanel taskPanel = new TaskToDoList();

        //JPanel urgentItemPanel = new UrgentItemList();

        tabbedPane.addTab("Task Todo List", null, taskPanel, "Task panel");
        tabbedPane.setSelectedIndex(0);

        Component panel2 = makeTextPanel("Blah blah");

        //Add the tabbed pane to this panel.
        setLayout(new GridLayout(1, 0));
        add(tabbedPane);
    }

    //EFFECTS: make a text panel
    protected static JComponent makeTextPanel(String text) {
        JPanel panel = new JPanel(false);
        JLabel filler = new JLabel(text);
        filler.setHorizontalAlignment(JLabel.CENTER);
        panel.setLayout(new GridLayout(1, 1));
        panel.add(filler);
        return panel;
    }
}
