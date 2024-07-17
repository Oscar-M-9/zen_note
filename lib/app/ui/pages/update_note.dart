import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:my_notes/app/config/router/router_name.dart';
import 'package:my_notes/app/config/theme/colors_app.dart';
import 'package:my_notes/app/infra/models/note_model.dart';

import 'package:my_notes/app/presenter/providers/note_state_provider.dart';
import 'package:my_notes/app/ui/shared/custom_back_button.dart';
import 'package:my_notes/app/ui/shared/glass_morphism.dart';
import 'package:my_notes/app/ui/shared/text_field_custom.dart';
import 'package:my_notes/generated/l10n.dart';

@RoutePage()
class UpdateNotePage extends ConsumerStatefulWidget {
  final Note note;
  const UpdateNotePage({
    super.key,
    required this.note,
  });

  @override
  UpdateNotePageState createState() => UpdateNotePageState();
}

class UpdateNotePageState extends ConsumerState<UpdateNotePage> {
  late final TextEditingController titleController;
  late final TextEditingController contentController;
  late final FocusNode titleFocusNode;
  late final FocusNode contentFocusNode;
  bool showSaveButton = false;
  bool showUpdatedMessage = false;
  bool isNoteDiferent = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.content);
    titleFocusNode = FocusNode();
    contentFocusNode = FocusNode();
  }

  void _unfocusFields() {
    titleFocusNode.unfocus();
    contentFocusNode.unfocus();
    FocusScope.of(context).unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          showSaveButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    titleFocusNode.dispose();
    contentFocusNode.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final noteById = ref.watch(noteByIdProvider(widget.note.id));
    if (noteById?.title == titleController.text &&
        noteById?.content == contentController.text) {
      setState(() {
        isNoteDiferent = false;
      });
    } else {
      setState(() {
        isNoteDiferent = true;
      });
      ref.read(noteProvider.notifier).updateNoteById(
            id: widget.note.id,
            title: titleController.text,
            content: contentController.text,
          );
    }

    _unfocusFields();
    setState(() {
      showUpdatedMessage = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showUpdatedMessage = false;
        });
      }
    });
    // context.router.popUntilRouteWithPath(RouteName.home);
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = "";
    if (widget.note.updatedAt != null) {
      formattedDate =
          DateFormat('dd MMM yyyy HH:mm').format(widget.note.updatedAt!);
    } else {
      formattedDate =
          DateFormat('dd MMM yyyy HH:mm').format(widget.note.createdAt!);
    }

    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isKeyboardVisible && !titleFocusNode.hasFocus) {
        // _unfocusFields();
      }
    });

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          actions: [
            // if (isKeyboardVisible)
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                onPressed: _saveNote,
                icon: SvgPicture.asset(
                  "assets/svg/save.svg",
                  // ignore: deprecated_member_use
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _showDialogDeleteNote(context);
              },
              icon: SvgPicture.asset(
                "assets/svg/delete-note.svg",
                // ignore: deprecated_member_use
                color: Theme.of(context).appBarTheme.iconTheme?.color,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10)
                      .copyWith(top: 10),
                  child: Column(
                    children: [
                      TextFieldCustom(
                        fontSize: 24,
                        hintText: 'Titulo',
                        fontWeight: FontWeight.w500,
                        keyboardType: TextInputType.text,
                        controller: titleController,
                        focusNode: titleFocusNode,
                        validator: (value) {
                          return (value!.isEmpty) ? 'Agrege un titulo' : null;
                        },
                        color: Theme.of(context).textTheme.titleMedium?.color,
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          formattedDate,
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFieldCustom(
                        fontSize: 16,
                        hintText: 'Empiece a escribir',
                        keyboardType: TextInputType.multiline,
                        controller: contentController,
                        focusNode: contentFocusNode,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        validator: (value) {
                          return (value!.isEmpty) ? 'Escriba una nota' : null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (showUpdatedMessage)
              Animate(
                effects: const [MoveEffect()],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 130,
                      height: 40,
                      child: GlassMorphism(
                        blur: 10,
                        opacity: 0.4,
                        color: isNoteDiferent
                            ? Colors.greenAccent
                            : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isNoteDiferent
                                    ? Icons.check_rounded
                                    : Icons.info_outline_rounded,
                                size: 15,
                                color: Theme.of(context)
                                    .appBarTheme
                                    .iconTheme
                                    ?.color,
                              ),
                              const SizedBox(
                                width: 2.5,
                              ),
                              Flexible(
                                child: FittedBox(
                                  child: Text(
                                    isNoteDiferent
                                        ? S.of(context).tItHasUpdated
                                        : S.of(context).tNothingToSave,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      // color: Colors.red,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showDialogDeleteNote(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            S.of(context).tDeleteNote,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        content: Text(
          S.of(context).tDeleteThisNote,
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: Text(S.of(context).tCancel),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.router.popUntilRouteWithPath(RouteName.updateNote);
                },
              ),
              MaterialButton(
                onPressed: () {
                  ref
                      .read(noteProvider.notifier)
                      .deleteNoteById(widget.note.id);
                  context.router.popUntilRouteWithPath(RouteName.home);
                },
                elevation: 0,
                highlightElevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(10.0),
                color: ColorsApp.primary,
                child: Text(S.of(context).tRemove),
              ),
            ],
          )
        ],
      ),
    );
  }
}
