import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lastexam/data/database_helper.dart';
import 'package:lastexam/screens/details_screen.dart';
import 'add_new_item.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collectionReference = _firestore.collection('notes');

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "/home-screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(0, -1),
    end: Offset(0, 0),
  ).animate(_animationController);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "TODO APP",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black26),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () =>
                            showModalBottomSheet(
                                context: context,
                                builder: (_) => AddNewItem()).then((_) {
                              setState(() {});
                            }),
                        child: Icon(Icons.add),
                        backgroundColor: Colors.teal,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Flexible(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFF04a3a36cb4b1),
                      borderRadius: BorderRadius.circular(30)),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Database.readItems(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("oops! something went wrong!");
                        } else if (snapshot.hasError || snapshot.data != null) {
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                String title =
                                snapshot.data!.docs[index].get('title');
                                String toDoTask =
                                snapshot.data!.docs[index].get('toDoTask');
                                bool taskState =
                                snapshot.data!.docs[index].get('taskState');
                                return Padding(
                                  padding: EdgeInsets.only(left: 30, right: 30),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      // onLongPress: () => Database.deleteItems(
                                      //     docID: snapshot.data!.docs[index].id),
                                      onLongPress: () => showDialog(
                                          context: context,
                                          builder: (BuildContext context)=> AlertDialog(
                                            title: Text("Are you sure you want to delete this?"),
                                            actions: <Widget>[
                                              TextButton(onPressed: () =>Navigator.pop(context, Database.deleteItems(
                                                  docID: snapshot.data!.docs[index].id))

                                              ,child: Text('yes')),
                                              TextButton(onPressed:() => Navigator.pop(context,'no'), child: Text('no'))
                                            ],
                                          )),
                                      onTap: () =>
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (_) =>
                                                  DetailsScreen(passing: index))
                                              .then((_) {
                                            setState(() {});
                                          }),
                                      title: Text(title),
                                      subtitle: Text(toDoTask),
                                      trailing: FloatingActionButton(
                                        backgroundColor: taskState
                                            ? Color(0xFF0ecc57)
                                            : Color(0xFF6cb4b1),
                                        onPressed: () {
                                          setState(() async {
                                            var data = <String, dynamic>{
                                              'taskState': taskState = true
                                            };
                                            if (taskState == false) {
                                              _collectionReference
                                                  .doc(Database.userID)
                                                  .collection('items')
                                                  .doc('taskState')
                                                  .update(data);
                                            }
                                            var data2 = <String, dynamic>{
                                              'taskState': taskState = true
                                            };
                                            if (taskState == true) {
                                              _collectionReference
                                                  .doc(Database.userID)
                                                  .collection('items')
                                                  .doc('taskState')
                                                  .update(data2);
                                            }
                                          });
                                        },
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(
                                    height: 15.0,
                                  ),
                              itemCount: snapshot.data!.docs.length);
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
