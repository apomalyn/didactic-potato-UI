// FLUTTER AND THIRD-PARTIES
import 'dart:async';
import 'dart:html';
import 'package:firebase/firebase.dart' as Firebase;

class StorageService {
  /// Upload a [File] file into the Firebase storage.
  /// The file will be upload into the folder cv/ or images/ of the buckets
  /// depends on the extension of the file.
  /// @param file to upload
  /// @param filename should be the uuid of the User followed by the extension of the file
  /// @return bool - true if the upload succeed
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

  /// Return the download url of a file
  /// @param uuid of the user
  /// @param isAvatar
  /// @return url
  Future<String> getUrlLink(String uuid, {bool isAvatar = true}) async {
    var path = isAvatar ? "images/$uuid.jpeg" : "cv/$uuid.pdf";

    try {
      Firebase.StorageReference storageReference = Firebase.storage().ref(path);
      return (await storageReference.getDownloadURL()).toString();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
