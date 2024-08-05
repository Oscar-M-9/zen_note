import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';
import 'package:my_notes/generated/l10n.dart';

/// SuperEditor [ComponentBuilder] that builds a component for Header 1, Header 2,
/// and Header 3 `ParagraphNode`s, displays "header goes here..." when the content
/// text is empty.
///
/// [ComponentBuilder]s operate at the document level, which means that they can
/// make decisions based on global document structure. Therefore, if you'd like
/// to limit hint text to the very first header in a document, or the first header
/// and paragraph, you can make that decision at the beginning of your
/// [ComponentBuilder]:
///
/// ```
/// final nodeIndex = componentContext.document.getNodeIndex(
///   componentContext.documentNode,
/// );
///
/// if (nodeIndex > 0) {
///   // This isn't the first node, we don't ever want to show hint text.
///   return null;
/// }
/// ```
class HeaderWithHintComponentBuilder implements ComponentBuilder {
  final BuildContext context;

  const HeaderWithHintComponentBuilder(this.context);

  @override
  SingleColumnLayoutComponentViewModel? createViewModel(
      Document document, DocumentNode node) {
    // This component builder can work with the standard paragraph view model.
    // We'll defer to the standard paragraph component builder to create it.
    return null;
  }

  @override
  Widget? createComponent(SingleColumnDocumentComponentContext componentContext,
      SingleColumnLayoutComponentViewModel componentViewModel) {
    if (componentViewModel is! ParagraphComponentViewModel) {
      return null;
    }

    final blockAttribution = componentViewModel.blockType;
    if (!(const [
      header1Attribution,
      header2Attribution,
      header3Attribution,
      paragraphAttribution,
    ]).contains(blockAttribution)) {
      return null;
    }

    final textSelection = componentViewModel.selection;

    return TextWithHintComponent(
      key: componentContext.componentKey,
      text: componentViewModel.text,
      textStyleBuilder: (attributions) =>
          _textStyleBuilder(context, attributions),
      metadata: componentViewModel.blockType != null
          ? {
              'blockType': componentViewModel.blockType,
            }
          : {},
      // This is the text displayed as a hint.
      hintText: AttributedText(
        S.of(context).tEnterText,
        AttributedSpans(
          attributions: [
            const SpanMarker(
                attribution: italicsAttribution,
                offset: 12,
                markerType: SpanMarkerType.start),
            const SpanMarker(
                attribution: italicsAttribution,
                offset: 15,
                markerType: SpanMarkerType.end),
          ],
        ),
      ),
      // This is the function that selects styles for the hint text.
      hintStyleBuilder: (Set<Attribution> attributions) =>
          _textStyleBuilder(context, attributions).copyWith(
        color: const Color(0xFFDDDDDD),
      ),
      textSelection: textSelection,
      selectionColor: componentViewModel.selectionColor,
      composingRegion: componentViewModel.composingRegion,
      showComposingUnderline: componentViewModel.showComposingUnderline,
    );
  }
}

/// Styles to apply to all the text in the editor.
TextStyle _textStyleBuilder(
  BuildContext context,
  Set<Attribution> attributions,
) {
  // We only care about altering a few styles. Start by getting
  // the standard styles for these attributions.
  var newStyle = defaultStyleBuilder(attributions);
  final textTheme = Theme.of(context).textTheme;

  // Style headers
  for (final attribution in attributions) {
    if (attribution == header1Attribution) {
      newStyle = newStyle.copyWith(
        color: textTheme.headlineLarge?.color,
        fontFamily: "Chewy",
        fontSize: 48,
        fontWeight: FontWeight.bold,
      );
    } else if (attribution == header2Attribution) {
      newStyle = newStyle.copyWith(
        // color: const Color(0xFF444444),
        color: textTheme.headlineMedium?.color,
        fontFamily: "Poppins",
        fontSize: 30,
        fontWeight: FontWeight.bold,
      );
    } else if (attribution == header3Attribution) {
      newStyle = newStyle.copyWith(
        color: textTheme.headlineSmall?.color,
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
    } else if (attribution == paragraphAttribution) {
      newStyle = newStyle.copyWith(
        fontFamily: "Lato",
        color: textTheme.bodyMedium?.color,
        fontSize: 16,
        // fontWeight: FontWeight.bold,
      );
    }
  }

  return newStyle;
}
