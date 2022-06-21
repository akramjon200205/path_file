import 'dart:io';

class Path {
  start() {
    print("Katalogni kiriting:");
    String filePath = stdin.readLineSync()!;
    printFolders(filePath);
  }

  // open(String folder) {
  //   print("papka raqamini tanlang:");
  //   int choice = int.parse(stdin.readLineSync()!);
  //   printFolders(folder);
  // }

  void printFolders(String path) {
    final dir = Directory(path);
    final List<FileSystemEntity> entities = dir.listSync().toList();
    print(path.replaceAll("\\", "/").split("/").last);
    List<FileSystemEntity> file = [];
    int i = 1;

    entities.forEach((element) {
      file.add(element);
      if (element is File) {
        print("${i++}📄  |   ${element.toString().exchange().split("/").last}");
      } else if (element is Directory) {
        print("${i++}📂  |   ${element.toString().exchange().split("/").last}");
      }
    });
    print("Tartib raqamini kiriting(qaytish uchun '0'): ");
    String tanlovS = stdin.readLineSync()!;

    if (tanlovS.toLowerCase() == "exit") {
      exit(0);
    } else {
      int tanlov = int.parse(tanlovS);
      if (tanlov == 0) {
        printFolders(path.cutLastFolder());
      } else {
        if (entities[tanlov - 1] is Directory) {
          printFolders(entities[tanlov - 1].toString().exchange());
        } else if (entities[tanlov - 1] is File) {
          print(entities[tanlov - 1]);
          print("Bu tanlov katalog emas \ndavom ettirish uchun 1 ni bosing?");
          if (int.parse(stdin.readLineSync()!) == 1) {
            printFolders(path);
          } else {
            exit(0);
          }
        }
      }
    }
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
