import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tdms/data/models/box_model.dart';

class FirestoreHelper {
  static Stream<List<BoxModel>> read() {
    final boxCollection = FirebaseFirestore.instance.collection("boxes");
    return boxCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => BoxModel.fromSnapshot(e)).toList());
  }

  static Future create(BoxModel box) async {
    final boxCollection = FirebaseFirestore.instance.collection("boxes");
    final bid = boxCollection.doc(box.boxID).id;
    final docRef = boxCollection.doc(bid);

    final newUser = BoxModel(
            boxID: box.boxID,
            vname: box.vname,
            caseID: box.caseID,
            contents: box.contents)
        .toJson();

    try {
      await docRef.set(newUser);
    } catch (e) {
      print("some error occured $e");
    }
  }

  static Future update(BoxModel box) async {
    final boxCollection = FirebaseFirestore.instance.collection("boxes");
    final bid = boxCollection.doc(box.boxID).id;
    final docRef = boxCollection.doc(bid);

    final newUser = BoxModel(
            boxID: box.boxID,
            vname: box.vname,
            caseID: box.caseID,
            contents: box.contents)
        .toJson();

    try {
      await docRef.set(newUser);
    } catch (e) {
      print("some error occured $e");
    }
  }

  static Future delete(BoxModel user) async {
    final boxCollection = FirebaseFirestore.instance.collection("boxes");
    final docRef = boxCollection.doc(user.boxID).delete();
  }
}
