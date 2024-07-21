import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:my_notes/app/config/router/router_name.dart';
import 'package:my_notes/app/presenter/providers/note_state_provider.dart';
import 'package:my_notes/app/ui/shared/custom_back_button.dart';
import 'package:my_notes/app/ui/shared/text_field_custom.dart';
import 'package:my_notes/generated/l10n.dart';

@RoutePage()
class AddNotePage extends ConsumerWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
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
                    return;
                  }
                  ref.read(noteProvider.notifier).addNote(
                        title: titleController.text,
                        content: contentController.text,
                      );
                  titleController.clear();
                  contentController.clear();
                  context.router.popUntilRouteWithPath(RouteName.home);
                },
                icon: SvgPicture.asset(
                  "assets/svg/save.svg",
                  // ignore: deprecated_member_use
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
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
                  onChanged: (value) => titleController.text = value,
                  validator: (value) {
                    return (value!.isEmpty) ? S.of(context).tAddATitle : null;
                  },
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
                TextFieldCustom(
                  fontSize: 16,
                  hintText: S.of(context).tStartwriting,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) => contentController.text = value,
                  validator: (value) {
                    return (value!.isEmpty) ? 'Escriba una nota' : null;
                  },
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
