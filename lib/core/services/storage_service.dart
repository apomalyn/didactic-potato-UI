import 'dart:async';
import 'dart:html';
import 'package:firebase/firebase.dart' as Firebase;

class StorageService {
  /// Upload a [File] file into the Firebase storage.
  /// The file will be upload into the folder cv/ or images/ of the buckets
  /// depends on the extension of the file.
  /// @param file to upload
  /// @param filename should be the uuid of the User followed by the extension of the file
  Future<bool> uploadFile(File file, {String filename}) async {
    try {
      var path =
      filename.split('.').last == 'pdf' ? "cv/$filename" : "images/$filename";

      Firebase.StorageReference storageRef = Firebase.storage().ref(path);
      Firebase.UploadTaskSnapshot uploadTaskSnapshot =
      await storageRef.put(file).future;

      return true;
    } catch (e) {
      print("STORAGE - UPLOAD - ERROR: $e");
      return false;
    }
  }
}
