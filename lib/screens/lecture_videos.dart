import 'package:coaching_system/screens/audio_recorder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class CourseContents extends StatefulWidget {
  const CourseContents({Key? key}) : super(key: key);

  @override
  _CourseContentsState createState() => _CourseContentsState();
}

class _CourseContentsState extends State<CourseContents> {
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
                    builder: (_) => Recorder(),
                  ));
            },
            child: const Icon(
              Icons.mic,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text('Course Contents'),
      ),
      body: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 400.0),
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              child: const Text('Add files'),
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

// class Lectures extends StatefulWidget {
//   @override
//   _LecturesState createState() => _LecturesState();
// }
//
// class _LecturesState extends State<Lectures> {
//   var videoURL;
//
//   Future choiceVideo() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       PlatformFile file = result.files.first;
//
//       print(file.name);
//       print(file.bytes);
//       print(file.size);
//       print(file.extension);
//       print(file.path);
//
//       setState(() {
//         videoURL = file.name;
//       });
//       print(videoURL);
//     } else {
//       // User canceled the picker
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Course Contents'),
//       ),
//       body: Column(
//         children: [
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 choiceVideo();
//               },
//               child: const Text('Add files'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
