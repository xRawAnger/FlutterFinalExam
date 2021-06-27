


import 'package:flutter/material.dart';
import 'package:lastexam/data/database_helper.dart';
import 'package:lastexam/data/model/task_model.dart';

import 'home_screen.dart';

class EditScreen extends StatelessWidget {
  EditScreen({Key? key}) : super(key: key);

  TextEditingController _titleController = TextEditingController();
  TextEditingController _toDoTaskController = TextEditingController();
  TextEditingController _toDoDescriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFF6cb4b1)
        ),
        padding: EdgeInsets.only(left: 50,right: 50,top: 15,bottom: 15),
        child: Form(
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  controller: _titleController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Title",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              Container(
                child: TextFormField(
                  controller: _toDoTaskController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Task",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              Container(
                child: TextFormField(
                  controller: _toDoDescriptionController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  ),
                  decoration: InputDecoration(
                    hintText: "description",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Container(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.only(left: 20,right: 20),
                      ),
                      onPressed: () {
                        Database.updateItems(TaskModel(
                            title: _titleController.text,
                            toDoTask: _toDoTaskController.text,
                            toDoDescription: _toDoDescriptionController.text),docID);
                        Navigator.pushNamed(context, HomeScreen.routeName);
                        // setState(() {
                        //
                        // });
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: const Color(0xFF6cb4b1),
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ),
              SizedBox(height: 500,)
            ],
          ),
        ),
      ),
    );
  }
}
