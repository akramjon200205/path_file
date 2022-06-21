import 'dart:io';

import 'package:filesize/filesize.dart';

class Path {
  List<FileSystemEntity> direct = [];
  start() {
    print("Katalogni kiriting:");
    String filePath = stdin.readLineSync()!;
    printFolders(filePath);
  }

  void printFolders(String path) {
    final dir = Directory(path);
    final List<FileSystemEntity> directory = dir.listSync().toList();
    print(path.replaceAll("\\", "/").split("/").last);
    List<FileSystemEntity> file = [];
    int n = 0;

    for (var i = 0; i < directory.length; i++) {
      if (!(directory[i] is File)) {
        direct.add(directory[i]);
        print(
            "${n}📂  |   ${directory[i].toString().exchange().split("/").last} - ${directory[i].statSync().changed}");
        n++;
      }
    }

    var a = 0;
    for (var i = 0; i < directory.length; i++) {
      if (directory[i] is File) {
        direct.add(directory[i]);
        var fileSize = filesize(directory[i].statSync().size);
        if (directory[i] is File) {
          print(
              "${a++}📄  |   ${directory[i].toString().exchange().split("/").last} - ${directory[i].statSync().changed} - $fileSize");
        }
      }
    }

    for (var i = direct.length - 1; i >= 0; i--) {
      var first = 0, temp;
      for (var j = 1; j <= i; j++) {
        if (direct[j].statSync().size > direct[first].statSync().size) {
          first = j;
        }

        temp = direct[first];
        direct[first] = direct[i];
        direct[i] = temp;
      }
    }
    print("\n");
    a = 0;
    for (var i = 0; i < direct.length - 1; i++) {
      if (direct[i] is File) {
        var fileSize = filesize(direct[i].statSync().size);
        print(
            "${a++}📄  |   ${direct[i].toString().exchange().split("/").last} - ${direct[i].statSync().changed} - $fileSize");
      }
    }
    // print("Tartib raqamini kiriting(qaytish uchun '0'): ");
    // String tanlovS = stdin.readLineSync()!;

    // if (tanlovS.toLowerCase() == "exit") {
    //   exit(0);
    // } else {
    //   int tanlov = int.parse(tanlovS);
    //   if (tanlov == 0) {
    //     printFolders(path.cutLastFolder());
    //   } else {
    //     if (directory[tanlov - 1] is Directory) {
    //       printFolders(directory[tanlov - 1].toString().exchange());
    //     } else if (directory[tanlov - 1] is File) {
    //       print(directory[tanlov - 1]);
    //       print(
    //           "Siz tanlagan raqamda  katalog mavjud emas \ndavom ettirish uchun 1 ni bosing?");
    //       if (int.parse(stdin.readLineSync()!) == 1) {
    //         printFolders(path);
    //       } else {
    //         exit(0);
    //       }
    //     }
    //   }
    // }
  }
}

extension Exchange on String {
  String exchange() {
    return this.replaceAll("\\", "/").split("'")[1];
  }

  String exchangeNoSplit() {
    return this.replaceAll("\\", "/");
  }

  String cutLastFolder() {
    List<String> w = this.split("/").toList();
    String natija = '';
    for (int i = 0; i < w.length - 1; i++) {
      natija += "${i == 0 ? w[i] : '/${w[i]}'}";
    }
    return natija;
  }
}
