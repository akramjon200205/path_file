import 'dart:io';

class Path {
  start() {
    print("Katalogni kiriting:");
    String filePath = stdin.readLineSync()!;
    printFolders(filePath);    
  }

  open(String folder) {
    print("papka raqamini tanlang:");
    int choice = int.parse(stdin.readLineSync()!);
    printFolders(folder);
  }

  void printFolders(String path) {
    final dir = Directory(path);
    final List<FileSystemEntity> entities = dir.listSync().toList();
    print(path.replaceAll("\\", "/").split("/").last);
    List<FileSystemEntity> file = [];
    int i = 1;

    entities.forEach((element) {
      file.add(element);

      if (element is File) {
        print("     |______");

        print("${i++}📄  |   ${element.toString().exchange().split("/").last}");
      } else if (element is Directory) {
        print("     |______");
        print("${i++}📂  |   ${element.toString().exchange().split("/").last}");
      }
    });
  }
}

extension Exchange on String {
  String exchange() {
    return this.replaceAll("\\", "/").split("'")[1];
  }
}
