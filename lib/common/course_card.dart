import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  CourseCard({
    required this.courseTitle,
    required this.courseSubtitle,
    // required this.add2list,
    // required this.enrolled,
  });

  Text courseTitle;
  Text courseSubtitle;
  // String add2list;
  // String enrolled;

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
            leading: Icon(Icons.book_outlined),
            title: widget.courseTitle,
            subtitle: widget.courseSubtitle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                // child: Text(widget.add2list),
                child: Text('ADD TO LIST'),
                onPressed: () {
                  // widget.add2list = 'ADDED TO LIST';
                },
              ),
              const SizedBox(width: 8),
              TextButton(
                child: Text('ENROLL'),
                onPressed: () {
                  // widget.add2list = 'ADDED TO LIST';
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
