import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_notes/app/ui/pages/add_note/_example_document.dart';
import 'package:my_notes/app/ui/shared/super_editor/build_editor.dart';
import 'package:my_notes/app/ui/shared/super_editor/utils/document_to_json.dart';
import 'package:my_notes/app/ui/shared/utils/show_alert_not_note.dart';

import 'package:my_notes/generated/l10n.dart';
import 'package:my_notes/app/config/router/router_name.dart';

import 'package:my_notes/app/presenter/providers/category_state_provider.dart';
import 'package:my_notes/app/presenter/providers/note_state_provider.dart';

import 'package:my_notes/app/ui/shared/custom_back_button.dart';
import 'package:my_notes/app/ui/shared/text_field_custom.dart';
import 'package:super_editor/super_editor.dart';

@RoutePage()
class AddNotePage extends ConsumerStatefulWidget {
  const AddNotePage({super.key});

  @override
  AddNotePageState createState() => AddNotePageState();
}

class AddNotePageState extends ConsumerState<AddNotePage> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  // final contentController = TextEditingController();
  final titleFocusNode = FocusNode();

  late MutableDocument _doc;

  late MutableDocumentComposer _composer;
  late Editor _docEditor;

  @override
  void initState() {
    super.initState();
    _doc = createInitialDocument();
    _composer = MutableDocumentComposer();
    _docEditor =
        createDefaultDocumentEditor(document: _doc, composer: _composer);
  }

  @override
  void dispose() {
    titleController.dispose();
    // contentController.dispose();
    titleFocusNode.dispose();
    _composer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardDismissOnTap(
        child: ScrollingMinimaps(
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      leading: const CustomBackButton(),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Semantics(
                            label: S.of(context).tSaveNoteButton,
                            excludeSemantics: true,
                            focusable: true,
                            child: IconButton(
                              onPressed: () {
                                if (!formKey.currentState!.validate()) {
                                  if (!formKey.currentState!
                                      .validateField(titleController.text)) {
                                    FocusScope.of(context)
                                        .requestFocus(titleFocusNode);
                                  }
                                  return;
                                }
                                String? categoryId = ref.read(activeCategory);
                                if (categoryId == "all") {
                                  categoryId = "uncategorized";
                                }

                                try {
                                  // Extraer el contenido de SuperEditor
                                  String content = _doc.nodes.map((node) {
                                    if (node is ParagraphNode) {
                                      return node.text.text;
                                    } else if (node is ListItemNode) {
                                      return node.text.text;
                                    } else if (node is TaskNode) {
                                      return node.text.text;
                                    } else if (node is ImageNode) {
                                      return node.altText;
                                    }
                                    return '';
                                  }).join('\n');

                                  if (content.trim().isEmpty) {
                                    showAlertNotNote(context);
                                    return;
                                  }
                                  // Convertir el documento a JSON
                                  String documentJson =
                                      DocumentToJson.documentToJson(_doc);

                                  // Aquí puedes guardar el documento en Hive
                                  // Asegúrate de que NoteModel tenga el campo para el documento JSON

                                  // Aquí descomenta la línea para guardar la nota
                                  ref.read(noteProvider.notifier).addNote(
                                        title: titleController.text,
                                        content: content,
                                        categoryId: categoryId,
                                        documentJson: documentJson,
                                      );

                                  // Limpia los controladores después de guardar
                                  titleController.clear();
                                  // contentController.clear();
                                  context.router
                                      .popUntilRouteWithPath(RouteName.home);
                                } catch (e) {
                                  // Manejo de errores
                                  print("Error al guardar la nota: $e");
                                }
                              },
                              icon: SvgPicture.asset(
                                "assets/svg/save.svg",
                                // ignore: deprecated_member_use
                                color: Theme.of(context)
                                    .appBarTheme
                                    .iconTheme
                                    ?.color,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10)
                            .copyWith(top: 10),
                        child: Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            children: [
                              TextFieldCustom(
                                fontSize: 24,
                                hintText: S.of(context).tTitle,
                                fontWeight: FontWeight.w500,
                                keyboardType: TextInputType.text,
                                onChanged: (value) =>
                                    titleController.text = value,
                                validator: (value) {
                                  return (value!.isEmpty)
                                      ? S.of(context).tAddATitle
                                      : null;
                                },
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.color,
                                focusNode: titleFocusNode,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 12,
                        left: 10,
                        right: 10,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: BuildSuperEditor(
                          composer: _composer,
                          doc: _doc,
                          docEditor: _docEditor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on FormState {
  bool validateField(String value) {
    return validate();
  }
}
