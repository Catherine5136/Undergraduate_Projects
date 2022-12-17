package model;

import persistence.Saveable;

import java.io.PrintWriter;
import java.util.ArrayList;

// Represents a to-do list having a list of tasks

public class ToDoList implements Saveable {
    private ArrayList<Task> todoList;

    // EFFECTS: constructs to-do list with no tasks
    public ToDoList() {
        this.todoList = new ArrayList<>();
    }

    public void setTodoList(ArrayList<Task> tasks) {
        this.todoList = tasks;
    }


    // EFFECTS: add tasks to to-do list with name given
    public void addTask(String name) {
        Task task = new Task(name);
        this.todoList.add(task);
    }

    // EFFECTS: delete tasks in to-do list with name given
    public void deleteTask(String name) {
        for (Task t : todoList) {
            if (t.getTaskName().compareTo(name) == 0) {
                todoList.remove(t);
                break;
            }
        }
    }

    // MODIFIES: this
    // EFFECTS: if no tasks in the to-do list with the given name,
    //          throw NoSuchTaskException
    //          otherwise, set task status to completed in to-do list with name given
    public void completeTask(String name) throws NoSuchTaskException {
        if (noTaskWithName(name)) {
            throw new NoSuchTaskException();
        }
        for (Task t : todoList) {
            if (t.getTaskName().compareTo(name) == 0) {
                t.complete();
            }
        }
    }


    // EFFECTS: return list of tasks
    public ArrayList<Task> getAllToDoList() {
        return this.todoList;
    }


    // EFFECTS: return true if no task in list with the name given,
    //          false otherwise
    public Boolean noTaskWithName(String name) {
        ArrayList<String> listOfString = new ArrayList<>();
        for (Task t : todoList) {
            if (t.getTaskName().compareTo(name) == 0) {
                listOfString.add(t.getTaskName());
            }
        }
        return listOfString.isEmpty();
    }

    // EFFECTS: Transfer the to-do list into string with separate lines
    public StringBuilder getToDoListByString() {
        StringBuilder s = new StringBuilder();

        for (Task t : todoList) {
            if (t.getTaskStatus()) {
                s.append(t.getTaskName()).append(" (completed)").append("\n");
            } else {
                s.append(t.getTaskName()).append("\n");
            }
        }
        return s;
    }

    @Override
    //EFFECTS: save list of task
    public void save(PrintWriter printWriter) {
        StringBuilder s = getToDoListByString();
        printWriter.print(s);
    }
}
