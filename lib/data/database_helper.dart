import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lastexam/data/model/task_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collectionReference = _firestore.collection('notes');

class Database {
  static String? userID;
  static bool? taskState;

  static Future<void> hasBeenPressed(taskState) async {
    DocumentReference documentReference =
        _collectionReference.doc(userID).collection('items').doc('taskState');
    if (taskState == false){
      taskState = true;
    }
  }

  static Future<void> addItem(TaskModel taskModel) async {
    DocumentReference documentReference =
        _collectionReference.doc(userID).collection('items').doc();

    var data = <String, dynamic>{
      'title': taskModel.title,
      'toDoTask': taskModel.toDoTask,
      'toDoDescription': taskModel.toDoDescription,
      'taskState': taskState = false
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("item has been added to database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference notesReference =
        _collectionReference.doc(userID).collection('items');
    return notesReference.snapshots();
  }

  static getTitle(docID) {
    CollectionReference noteReference =
        _collectionReference.doc(userID).collection('items');
    noteReference.doc('title').get();
  }

  static Future<void> readSingleItem({required String docID}) async {
    DocumentReference<Map<String, dynamic>> noteReference =
        _collectionReference.doc(userID).collection('items').doc(docID);
    await noteReference.get();
  }

  static Future<void> updateItems(TaskModel taskModel, docID) async {
    DocumentReference documentReference =
        _collectionReference.doc(userID).collection('items').doc(docID);

    var data = <String, dynamic>{
      'title': taskModel.title,
      'toDoTask': taskModel.toDoTask,
      'toDoDescription': taskModel.toDoDescription,
    };
    await documentReference
        .update(data)
        .whenComplete(() => print("updated sucessfuly"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteItems({required String docID}) async {
    DocumentReference documentReference =
        _collectionReference.doc(userID).collection('items').doc(docID);
    await documentReference
        .delete()
        .whenComplete(() => print("delete Sucessful"))
        .catchError((e) => print(e));
  }
}
