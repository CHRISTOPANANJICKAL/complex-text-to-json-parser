import 'dart:io';

import 'main.dart';
import 'model.dart';

String error = "";
arrangeLines(String data, int lineNumber) {
  try {
    String line = data.trim().replaceAll("\"", "");
    List splitHash = line.split("#");
    int size = int.parse(splitHash[1].toString().trim().split(" ")[0]);
    if (size == 0) {
      error = error +
          myName +
          " size 0 error at line $lineNumber  , " +
          line +
          "\n";
    }
    String name =
        splitHash[1].toString().trim().replaceFirst(size.toString(), "").trim();
    List<String> medicines1 = splitHash[3].toString().trim().split(",");
    List<String> medicines = [];
    medicines1.forEach((element) {
      if (element.trim().isNotEmpty) {
        medicines.add(element.trim());
      }
    });
    RepModel model =
        RepModel(name: name, size: size, medicines: medicines, subItems: []);
    return model;
  } catch (e) {
    print("error at line $lineNumber ," + data);
  }
}

int findNextAt(List<RepModel> repList, int i) {
  for (int j = i + 1; j < repList.length; j++) {
    RepModel m2 = repList[j];
    if (m2.size == 2) {
      return j;
    }
  }
  return -1;
}

List<RepModel> getRepList(List<String> data) {
  List<RepModel> repList = [];
  error = "";
  for (int i = 0; i < data.length; i++) {
    if (data[i].trim().isNotEmpty) {
      repList.add(arrangeLines(data[i], i));
    }
  }
  if (error.isNotEmpty) {
    gotError();
  }
  return repList;
}

gotError() async {
  File file = File("errors.txt");
  await file.writeAsString(error);
  exit(0);
}

List<RepModel> getTempList(List<RepModel> repList, int start, int stop) {
  List<RepModel> tempList = [];
  for (int i = start; i < stop; i++) {
    tempList.add(repList[i]);
  }
  return tempList;
}

Future<RepModel> sortDataOfTempList(List<RepModel> tempList) async {
  while (tempList.length > 1) {
    int largest = findLargest(tempList);
    for (int i = 0; i < tempList.length; i++) {
      if (tempList[i].size == largest) {
        try {
          tempList[i - 1].addSubItem(tempList[i]);
        } catch (e) {
          // RepModel m = await doPrintOfModel(tempList[i]);
          // tempList[i - 1].addSubItem(m);
          print(
              "line :" + tempList[i].name + " #" + tempList[i].size.toString());
          print(e.toString());
          await Future.delayed(Duration(seconds: 10));
          exit(0);
        }
        tempList.removeAt(i);
        i = i - 1;
      }
    }
  }
  return tempList[0];
}

int findLargest(List<RepModel> model) {
  int largest = 0;
  for (int i = 0; i < model.length; i++) {
    if (model[i].size > largest) {
      largest = model[i].size;
    }
  }
  return largest;
}

doPrintOfModel(String fileName) async {
  File file = File(fileName);
  List data = file.readAsLinesSync();
  List newData = [];
  File overFile = File("overFile.txt");
  data.forEach((element) {
    newData.add(element.toString().trim());
  });
  String dataToWrite = "";
  newData.forEach((element) {
    dataToWrite = dataToWrite + element + "\n";
  });
  overFile.writeAsStringSync(dataToWrite);
  print("ok");
}
