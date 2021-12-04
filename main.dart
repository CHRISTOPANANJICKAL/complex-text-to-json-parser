import 'dart:io';

import 'doJob.dart';

String myName = "";

Future<void> main() async {
  Directory directory = Directory("edited");
  List<FileSystemEntity> folders = directory.listSync(recursive: true);
  String workingPath;
  String fileName;
  for (int y = 0; y < folders.length; y++) {
    if (folders[y] is Directory) {
      workingPath = folders[y].path;
      Directory dict = Directory("Output\\" + workingPath);
      dict.createSync(recursive: true);
    } else if (folders[y] is File) {
      fileName = folders[y].path;
      myName = fileName;
      print("working on file " + fileName);
      await doJob(fileName);
    }
    // if (y == 2) {
    //   break;
    // }
  }
}

// Future listDir(String folderPath) async {
//   var directory = new Directory(folderPath);
//   print(directory);

//   var exists = await directory.exists();
//   if (exists) {
//     print("exits");

//     directory
//         .list(recursive: true, followLinks: false)
//         .listen((FileSystemEntity entity) {
//       print(entity.path);
//     });
//   }
// }

  // List contents = directory.listSync();
  // for (var fileOrDir in contents) {
  //   if (fileOrDir is File) {
  //     print("file " + fileOrDir.path);
  //   } else if (fileOrDir is Directory) {
  //     print(fileOrDir.path);
  //   }
  // }