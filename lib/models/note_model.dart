class Note {
  final int? id;
  final String text;
  final DateTime dateTime;

  Note({
    this.id,
    required this.text,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'created_at': dateTime.millisecondsSinceEpoch,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      text: map['text'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
    );
  }

  String formatDate() {
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return "$day.$month $hour:$minute";
  }
}