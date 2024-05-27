import 'package:flutter/material.dart';
import 'package:todo/utils/todo_list.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _controller = TextEditingController();
  List toDoList =[
    ['Learn web development', false],
    ['Drink coffee', false],
  ];
  int? editingIndex;
  void checkBoxChanged(int index){
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
    if (toDoList[index][1]) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task "${toDoList[index][0]}" completed!'))
      );
    }
  }

  void saveNewTask(){
    setState(() {
      if (editingIndex != null) {
        // If a task is being edited, update it
        toDoList[editingIndex!][0] = _controller.text;
        editingIndex = null;
      } else {
        // Otherwise, add a new task
        toDoList.add([_controller.text, false]);
      }
      _controller.clear();
    });
  }

  void deleteTask(int index){
    setState(() {
      toDoList.removeAt(index);
      if (editingIndex == index) {
        editingIndex = null;
        _controller.clear();
      }
    });
  }

  void editTask(int index){  // Modify this function
    setState(() {
      editingIndex = index;
      _controller.text = toDoList[index][0];
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(222, 73, 176, 255),
      appBar: AppBar(
        title: Text('TODO'),
        backgroundColor: const Color.fromARGB(255, 3, 35, 60),
        foregroundColor:const Color(0xFFF8F37A)
        ),
        body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (BuildContext context, index){
            return TodoList(taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1], 
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (context) => deleteTask(index),
            editFunction: (context) => editTask(index),  // Add this line
            );
          } 
        ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child:
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    ),
                  // Text field for providing the inputs
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add new todo items',
                      filled: true,
                      fillColor: Colors.grey.shade400,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color:  Color.fromARGB(255, 3, 35, 60),
                      ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                       focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color:  Color.fromARGB(255, 3, 35, 60),
                      ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      )
                    ),
                  ),
                ),
        
                // Floadting action button to add the new tasks
                FloatingActionButton(
                  onPressed: saveNewTask,
                  child: const Icon(Icons.add),
                  ),
              ],
        ),
      ),
    );
  }
}