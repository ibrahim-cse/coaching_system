class LectureVideoModel {
  LectureVideoModel(this.contentPath);

  String contentPath = '';

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'contentPath': contentPath,
    };
    return map;
  }

  LectureVideoModel.fromMap(Map<String, dynamic> map) {
    contentPath = map['contentPath'];
  }
}
