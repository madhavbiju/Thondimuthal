import 'package:cloud_firestore/cloud_firestore.dart';

class BoxModel {
  final String? boxID;
  final String? caseID;
  final String? vname;
  final String? contents;

  BoxModel({this.boxID, this.caseID, this.vname, this.contents});

  factory BoxModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return BoxModel(
        vname: snapshot['vname'],
        boxID: snapshot['boxID'],
        caseID: snapshot['caseID'],
        contents: snapshot['contents']);
  }

  Map<String, dynamic> toJson() => {
        "vname": vname,
        "boxID": boxID,
        "caseID": caseID,
        "contents": contents,
      };
}
