package ui;

import model.NoSuchTaskException;
import model.Task;
import model.ToDoList;
import persistence.Reader;
import persistence.Writer;


import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Scanner;

public class Main {

    private static final String TASKS_FILE = "./data/tasks.txt";

    private ToDoList toDoList = new ToDoList();


    public static void main(String[] args) {
        Main main = new Main();
        main.run();
    }


    // MODIFIES: this
    // EFFECTS: runs the to-do list application
    public void run() {
        continueLastTime();
        while (true) {
            option();
            Scanner userInput = new Scanner(System.in);
            String chooseNumber = userInput.next();
            if (chooseNumber.compareTo("1") == 0) {
                addAnTask(userInput);
            } else if (chooseNumber.compareTo("2") == 0) {
                deleteAnTask(userInput);
            } else if (chooseNumber.compareTo("3") == 0) {
                completeAnTask(userInput);
            } else if (chooseNumber.compareTo("4") == 0) {
                viewToDoList();
            } else if (chooseNumber.compareTo("5") == 0) {
                saveAccounts();
            } else if (chooseNumber.compareTo("6") == 0) {
                System.out.println("Goodbye!");
                break;
            } else {
                System.out.println("Selection not valid...");
            }
        }
    }

    // EFFECTS: Choose 1 or 2 to create a new list or load from file respectively
    public void continueLastTime() {
        System.out.println("1. start a new list");
        System.out.println("2. continue the last time");
        Scanner userInput = new Scanner(System.in);
        String chooseNumber = userInput.next();
        if (chooseNumber.compareTo("2") == 0) {
            loadTasks();
        }
    }


    // MODIFIES: this
    // EFFECTS: loads tasks from TASKS_FILE, if that file exists;
    // otherwise initializes accounts with default values
    private void loadTasks() {
        try {
            ArrayList<Task> tasks = Reader.readTasks(new File(TASKS_FILE));
            toDoList.setTodoList(tasks);
        } catch (IOException e) {
            init();
        }
    }

    // EFFECTS: Create a new list
    private void init() {
        toDoList = new ToDoList();
    }


    // EFFECTS: saves to-do list to TASKS_FILE
    private void saveAccounts() {
        try {
            Writer writer = new Writer(new File(TASKS_FILE));
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


    // EFFECTS: displays menu of options to user
    public void option() {
        System.out.println("1. Add a task to my to-do list");
        System.out.println("2. Delete a task from my to-do-list");
        System.out.println("3. Mark a task as complete on my to-do list");
        System.out.println("4. View the list of tasks on my to-do list");
        System.out.println("5. Save accounts to file");
        System.out.println("6. Exit");
    }


    // MODIFIES: this
    // EFFECTS: add tasks to to-do list with name given
    public void addAnTask(Scanner userInput) {
        System.out.println("Please enter the name of new task");
        String name = userInput.next();
        this.toDoList.addTask(name);
        System.out.println("This task is added");
    }

    // MODIFIES: this
    // EFFECTS: delete tasks in to-do list with name given
    public void deleteAnTask(Scanner userInput) {
        System.out.println("Please enter the task name to delete");
        String name = userInput.next();
        this.toDoList.deleteTask(name);
        System.out.println("This task is deleted.");
    }


    // EFFECTS: view tasks to do
    public void viewToDoList() {
        StringBuilder s = toDoList.getToDoListByString();
        System.out.println(s);
    }


    // MODIFIES: this
    // EFFECTS: mark complete for task in to-do list with name given
    public void completeAnTask(Scanner userInput) {
        System.out.println("Please enter the complete task name");
        String name = userInput.next();
        try {
            toDoList.completeTask(name);
            System.out.println("This task is completed");
        } catch (NoSuchTaskException e) {
            System.out.println("This task does not exist");
        }
    }

}
