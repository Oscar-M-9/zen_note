import 'package:hive/hive.dart';
// import 'package:uuid/uuid.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  late String? title;

  @HiveField(2)
  late String content;

  @HiveField(3)
  DateTime? createdAt;

  @HiveField(4)
  DateTime? updatedAt;

  @HiveField(5)
  String? categoryId;

  @HiveField(6)
  String? folder;

  @HiveField(7)
  Map<String, dynamic>? metadata;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.folder,
    this.metadata,
  });

  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? categoryId,
    String? folder,
    Map<String, dynamic>? metadata,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryId: categoryId ?? this.categoryId,
      folder: folder ?? this.folder,
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
