package model;


// Represents a task having a name and status
public class Task {
    private String taskName;
    private boolean isDone;


    // EFFECTS: constructs task with task name and false status
    public Task(String taskName) {
        this.taskName = taskName;
        this.isDone = false;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getTaskName() {
        return this.taskName;
    }

    public void setTaskStatus(boolean isDone) {
        this.isDone = isDone;
    }

    public boolean getTaskStatus() {
        return this.isDone;
    }

    // MODIFIES: this
    // EFFECTS: set task status to is done
    public void complete() {
        this.setTaskStatus(true);
    }


}
