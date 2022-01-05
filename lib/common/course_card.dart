import 'package:coaching_system/common/toast_helper.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  CourseCard({
    required this.courseTitle,
    required this.courseSubtitle,
    required this.enrollTap,
  });

  Text courseTitle;
  Text courseSubtitle;
  final GestureTapCallback enrollTap;

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.book_outlined),
            title: widget.courseTitle,
            subtitle: widget.courseSubtitle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                  child: Text('ADD TO LIST'),
                  onPressed: () {
                    MyAlertDialog(context, "Added to list.");
                  }),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('ENROLL'),
                onPressed: widget.enrollTap,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
