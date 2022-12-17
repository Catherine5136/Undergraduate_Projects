package ui;

import model.Task;
import model.ToDoList;
import persistence.Reader;
import persistence.Writer;

import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

// Represents a to-do list having a list of tasks and functions
public class TaskToDoList extends JPanel implements ActionListener {
    private static final String TASKS_FILE = "./data/tasks.txt";

    private JList list;
    private DefaultListModel listModel;
    private JTextField field;

//EFFECTS: construct a TaskToDoList with 3 Panel
    public TaskToDoList() {
        super(new BorderLayout());
        listModel = new DefaultListModel();
        //Create the list and put it in a scroll pane.
        list = new JList(listModel);
        list.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        list.setSelectedIndex(0);
        list.setVisibleRowCount(5);
        JScrollPane listScrollPanel = new JScrollPane(list);
        JPanel addRegularItemPanel = new JPanel();
        JPanel removeRegularItemPanel = new JPanel();

        addButton(addRegularItemPanel);
        removeButton(removeRegularItemPanel);

        add(listScrollPanel, BorderLayout.CENTER);
        add(addRegularItemPanel, BorderLayout.NORTH);
        add(removeRegularItemPanel, BorderLayout.SOUTH);
    }

    // EFFECTS: add addItemButton, load button to the top panel
    public void addButton(JPanel a) {
        JLabel label = new JLabel("Task Name");
        field = new JTextField(10); // accepts upto 10 characters

        JButton addItemButton = new JButton("Add New Task");
        addItemButton.setActionCommand("myButton1");
        addItemButton.addActionListener(this); //sets "this" class as an action listener for button.
        //that means that when the button is clicked,
        //this.actionPerformed(ActionEvent e) will be called.
        setVisible(true);
        JButton loadButton = new JButton("Load from file");
        loadButton.setActionCommand("myButton3");
        loadButton.addActionListener(this);

        a.add(label); // Components Added using Flow Layout
        a.add(field);
        a.add(addItemButton);
        a.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
        a.add(loadButton);
        a.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
    }

    // EFFECTS: add remove, newList, and save button to the bottom panel
    public void removeButton(JPanel b) {
        JButton removeItemButton = new JButton("Remove Selected Task");
        removeItemButton.setActionCommand("myButton2");
        removeItemButton.addActionListener(this);
        JButton newList = new JButton("Create a new List");
        newList.setActionCommand("myButton4");
        newList.addActionListener(this);
        JButton completeTask = new JButton("Complete Task");
        completeTask.setActionCommand("myButton6");
        completeTask.addActionListener(this);
        JButton saveButton = new JButton("Save");
        saveButton.setActionCommand("myButton5");
        saveButton.addActionListener(this);
        b.add(removeItemButton);
        b.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
        b.add(newList);
        b.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
        b.add(completeTask);
        b.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
        b.add(saveButton);
        b.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
    }


    // EFFECTS: remove the task which you select
    public void removeSelectedTask() {
        int index = list.getSelectedIndex();
        if (index >= 0) {   //Remove only if a particular item is selected
            listModel.removeElementAt(index);
        }
    }

    // EFFECTS: load the tasks in tasks.txt file to the list panel
    private void loadTasks() {
        try {
            listModel.removeAllElements();
            ArrayList<Task> tasks = Reader.readTasks(new File(TASKS_FILE));
            for (Task t : tasks) {
                listModel.addElement(t.getTaskName());
            }
        } catch (IOException e) {
            listModel = new DefaultListModel();
        }
    }

    // EFFECTS: save the tasks on list panel to task.txt file in data
    public void saveToFile() {
        try {
            Writer writer = new Writer(new File(TASKS_FILE));
            ToDoList toDoList = new ToDoList();
            for (int i = 0; i < listModel.size(); i++) {
                String s = listModel.get(i).toString();
                toDoList.addTask(s);
            }
            writer.write(toDoList);
            writer.close();
            System.out.println("Accounts saved to file " + TASKS_FILE);
        } catch (FileNotFoundException e) {
            System.out.println("Unable to save accounts to " + TASKS_FILE);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            // this is due to a programming error
        }
    }

    //EFFECTS: Mark a task as completed
    public void completeTask() {
        int index = list.getSelectedIndex();
        if (index >= 0) {   // only if a particular item is selected
            String s = listModel.get(index).toString();
            listModel.removeElementAt(index);
            listModel.add(index,s + " (completed)");
        }
    }

    //EFFECTS: assign different orders when according button is clicked
    // add, delete task, load from file, create new list and save the tasks
    // when buttons 1-5 are clicked
    public void actionPerformed(ActionEvent e) {
        if (e.getActionCommand().equals("myButton1")) {
            listModel.addElement(field.getText());
            playSound("./data/button-3 (4).wav");
        } else if (e.getActionCommand().equals("myButton2")) {
            removeSelectedTask();
            playSound("./data/button-1.wav");
        } else if (e.getActionCommand().equals("myButton3")) {
            loadTasks();
            playSound("./data/button-3 (4).wav");
        } else if (e.getActionCommand().equals("myButton4")) {
            listModel.removeAllElements();
            playSound("./data/button-1.wav");
        } else if (e.getActionCommand().equals("myButton5")) {
            saveToFile();
            playSound("./data/button-3 (4).wav");
        } else if (e.getActionCommand().equals("myButton6")) {
            completeTask();
            playSound("./data/button-3 (4).wav");
        }
    }

    // EFFECTS: play the sound in in file with sound name
    public void playSound(String soundName) {
        try {
            AudioInputStream audioInputStream = AudioSystem.getAudioInputStream(new File(soundName).getAbsoluteFile());
            Clip clip = AudioSystem.getClip();
            clip.open(audioInputStream);
            clip.start();
        } catch (Exception ex) {
            System.out.println("Error with playing sound.");
            ex.printStackTrace();
        }
    }

}
