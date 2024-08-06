class DiaryEntry {
  String date;
  String title;
  String content;
  String? imagePath;
  String? voiceNotePath;

  DiaryEntry({
    required this.date,
    required this.title,
    required this.content,
    this.imagePath,
    this.voiceNotePath,
  });
}
