import 'dart:convert';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:green_todos_app/navbar.dart';
import 'package:green_todos_app/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MaterialApp(home: AnimatedSplashScreen(splash: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(('Green ToDos'), style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white, fontSize: 40,),),
            Text(('be productive.'), style: TextStyle(fontSize: 20, color:Colors.black, fontWeight: FontWeight.bold, )),
          ],
        ),
      ]

  ), nextScreen: HomePage(), backgroundColor: Color(0xFF00E676), splashTransition: SplashTransition.fadeTransition, duration: 2000,),));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map<String, dynamic> todo = {};
  TextEditingController _controller = new TextEditingController();


  @override
  void initState() {
    _loadData();
  }

  _loadData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    if (storage.getString('todo') != null) {
      todo = jsonDecode(storage.getString('todo')!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            bottomNavigationBar: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(
                          'New ToDo', style: TextStyle(
                          fontSize: 20,
                        ),
                        ),
                        content: TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Cooking for dinner...',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF00E676))
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF00E676)),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF00E676)),
                            ),
                          ),
                        ),
                        actions: [
                          FlatButton(
                            child: Text('CANCEL', style: TextStyle(
                              color: Colors.black,
                            ),),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text('CREATE', style: TextStyle(
                              color: Color(0xFF00E676),
                            ),),
                            onPressed: () {
                              Navigator.pop(context);
                              _addTodo();
                            },
                          )
                        ],
                      );
                    }
                );
              },
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00E676)
                      ),
                      child: Icon(Icons.add, color: Colors.white,),
                    )
                  ],
                ),
              ),
            ),




            body: Column(
              children: [
                Navbar(),
                SizedBox(height: 30,),
                Expanded(
                  child: ListView.builder(
                    itemCount: todo.length,
                    itemBuilder: (context, i) {
                      return Dismissible(
                        key: Key('item'+i.toString()),
                        onDismissed: (direction) {
                          todo.remove(todo.keys.elementAt(i));
                          _save();
                        },
                        child: InkWell (
                          onTap: () {
                            setState(() {
                              todo[todo.keys.elementAt(i)] = !todo[todo.keys.elementAt(i)];
                            });
                            _save();
                          },
                          child: TodoItem(name: todo.keys.elementAt(i), isActive: todo.values.elementAt(i)),
                        ),
                      );
                    },
                  ),
                )
              ],
            )
        ),
      ),
    );
  }



  _addTodo() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    if (_controller.text.length > 0) {
      setState(() {
        todo.putIfAbsent(_controller.text, () => false);
        storage.setString('todo', jsonEncode(todo));
      });
    }
  }

  _save() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    storage.setString('todo', jsonEncode(todo));
  }
}





