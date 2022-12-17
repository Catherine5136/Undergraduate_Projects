package persistence;

import model.Task;
import model.ToDoList;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;


import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

public class WriterTest {
    private static final String TEST_FILE = "./data/testFile";
    private Writer testWriter;
    private ArrayList<Task> tasks = new ArrayList<>();
    private ToDoList t;
    private Task t1 = new Task("A");
    private Task t2 = new Task("B");
    private Task t3 = new Task("C");

    @BeforeEach
    void runBefore() throws FileNotFoundException, UnsupportedEncodingException {
        testWriter = new Writer(new File(TEST_FILE));
        tasks.add(t1);
        tasks.add(t2);
        tasks.add(t3);
        t = new ToDoList();
        t.setTodoList(tasks);
    }

    @Test
    void testWriteTasks() {
        // save to-do list to file
        testWriter.write(t);
        testWriter.close();

        // now read them back in and verify that the accounts have the expected values
        try {
            ArrayList<Task> tasks = Reader.readTasks(new File(TEST_FILE));
            assertEquals("A", tasks.get(0).getTaskName());
            assertEquals("B", tasks.get(1).getTaskName());
            assertEquals("C", tasks.get(2).getTaskName());

        } catch (IOException e) {
            fail("IOException should not have been thrown");
        }
    }
}
