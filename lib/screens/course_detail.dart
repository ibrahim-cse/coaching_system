import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

import 'course_booking.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({Key? key}) : super(key: key);

  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Courses(),
                  ));
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text('Course Detail'),
      ),
      body: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 400.0),
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              child: Text('Pick Videos'),
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles();
                if (result == null) return;

                final file = result.files.first;
                openFile(file);

                print('Name: ${file.name}');
                print('Bytes: ${file.bytes}');
                print('Size: ${file.size}');
                print('Extention: ${file.extension}');
                print('Path: ${file.path}');

                // final newFile = await saveFilePermanantly(file);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Future<File> saveFilePermanantly(PlatformFile file) async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final newFile = File('${appStorage.path}/${file.name}');
  //
  //   return File(file.path!).copy(newFile.path);
  // }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
}
