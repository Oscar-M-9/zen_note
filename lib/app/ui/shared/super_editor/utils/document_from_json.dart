import 'dart:convert';
import 'dart:ui';
import 'package:super_editor/super_editor.dart';

/// Clase para convertir datos JSON en objetos de tipo [Document] de SuperEditor.
class DocumentFromJson {
  /// Convierte un JSON a un [DocumentNode].
  ///
  /// [json] es un mapa que contiene los datos del nodo en formato JSON.
  /// Retorna un [DocumentNode] correspondiente al tipo especificado en el JSON.
  /// Lanza un [UnimplementedError] si el tipo de nodo no es compatible.
  static DocumentNode documentNodeFromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'ParagraphNode':
        return ParagraphNode(
          id: json['id'],
          text: attributedTextFromJson(json['text']),
          metadata: metadataFromJson(json['metadata']),
        );
      case 'ListItemNode':
        return ListItemNode(
          id: json['id'],
          itemType: json['itemType'] == 'unordered'
              ? ListItemType.unordered
              : ListItemType.ordered,
          text: attributedTextFromJson(json['text']),
          metadata: metadataFromJson(json['metadata']),
        );
      case 'TaskNode':
        return TaskNode(
          id: json['id'],
          isComplete: json['isComplete'],
          indent: json["indent"],
          text: attributedTextFromJson(json['text']),
          metadata: metadataFromJson(json['metadata']),
        );
      case 'ImageNode':
        return ImageNode(
          id: json['id'],
          imageUrl: json['imageUrl'],
          expectedBitmapSize: json["expectedBitmapSize"],
          altText: json['altText'],
          metadata: metadataFromJson(json['metadata']),
        );
      default:
        throw UnimplementedError('Node type not supported');
    }
  }

  /// Convierte un JSON a un mapa de metadatos.
  ///
  /// [json] es un mapa que contiene los datos de metadatos en formato JSON.
  /// Retorna un mapa de tipo [Map<String, Attribution?>].
  static Map<String, Attribution?> metadataFromJson(Map<String, dynamic> json) {
    return json.map((key, value) {
      if (value is String) {
        return MapEntry(key, NamedAttribution(value));
      } else if (value is Map<String, dynamic>) {
        return MapEntry(key, jsonToAttribution(value));
      } else {
        return MapEntry(key, value as Attribution?);
      }
    });
  }

  /// Convierte un JSON a un [NamedAttribution].
  ///
  /// [json] es un mapa que contiene los datos de la atribución en formato JSON.
  /// Retorna un objeto de tipo [NamedAttribution].
  static NamedAttribution namedAttributionFromJson(Map<String, dynamic> json) {
    return NamedAttribution(json['id']);
  }

  /// Convierte un JSON a un objeto [Attribution].
  ///
  /// [json] es un mapa que contiene los datos de la atribución en formato JSON.
  /// Retorna un objeto de tipo [Attribution].
  /// Lanza un [UnimplementedError] si el tipo de atribución no es compatible.
  static Attribution jsonToAttribution(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'NamedAttribution':
        return NamedAttribution(json['id']);
      case 'ColorAttribution':
        return ColorAttribution(Color(json['color']));
      case 'BackgroundColorAttribution':
        return BackgroundColorAttribution(Color(json['color']));
      case 'FontSizeAttribution':
        return FontSizeAttribution(json['size']);
      case 'FontFamilyAttribution':
        return FontFamilyAttribution(json['family']);
      case 'LinkAttribution':
        return LinkAttribution(Uri.parse(json['uri']) as String);
      default:
        throw UnimplementedError('Attribution type not supported');
    }
  }

  /// Convierte un JSON a un [AttributedText].
  ///
  /// [json] es un mapa que contiene los datos del texto atribuido en formato JSON.
  /// Retorna un objeto de tipo [AttributedText].
  static AttributedText attributedTextFromJson(Map<String, dynamic> json) {
    final List<SpanMarker> spans =
        (json['spans'] as List<dynamic>).map<SpanMarker>((span) {
      return SpanMarker(
        attribution: jsonToAttribution(span['attribution']),
        offset: span['offset'],
        markerType: span['type'] == 'SpanMarkerType.start'
            ? SpanMarkerType.start
            : SpanMarkerType.end,
      );
    }).toList();
    return AttributedText(
      json['text'],
      AttributedSpans(attributions: spans),
    );
  }

  /// Convierte un JSON a un [MutableDocument].
  ///
  /// [jsonString] es una cadena que contiene los datos del documento en formato JSON.
  /// Retorna un objeto de tipo [MutableDocument] con los nodos convertidos del JSON.
  /// Si [jsonString] es null, retorna un [MutableDocument] con un nodo de párrafo vacío.
  static MutableDocument documentFromJson(String? jsonString) {
    if (jsonString != null) {
      final List<dynamic> nodesJson = jsonDecode(jsonString);
      final nodes =
          nodesJson.map((json) => documentNodeFromJson(json)).toList();
      return MutableDocument(nodes: nodes);
    } else {
      return MutableDocument(
        nodes: [
          ParagraphNode(
            id: Editor.createNodeId(),
            text: AttributedText(),
            metadata: {'blockType': paragraphAttribution},
          ),
        ],
      );
    }
  }
}
