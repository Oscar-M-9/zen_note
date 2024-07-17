import 'package:hive/hive.dart';
// import 'package:uuid/uuid.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String content;

  @HiveField(3)
  late DateTime? createdAt;

  @HiveField(4)
  late DateTime? updatedAt;

  @HiveField(5)
  late String? category;

  @HiveField(6)
  late String? file;

  @HiveField(7)
  late Map<String, dynamic>? metadata;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.file,
    this.metadata,
  });

  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    String? file,
    Map<String, dynamic>? metadata,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      file: file ?? this.file,
      metadata: metadata ?? this.metadata,
    );
  }

  // factory Note.create(
  //     String title, String content, Map<String, dynamic>? metadata) {
  //   var uuid = const Uuid();
  //   return Note(
  //     id: uuid.v4(),
  //     title: title,
  //     content: content,
  //     createdAt: DateTime.now(),
  //     updatedAt: null,
  //     metadata: metadata,
  //   );
  // }
}
