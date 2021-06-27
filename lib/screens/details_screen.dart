import 'package:flutter/material.dart';
import 'package:lastexam/data/database_helper.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.passing,}) : super(key: key);
  final int? passing;

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
                child: Text(Database.getTitle(passing)),
              ),

              Container(
              ),
              SizedBox(height: 50,),
              Container(

              ),
              SizedBox(height: 500,)
            ],
          ),
        ),
      ),
    );
  }
}
