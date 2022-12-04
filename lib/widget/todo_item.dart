import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myfirstapp03/constants/colors.dart';
import 'package:myfirstapp03/model/todo.dart';

class TodoItems extends StatelessWidget {
  final ToDo todo;
  final onTileClick;
  final onDelete;
  
  //specifying the type that we need to take from the home which is
  // single individual todo obejct with in their own property
  // which we can access like id , todoText
  // int todo
  const TodoItems({Key? key, required this.todo , required this.onTileClick , required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.fromLTRB(4, 0, 4, 10),
      

      child: ListTile(
        onTap: () {
          onTileClick(todo);
         
        },
        //the shape of list tile will be speicified here
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(todo.todoText,
            style: TextStyle(
              fontFamily: 'Test',
              fontWeight: FontWeight.bold,
              letterSpacing: 0.1,
              fontSize: 14.3,
              decoration: todo.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            )),

        trailing: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 10 ),
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              color: tdRed,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              onPressed: () {
                onDelete(todo);
                // which come from the home by referncing it at the home fat using named arguments can be 
                // which we pass it as a named args then we should be accepting it as a props like reactjs
                
                
              },
              icon: Icon(Icons.delete),
              color: Colors.white,
            )),
      ),
    );
  }
}
