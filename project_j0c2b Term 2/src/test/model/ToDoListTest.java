package model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class ToDoListTest {

    private ToDoList toDoList;


    @BeforeEach
    void runBefore() {
        toDoList = new ToDoList();
    }

    @Test
    public void testAddTask() {
        toDoList.addTask("A");
        assertEquals(1, toDoList.getAllToDoList().size());
        toDoList.addTask("B");
        toDoList.addTask("C");
        assertEquals(3, toDoList.getAllToDoList().size());

    }

    @Test
    public void testRemoveTask() {
        toDoList.addTask("name");
        assertEquals(1, toDoList.getAllToDoList().size());
        toDoList.deleteTask("name");
        assertEquals(0, toDoList.getAllToDoList().size());
        toDoList.addTask("A");
        toDoList.addTask("B");
        toDoList.addTask("C");
        toDoList.addTask("D");
        assertEquals(4, toDoList.getAllToDoList().size());
        toDoList.deleteTask("A");
        assertEquals(3, toDoList.getAllToDoList().size());
        toDoList.deleteTask("G");
        assertEquals(3, toDoList.getAllToDoList().size());
        toDoList.deleteTask("B");
        toDoList.deleteTask("C");
        toDoList.deleteTask("D");
        assertEquals(0, toDoList.getAllToDoList().size());
    }

    @Test
    public void testCompleteTaskNotExpectedException() {
        try {
            toDoList.addTask("A");
            assertEquals(1, toDoList.getAllToDoList().size());
            toDoList.addTask("B");
            toDoList.addTask("C");
            toDoList.addTask("A");
            assertEquals(4, toDoList.getAllToDoList().size());
            toDoList.completeTask("A");
            assertTrue(toDoList.getAllToDoList().get(0).getTaskStatus());
            assertTrue(toDoList.getAllToDoList().get(3).getTaskStatus());
        } catch (NoSuchTaskException e) {
            fail();
        }
    }

    @Test
    public void testCompleteTaskExpectedException() {
        try {
            toDoList.addTask("A");
            assertEquals(1, toDoList.getAllToDoList().size());
            toDoList.addTask("B");
            toDoList.addTask("C");
            assertEquals(3, toDoList.getAllToDoList().size());
            toDoList.completeTask("D");
            fail();
        } catch (NoSuchTaskException e) {
            System.out.println("good!");
        }
    }


}
