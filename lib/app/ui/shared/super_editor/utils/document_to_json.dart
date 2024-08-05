import 'dart:convert';

import 'package:super_editor/super_editor.dart';

/// Clase para convertir objetos [Document] de SuperEditor a JSON.
class DocumentToJson {
  // Constructor privado para evitar la creación de instancias de esta clase.
  DocumentToJson._();

  /// Convierte un [MutableDocument] a una cadena JSON.
  ///
  /// [document] es el documento mutable que se va a convertir.
  /// Retorna una cadena JSON que representa el documento.
  static String documentToJson(MutableDocument document) {
    final nodes = document.nodes.map(documentNodeToJson).toList();
    return jsonEncode(nodes);
  }

  /// Convierte un [DocumentNode] a un mapa JSON.
  ///
  /// [node] es el nodo del documento que se va a convertir.
  /// Retorna un mapa que representa el nodo en formato JSON.
  /// Lanza un [UnimplementedError] si el tipo de nodo no es compatible.
  static Map<String, dynamic> documentNodeToJson(DocumentNode node) {
    if (node is ParagraphNode) {
      return {
        'id': node.id,
        'type': "ParagraphNode",
        'text': attributedTextToJson(node.text),
        'metadata': metadataToJson(node.metadata),
      };
    } else if (node is ListItemNode) {
      return {
        'id': node.id,
        'type': "ListItemNode",
        'itemType': node.type.name,
        'text': attributedTextToJson(node.text),
        'metadata': metadataToJson(node.metadata),
      };
    } else if (node is TaskNode) {
      return {
        'id': node.id,
        'type': "TaskNode",
        'isComplete': node.isComplete,
        'beginningPosition': node.beginningPosition,
        'endPosition': node.endPosition,
        'indent': node.indent,
        'text': attributedTextToJson(node.text),
        'metadata': metadataToJson(node.metadata),
      };
    } else if (node is ImageNode) {
      return {
        'id': node.id,
        'type': "ImageNode",
        'imageUrl': node.imageUrl,
        'altText': node.altText,
        'beginningPosition': node.beginningPosition,
        'endPosition': node.endPosition,
        'expectedBitmapSize': node.expectedBitmapSize,
        'metadata': metadataToJson(node.metadata),
      };
    }
    throw UnimplementedError('Node type not supported');
  }

  /// Convierte un [AttributedText] a un mapa JSON.
  ///
  /// [text] es el texto atribuido que se va a convertir.
  /// Retorna un mapa que representa el texto atribuido en formato JSON.
  static Map<String, dynamic> attributedTextToJson(AttributedText text) {
    return {
      'text': text.text,
      'spans': text.spans.markers
          .map((marker) => {
                'attribution': namedAttributionToJson(
                    marker.attribution as NamedAttribution),
                'offset': marker.offset,
                'isStart': marker.isStart,
                'isEnd': marker.isEnd,
                'type': marker.markerType.toString(),
              })
          .toList(),
    };
  }

  /// Convierte una [NamedAttribution] a un mapa JSON.
  ///
  /// [attribution] es la atribución con nombre que se va a convertir.
  /// Retorna un mapa que representa la atribución en formato JSON.
  static Map<String, dynamic> namedAttributionToJson(
      NamedAttribution attribution) {
    return {
      'name': attribution.name,
      'id': attribution.id,
      'type': attribution.runtimeType.toString(),
    };
  }

  /// Convierte un mapa de [metadata] a un mapa JSON.
  ///
  /// [metadata] es el mapa de metadatos que se va a convertir.
  /// Retorna un mapa que representa los metadatos en formato JSON.
  /// Si [metadata] es `null`, retorna un mapa vacío.
  static Map<String, dynamic> metadataToJson(Map<String, dynamic>? metadata) {
    if (metadata == null) return {};
    return metadata.map((key, value) {
      if (value is NamedAttribution) {
        // Convierte NamedAttribution a una cadena u otro formato serializable.
        return MapEntry(
            key,
            value
                .name); // Asumiendo que `name` es una propiedad de NamedAttribution.
      }
      return MapEntry(key, value);
    });
  }
}
