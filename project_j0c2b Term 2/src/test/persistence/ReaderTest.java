package persistence;

import model.Task;
import model.ToDoList;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;


import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

public class ReaderTest {

    private Reader reader = new Reader();

    @Test
    void testParseAccountsFile1() {
        try {
            ArrayList<Task> tasks = reader.readTasks(new File("./data/testFile1"));
            ToDoList t = new ToDoList();
            t.setTodoList(tasks);


            assertEquals("aaa", tasks.get(0).getTaskName());
            assertEquals("bbb", tasks.get(1).getTaskName());
            assertEquals("ccc", tasks.get(2).getTaskName());


        } catch (IOException e) {
            fail("IOException should not have been thrown");
        }
    }


    @Test
    void testIOException() {
        try {
            reader.readTasks(new File("./path/does/not/exist/testAccount.txt"));
        } catch (IOException e) {
            // expected
        }
    }

}
