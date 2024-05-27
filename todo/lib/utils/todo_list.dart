import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/utils/todo_list.dart';

class TodoList extends StatelessWidget{
  const TodoList ({super.key,
  required this.taskName, 
  required this.taskCompleted, 
  required this.onChanged,
  required this.deleteFunction,
  required this.editFunction,
  });

final String taskName;
final bool taskCompleted;
final Function(bool?)? onChanged;
final Function(BuildContext)? deleteFunction;
final Function(BuildContext)? editFunction;

  @override
  Widget build (BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 0),
      child: Slidable(
        startActionPane: ActionPane(  // Edit icon on the left
          motion: StretchMotion(),
          children: [
            SlidableAction(onPressed: editFunction,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Colors.blue,
            ),
          ],
        ),
        endActionPane: ActionPane(  // Delete icon on the right
          motion: StretchMotion(),
          children: [
            SlidableAction(onPressed: deleteFunction,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Colors.red,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 3, 35, 60),
            borderRadius: BorderRadius.circular(15), 
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted, 
                onChanged: onChanged,
                checkColor: const Color.fromARGB(255, 3, 35, 60),
                activeColor: const Color(0xFFF8F37A),
                side: const BorderSide(
                  color: Color(0xFFF8F37A))
              ),
              Text(
                taskName,
                style:  TextStyle(
                  color: Color(0xFFF8F37A),
                  fontSize: 18,
                  decoration: taskCompleted? 
                    TextDecoration.lineThrough : 
                    TextDecoration.none,
                decorationColor: Colors.white,
                decorationThickness: 2,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }  
}
