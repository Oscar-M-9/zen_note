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
  bool favorite;

  @HiveField(7)
  Map<String, dynamic>? metadata;

  @HiveField(8)
  late String? documentJson;

  @HiveField(9)
  bool pinned;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.favorite = false,
    this.pinned = false,
    this.metadata,
    this.documentJson,
  });

  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? categoryId,
    bool? favorite,
    bool? pinned,
    Map<String, dynamic>? metadata,
    String? documentJson,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryId: categoryId ?? this.categoryId,
      favorite: favorite ?? this.favorite,
      pinned: pinned ?? this.pinned,
      metadata: metadata ?? this.metadata,
      documentJson: documentJson ?? this.documentJson,
    );
  }

  // factory Note.fromDocument({
  //   required String id,
  //   String? title,
  //   required MutableDocument document,
  //   DateTime? createdAt,
  //   DateTime? updatedAt,
  //   String? categoryId,
  //   String? folder,
  //   Map<String, dynamic>? metadata,
  // }) {
  //   // Serializa cada nodo a JSON y guárdalo en una lista
  //   final documentJsonNodes = jsonEncode({
  //     'nodes': document.nodes.map((node) => nodeToJson(node)).toList(),
  //   });

  //   return Note(
  //     id: id,
  //     title: title,
  //     content: document.toPlainText(),
  //     createdAt: createdAt,
  //     updatedAt: updatedAt,
  //     categoryId: categoryId,
  //     folder: folder,
  //     metadata: metadata,
  //     documentJsonNodes: [documentJsonNodes], // Lista de JSON
  //   );
  // }

  // MutableDocument toDocument() {
  //   final jsonData = jsonDecode(documentJsonNodes.first);
  //   final nodes = (jsonData['nodes'] as List)
  //       .map((jsonNode) => jsonToNode(jsonNode))
  //       .toList();
  //   return MutableDocument(nodes: nodes);
  // }

  // // Función para convertir un nodo a JSON
  // Map<String, dynamic> nodeToJson(DocumentNode node) {
  //   // Implementa aquí la lógica para convertir el nodo a un formato JSON
  //   // Puedes usar `node.toPlainText()` o definir una representación específica
  //   return {
  //     'type': node.runtimeType.toString(),
  //     'text': node.text.toPlainText(),
  //     // Agrega más campos según sea necesario
  //   };
  // }

  // // Función para convertir JSON a nodo
  // DocumentNode jsonToNode(Map<String, dynamic> jsonNode) {
  //   // Implementa aquí la lógica para reconstruir el nodo desde JSON
  //   // Puedes usar los datos almacenados en el JSON para crear el nodo
  //   return TextNode(jsonNode['text']);
  // }

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
