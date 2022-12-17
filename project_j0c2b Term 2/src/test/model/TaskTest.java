package model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TaskTest {
    private Task task;

    @BeforeEach
    void runBefore() {
        task = new Task("task1");
    }

    @Test
    public void testTaskName() {
        String expectName = "TestName";
        task.setTaskName(expectName);
        assertEquals(expectName,task.getTaskName());
    }

    @Test
    public void testStatus() {
        assertEquals(false, task.getTaskStatus());
        task.setTaskStatus(true);
        assertEquals(true,task.getTaskStatus());
    }

    @Test
    public void testComplete() {
        assertEquals(false, task.getTaskStatus());
        task.complete();
        assertEquals(true,task.getTaskStatus());
    }
}
