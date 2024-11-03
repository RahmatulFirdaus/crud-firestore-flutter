import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practice_firebase/services/firebase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController noteController = TextEditingController();
  FireStoreService fireStoreService = FireStoreService();
  void openBox({String? noteID}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    noteController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Batal")),
              TextButton(
                  onPressed: () {
                    if (noteID == null) {
                      fireStoreService.createNote(noteController.text);
                      noteController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Data Berhasil Disimpan"),
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      fireStoreService.updateNote(noteID, noteController.text);
                      noteController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Data Berhasil Disimpan"),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Simpan")),
            ],
            content: TextField(
              controller: noteController,
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Firebase CRUD"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.readNotes(),
        builder: (context, snapshot) {
          //jika terdapat sebuah data pada firestoreservice.readnotes atau dari koleksi notes, maka akan menampilkan keseluruhan dokumen
          if (snapshot.hasData) {
            List noteList = snapshot.data!.docs;

            return ListView.builder(
                itemBuilder: (context, index) {
                  //mengambil dari masing-masing dokumen
                  DocumentSnapshot noteDocument = noteList[index];
                  String noteID = noteDocument.id;

                  //menampilkan keseluruhan dari dokumen
                  Map<String, dynamic> noteData =
                      noteDocument.data() as Map<String, dynamic>;
                  String noteText = noteData['note'];
                  String noteWaktu = noteData['waktu'].toString();

                  return ListTile(
                    title: Text(noteText),
                    trailing: IconButton(
                        onPressed: () {
                          openBox(noteID: noteID);
                        },
                        icon: Icon(Icons.edit)),
                  );
                },
                itemCount: noteList.length);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openBox();
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
