import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tdms/data/models/box_model.dart';
import 'package:tdms/data/remote_data_source/firestore_helper.dart';
import 'package:tdms/modify.dart';
import 'package:tdms/edit.dart';
import 'package:tdms/scan.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.red[800],
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => QRViewExample()));
          },
          label: const Text('Scan'),
          icon: const Icon(Icons.qr_code_2),
        ),
        appBar: AppBar(
          title: Text("TDMS"),
          backgroundColor: Colors.red[800],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: 'Add a New Box',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ModifyPage()));
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder<List<BoxModel>>(
                  stream: FirestoreHelper.read(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("some error occured"),
                      );
                    }
                    if (snapshot.hasData) {
                      final userData = snapshot.data;
                      return Expanded(
                        child: ListView.builder(
                            itemCount: userData!.length,
                            itemBuilder: (context, index) {
                              final singleUser = userData[index];
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Delete"),
                                            content: Text(
                                                "Are you sure you want to delete"),
                                            actions: [
                                              ElevatedButton(
                                                  style: const ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll<
                                                                Color>(
                                                            Color.fromARGB(255,
                                                                198, 40, 40)),
                                                  ),
                                                  onPressed: () {
                                                    FirestoreHelper.delete(
                                                            singleUser)
                                                        .then((value) {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Text("Delete"))
                                            ],
                                          );
                                        });
                                  },
                                  title: Text("Box ID: ${singleUser.boxID}"),
                                  subtitle:
                                      Text("Contents: ${singleUser.contents}"),
                                  trailing: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => EditPage(
                                                      user: BoxModel(
                                                          boxID:
                                                              singleUser.boxID,
                                                          contents: singleUser
                                                              .contents,
                                                          vname:
                                                              singleUser.vname,
                                                          caseID: singleUser
                                                              .caseID),
                                                    )));
                                      },
                                      child: Icon(Icons.edit)),
                                ),
                              );
                            }),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
