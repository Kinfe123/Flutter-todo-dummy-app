import 'package:flutter/material.dart';
import 'package:myfirstapp03/constants/colors.dart';
import 'package:myfirstapp03/widget/todo_item.dart';
import 'package:myfirstapp03/model/todo.dart';
import 'package:flutter/services.dart';
class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  // final ToDo todo = ToDo(id: '01' , todoText: 'i DONT KNOW' , isDone: true);

  final todoLists = ToDo.todoList();
  final _textController = TextEditingController();
  final _searchController = TextEditingController();

  List<ToDo> foundTodo = [];
  // store the lists of the object

  List<String> todos = [
    'checking email',
    'finishing the app',
    'deploying to heroku'
  ];
  @override
  void initState() {
    // TODO: implement initState
    // we are just like fetching at the moment when the component mounted we want to set it for the initial
    // value that we can be filtering later on with out affetcing the original one;
    foundTodo = todoLists;
    super.initState();
  }
  

  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: 40, bottom: 20, left: 20),
                          child: Text(
                            'Todo App',
                            style: TextStyle(
                              letterSpacing: 0.2,
                              fontFamily: 'Test',
                              
                              fontSize: 35,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        for (ToDo todo in foundTodo.reversed)
                          TodoItems(
                              todo: todo,
                              onTileClick: handleClicks,
                              onDelete: handleDelete)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 13),
                        margin: EdgeInsets.only(
                          bottom: 20,
                          right: 20,
                          left: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.cyan),
                          shape: BoxShape.rectangle,
                        ),
                        child: TextField(
                          style: TextStyle(fontFamily: 'Test'),
                          controller: _textController,
                          decoration: InputDecoration(
                              hintText: 'Add a todo',
                              hintStyle: TextStyle(color: Colors.grey , fontFamily: 'Test'),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _textController.clear();
                                },
                              )),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (!_textController.text.isEmpty) {
                            String msg = _textController.text;
                            todoLists.add(ToDo(
                                id: DateTime.now().toString(), todoText: msg));
                            _textController.clear();
                          } else {
                           
                            showAlertDialogue(context);
                          }
                        });
                      },
                      child: Text('+', style: TextStyle(fontSize: 36)),
                      style: ElevatedButton.styleFrom(
                        primary: tdBlue,
                        minimumSize: Size(26, 26),
                        elevation: 5.0,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void handleClicks(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void handleDelete(ToDo todo) {
    setState(() {
      todoLists.remove(todo);
    });
  }

  void runFilter(String enteredText) {
    List<ToDo> result = [];

    if (enteredText.isEmpty) {
      result = todoLists;
    } else {
      result = todoLists
          .where((element) => element.todoText
              .toLowerCase()
              .contains(enteredText.toLowerCase()))
          .toList();
    }
    setState(() {
      foundTodo = result;
    });
  }

  showAlertDialogue(BuildContext context) {
    Widget oKbutton = ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(tdRed),
        elevation: MaterialStateProperty.all<double>(2.0),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text('Okay' , style: TextStyle(fontFamily: 'Test'),),
    );
    AlertDialog alertDialog = AlertDialog(
      title: Text('Empty feild', style: TextStyle(fontFamily: 'Test'),),
      content: Text('You should have to put something to add on' ,style: TextStyle(fontFamily: 'Test')),
      actions: [
        oKbutton,
      ],
    );
    showDialog(
        context: context, builder: ((BuildContext context) => alertDialog));
  }

  Widget SearchBox() {
    return (Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => runFilter(value),
        style: TextStyle(fontFamily: 'Test'),
        decoration: InputDecoration(
            
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey , fontFamily: 'Test'),
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(0, 13, 0, 0),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  foundTodo = todoLists;
                });
              },
              icon: Icon(Icons.clear),
              color: tdBlack,
              iconSize: 20,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            )),
      ),
    ));
  }

  AppBar buildAppBar() {
    return AppBar(
       systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        backgroundColor: tdBGColor,
        elevation: 1.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu, size: 30, color: Colors.black),
            Container(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(image: AssetImage('assets/avatar.jpeg')),
              ),
            )
          ],
        ));
  }
}
 

// class SearchBox extends StatelessWidget {
//   const SearchBox({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
