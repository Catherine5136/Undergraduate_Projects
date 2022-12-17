## My Personal Project

I want to design a **to-do list application**.
It can keep track of things to do, cross things off. It can show an overview of all tasks, people could add due date, and sort items into different groups.
Everyone who want to make a plan to their study or jobs, like office workers, students can use this application to make a schedule, 
to see what they need to finish next step. 

I think having a good plan is important to everyone to have a reasonable and critical organization to their life.
Therefore it should be a very useful application in real life. 


###User stories:
- As a user,  I want to be able to *add* a task to my to-do list
- As a user, I want to be able to view the list of tasks on my to-do list
- As a user, I want to be able to *delete* a task from my to-do list
- As a user, I want to be able to mark a task as complete on my to-do list
- As a user, I want to be able to *save* my to-do list to file
- As a user, I want to be able to optionally *load* my to-do list from file when the program starts

###Instructions for Grader: 

Run the GUI class, then

- You can generate the first required event by enter the name of task to text field 
and click "Add New Task", the task will be added to the list
- You can generate the second required event by select any tasks in the list (if there exist tasks on the list)
and click button "Remove Selected Task", then the task you select will be removed from the list, or button "Complete Task",
then the selected task will be marked as (completed)
- You can trigger my audio component by clicking any buttons in my panel
- You can save the state of my application by clicking "Save" button and find it in ./data/tasks.txt file
- You can reload the state of my application by clicking "Load from file" button, then the tasks 
in file ./data/tasks.txt will be loaded. If you want to start a new list, clicking button "Create a new List"

###Phase 4: Task 2

- For task 2 , I choose the first option: Test and design a class that is robust.
You can find it in **ToDoList** class, the method is called **completeTask**, it throws NoSuchTaskException, 
which is the exception created by myself. The exception is about the case when we want to mark "completed" for a task, but there is 
no task in our list with this name.
This method is called in **Main** class, method **completeAnTask**, where I use the **try and catch**
to implement it and print "This task does not exist" when exceptions happen, you can see it when you run Main class.
And you can find the test in **ToDoListTest**, with name "testCompleteTaskNotExpectedException" and
"testCompleteTaskExpectedException" respectively.


###Phase 4: Task 3

- For task 3, Initially my **complete** method is in **Main** class has "for loop" implements on to-do list, 
which you can see it in my Phase 3 and the first push for my Phase 4. Since these implementations is about to-do list,
it should be in "ToDoList" class rather than "Main" class. I then create a new method **completeTask** in 
**ToDoList** class and move the implementations in "complete" method to there, so that the method **completeAnTask**
in **Main** class can focus on displaying, not dealing with the to-do list. For the second problem, I found there are duplicated codes
in both "save" method in "ToDoList" class and "viewToDoList" method in "Main" class, the duplicated part is about transfer 
a to-do list to string format. Then I create a new method "getToDoListByString" in "ToDoList" to reduce the copy the improve 
cohesion.



An example of text with **bold** and *italic* fonts.  Note that the IntelliJ markdown previewer doesn't seem to render 
the bold and italic fonts correctly but they will appear correctly on GitHub.