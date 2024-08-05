import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/app/ui/shared/super_editor/_toolbar.dart';
import 'package:my_notes/app/ui/shared/super_editor/components/text_with_hint.dart';
import 'package:my_notes/logging.dart';
import 'package:super_editor/super_editor.dart';

class BuildSuperEditor extends StatefulWidget {
  const BuildSuperEditor({
    super.key,
    required this.docEditor,
    this.gestureMode,
    required this.doc,
    required this.composer,
  });

  final Editor docEditor;
  final DocumentGestureMode? gestureMode;
  final MutableDocument doc;
  final DocumentComposer composer;

  @override
  State<BuildSuperEditor> createState() => _BuildSuperEditorState();
}

class _BuildSuperEditorState extends State<BuildSuperEditor> {
  final GlobalKey _viewportKey = GlobalKey();
  final GlobalKey _docLayoutKey = GlobalKey();

  // final _darkBackground = const Color(0xFF222222);
  // final _lightBackground = Color.fromARGB(255, 7, 232, 86);
  // final _brightness = ValueNotifier<Brightness>(Brightness.dark);

  // SuperEditorDebugVisualsConfig? _debugConfig;

  // TODO: get rid of overlay controller once Android is refactored to use a control scope (as follow up to: https://github.com/superlistapp/super_editor/pull/1470)
  final _overlayController = MagnifierAndToolbarController() //
    ..screenPadding = const EdgeInsets.all(20.0);

  late final SuperEditorIosControlsController _iosControlsController;
  late CommonEditorOperations _docOps;
  final _docChangeSignal = SignalNotifier();

  final _textFormatBarOverlayController = OverlayPortalController();
  final _textSelectionAnchor = ValueNotifier<Offset?>(null);

  final _imageFormatBarOverlayController = OverlayPortalController();
  final _imageSelectionAnchor = ValueNotifier<Offset?>(null);

  final SelectionLayerLinks _selectionLayerLinks = SelectionLayerLinks();

  late ScrollController _scrollController;
  late FocusNode _editorFocusNode;

  late final MutableDocument _doc = widget.doc;
  late final DocumentComposer _composer = widget.composer;

  bool get _isMobile => _gestureMode != DocumentGestureMode.mouse;

  DocumentGestureMode get _gestureMode {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return DocumentGestureMode.android;
      case TargetPlatform.iOS:
        return DocumentGestureMode.iOS;
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return DocumentGestureMode.mouse;
    }
  }

  @override
  void initState() {
    _doc.addListener(_onDocumentChange);
    _composer.selectionNotifier.addListener(_hideOrShowToolbar);
    _docOps = CommonEditorOperations(
      editor: widget.docEditor,
      document: _doc,
      composer: _composer,
      documentLayoutResolver: () =>
          _docLayoutKey.currentState as DocumentLayout,
    );
    _iosControlsController = SuperEditorIosControlsController();
    _scrollController = ScrollController()..addListener(_hideOrShowToolbar);
    _editorFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _iosControlsController.dispose();
    _scrollController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  void _onDocumentChange(_) {
    _hideOrShowToolbar();
    _docChangeSignal.notifyListeners();
  }

  void _hideOrShowToolbar() {
    if (_gestureMode != DocumentGestureMode.mouse) {
      // We only add our own toolbar when using mouse. On mobile, a bar
      // is rendered for us.
      return;
    }

    final selection = _composer.selection;
    if (selection == null) {
      // Nothing is selected. We don't want to show a toolbar
      // in this case.
      _hideEditorToolbar();

      return;
    }
    if (selection.base.nodeId != selection.extent.nodeId) {
      // More than one node is selected. We don't want to show
      // a toolbar in this case.
      _hideEditorToolbar();
      _hideImageToolbar();

      return;
    }
    if (selection.isCollapsed) {
      // We only want to show the toolbar when a span of text
      // is selected. Therefore, we ignore collapsed selections.
      _hideEditorToolbar();
      _hideImageToolbar();

      return;
    }

    final selectedNode = _doc.getNodeById(selection.extent.nodeId);

    if (selectedNode is ImageNode) {
      appLog.fine("Showing image toolbar");
      // Show the editor's toolbar for image sizing.
      _showImageToolbar();
      _hideEditorToolbar();
      return;
    } else {
      // The currently selected content is not an image. We don't
      // want to show the image toolbar.
      _hideImageToolbar();
    }

    if (selectedNode is TextNode) {
      // Show the editor's toolbar for text styling.
      _showEditorToolbar();
      _hideImageToolbar();
      return;
    } else {
      // The currently selected content is not a paragraph. We don't
      // want to show a toolbar in this case.
      _hideEditorToolbar();
    }
  }

  void _showEditorToolbar() {
    _textFormatBarOverlayController.show();
    // Schedule a callback after this frame to locate the selection
    // bounds on the screen and display the toolbar near the selected
    // text.
    // TODO: switch this to use a Leader and Follower
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final docBoundingBox = (_docLayoutKey.currentState as DocumentLayout)
          .getRectForSelection(
              _composer.selection!.base, _composer.selection!.extent)!;
      final docBox =
          _docLayoutKey.currentContext!.findRenderObject() as RenderBox;
      final overlayBoundingBox = Rect.fromPoints(
        docBox.localToGlobal(docBoundingBox.topLeft),
        docBox.localToGlobal(docBoundingBox.bottomRight),
      );

      _textSelectionAnchor.value = overlayBoundingBox.topCenter;
    });
  }

  void _hideEditorToolbar() {
    // Null out the selection anchor so that when it re-appears,
    // the bar doesn't momentarily "flash" at its old anchor position.
    _textSelectionAnchor.value = null;

    _textFormatBarOverlayController.hide();

    // Ensure that focus returns to the editor.
    //
    // I tried explicitly unfocus()'ing the URL textfield
    // in the toolbar but it didn't return focus to the
    // editor. I'm not sure why.
    _editorFocusNode.requestFocus();
  }

  TextInputSource get _inputSource {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return TextInputSource.ime;
    }
  }

  void _showImageToolbar() {
    // Schedule a callback after this frame to locate the selection
    // bounds on the screen and display the toolbar near the selected
    // text.
    // TODO: switch to a Leader and Follower for this
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final docBoundingBox = (_docLayoutKey.currentState as DocumentLayout)
          .getRectForSelection(
              _composer.selection!.base, _composer.selection!.extent)!;
      final docBox =
          _docLayoutKey.currentContext!.findRenderObject() as RenderBox;
      final overlayBoundingBox = Rect.fromPoints(
        docBox.localToGlobal(docBoundingBox.topLeft),
        docBox.localToGlobal(docBoundingBox.bottomRight),
      );

      _imageSelectionAnchor.value = overlayBoundingBox.center;
    });

    _imageFormatBarOverlayController.show();
  }

  void _hideImageToolbar() {
    // Null out the selection anchor so that when the bar re-appears,
    // it doesn't momentarily "flash" at its old anchor position.
    _imageSelectionAnchor.value = null;

    _imageFormatBarOverlayController.hide();

    // Ensure that focus returns to the editor.
    _editorFocusNode.requestFocus();
  }

  // ---------------------------------------
  // ---------------------------------------

  void _cut() {
    _docOps.cut();
    // TODO: get rid of overlay controller once Android is refactored to use a control scope (as follow up to: https://github.com/superlistapp/super_editor/pull/1470)
    _overlayController.hideToolbar();
    _iosControlsController.hideToolbar();
  }

  void _copy() {
    _docOps.copy();
    // TODO: get rid of overlay controller once Android is refactored to use a control scope (as follow up to: https://github.com/superlistapp/super_editor/pull/1470)
    _overlayController.hideToolbar();
    _iosControlsController.hideToolbar();
  }

  void _paste() {
    _docOps.paste();
    // TODO: get rid of overlay controller once Android is refactored to use a control scope (as follow up to: https://github.com/superlistapp/super_editor/pull/1470)
    _overlayController.hideToolbar();
    _iosControlsController.hideToolbar();
  }

  void _selectAll() => _docOps.selectAll();

  @override
  Widget build(BuildContext context) {
    final isLight =
        Theme.of(context).colorScheme.brightness == Brightness.light;
    return Builder(builder: (context) {
      return OverlayPortal(
        controller: _textFormatBarOverlayController,
        overlayChildBuilder: _buildFloatingToolbar,
        child: OverlayPortal(
          controller: _imageFormatBarOverlayController,
          overlayChildBuilder: _buildImageToolbar,
          child: Column(
            children: [
              _builEditor(context, isLight),
              if (_isMobile) //
                _buildMountedToolbar(),
            ],
          ),
        ),
      );
    });
  }

  ClipRRect _builEditor(BuildContext context, bool isLight) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        // color: isLight ? _lightBackground : _darkBackground,
        color: Theme.of(context).cardColor.withOpacity(0.8),
        child: KeyedSubtree(
          key: _viewportKey,
          child: SuperEditorIosControlsScope(
            controller: _iosControlsController,
            child: SuperEditor(
              editor: widget.docEditor,
              focusNode: _editorFocusNode,
              scrollController: _scrollController,
              documentLayoutKey: _docLayoutKey,
              documentOverlayBuilders: [
                DefaultCaretOverlayBuilder(
                  caretStyle: const CaretStyle().copyWith(
                      color: isLight ? Colors.black : Colors.redAccent),
                ),
                if (defaultTargetPlatform == TargetPlatform.iOS) ...[
                  const SuperEditorIosHandlesDocumentLayerBuilder(),
                  const SuperEditorIosToolbarFocalPointDocumentLayerBuilder(),
                ],
                if (defaultTargetPlatform == TargetPlatform.android) ...[
                  const SuperEditorAndroidHandlesDocumentLayerBuilder(),
                  const SuperEditorAndroidToolbarFocalPointDocumentLayerBuilder(),
                ],
              ],
              selectionLayerLinks: _selectionLayerLinks,
              selectionStyle: isLight
                  ? defaultSelectionStyle
                  : SelectionStyles(
                      selectionColor: Colors.red.withOpacity(0.3),
                    ),
              stylesheet: defaultStylesheet.copyWith(
                addRulesAfter: [
                  if (!isLight) ..._darkModeStyles,
                  taskStyles,
                ],
              ),
              componentBuilders: [
                TaskComponentBuilder(widget.docEditor),
                HeaderWithHintComponentBuilder(context),
                ...defaultComponentBuilders,
              ],
              gestureMode: widget.gestureMode,
              inputSource: _inputSource,
              keyboardActions: _inputSource == TextInputSource.ime
                  ? defaultImeKeyboardActions
                  : defaultKeyboardActions,
              androidToolbarBuilder: (_) => _buildAndroidFloatingToolbar(),
              // overlayController: _overlayController,
              // plugins: {
              //   // MarkdownInlineUpstreamSyntaxPlugin(),
              // },
              document: _doc,
              composer: _composer,
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------------------
  // -------------------------------------
  // -------------------------------------

  Widget _buildAndroidFloatingToolbar() {
    return AndroidTextEditingFloatingToolbar(
      onCutPressed: _cut,
      onCopyPressed: _copy,
      onPastePressed: _paste,
      onSelectAllPressed: _selectAll,
    );
  }

  Widget _buildMountedToolbar() {
    return MultiListenableBuilder(
      listenables: <Listenable>{
        _docChangeSignal,
        _composer.selectionNotifier,
      },
      builder: (_) {
        final selection = _composer.selection;

        if (selection == null) {
          return const SizedBox();
        }

        return KeyboardEditingToolbar(
          editor: widget.docEditor,
          document: _doc,
          composer: _composer,
          commonOps: _docOps,
        );
      },
    );
  }

  Widget _buildFloatingToolbar(BuildContext context) {
    return EditorToolbar(
      editorViewportKey: _viewportKey,
      anchor: _selectionLayerLinks.expandedSelectionBoundsLink,
      editorFocusNode: _editorFocusNode,
      editor: widget.docEditor,
      document: _doc,
      composer: _composer,
      closeToolbar: _hideEditorToolbar,
    );
  }

  Widget _buildImageToolbar(BuildContext context) {
    return ImageFormatToolbar(
      anchor: _imageSelectionAnchor,
      composer: _composer,
      setWidth: (nodeId, width) {
        print("Applying width $width to node $nodeId");
        final node = _doc.getNodeById(nodeId)!;
        final currentStyles =
            SingleColumnLayoutComponentStyles.fromMetadata(node);

        widget.docEditor.execute([
          ChangeSingleColumnLayoutComponentStylesRequest(
            nodeId: nodeId,
            styles: SingleColumnLayoutComponentStyles(
              width: width,
              padding: currentStyles.padding,
            ),
          )
        ]);
      },
      closeToolbar: _hideImageToolbar,
    );
  }
}

// Makes text light, for use during dark mode styling.
final _darkModeStyles = [
  StyleRule(
    BlockSelector.all,
    (doc, docNode) {
      return {
        Styles.textStyle: const TextStyle(
          color: Color(0xFFCCCCCC),
        ),
      };
    },
  ),
  StyleRule(
    const BlockSelector("header1"),
    (doc, docNode) {
      return {
        Styles.textStyle: const TextStyle(
          color: Color(0xFF888888),
        ),
      };
    },
  ),
  StyleRule(
    const BlockSelector("header2"),
    (doc, docNode) {
      return {
        Styles.textStyle: const TextStyle(
          color: Color(0xFF888888),
        ),
      };
    },
  ),
];
