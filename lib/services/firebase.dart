import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  //GET DATA

  final CollectionReference notes = FirebaseFirestore.instance
      .collection('notes'); //'notes' merupakan nama collection atau nama tabel

  //ADD DATA
  Future<void> createNote(String note) {
    return notes.add({
      //'note' merupakan nama kolom di tabel, isinya yaitu note
      'note': note,
      'waktu': Timestamp.now(),
    });
  }

  //READ DATA
  // Fungsi untuk membaca catatan dari Firestore secara real-time
  Stream<QuerySnapshot> readNotes() {
    // Mengambil stream dari koleksi 'notes', mengurutkan berdasarkan 'waktu' secara menurun
    final notesStream = notes.orderBy('waktu', descending: true).snapshots();

    return notesStream;
  }

  //UPDATE DATA
  // Fungsi untuk memperbarui catatan di Firestore berdasarkan ID dokumen
  Future<void> updateNote(String docId, String note) {
    return notes.doc(docId).update(
      {
        // Memperbarui field 'note' dengan nilai baru dan memperbarui field 'waktu' dengan timestamp saat ini
        'note': note,
        'waktu': Timestamp.now(),
      },
    );
  }

  //DELETE DATA
  Future<void> deleteNote(String docId) {
    return notes.doc(docId).delete();
  }
}
