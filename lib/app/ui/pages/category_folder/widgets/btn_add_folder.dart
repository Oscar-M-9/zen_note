import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_notes/app/config/router/router_name.dart';
import 'package:my_notes/app/config/theme/colors_app.dart';
import 'package:my_notes/app/presenter/providers/category_state_provider.dart';
import 'package:my_notes/app/ui/pages/category_folder/utils/funtions_category.dart';
import 'package:my_notes/app/ui/shared/inputs/custom_input.dart';
import 'package:my_notes/generated/l10n.dart';

class BtnAddFolder extends ConsumerStatefulWidget {
  const BtnAddFolder({
    super.key,
    this.action,
  });
  final String? action;

  @override
  BtnAddFolderState createState() => BtnAddFolderState();
}

class BtnAddFolderState extends ConsumerState<BtnAddFolder> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: MaterialButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 5,
                      width: 30,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFEDEDED),
                      ),
                    ),
                    Text(
                      S.of(context).tNewFolder,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15)
                            .copyWith(top: 15),
                        child: Semantics(
                          child: TextFormField(
                            controller: nameController,
                            validator: (value) {
                              final exists = ref
                                  .read(categoryExistsByNameProvider(value!));
                              if (value.isEmpty) {
                                return S.of(context).tEnterAText;
                              } else if (exists) {
                                return S.of(context).tNameInUse;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            style: Theme.of(context).textTheme.titleMedium,
                            decoration: CustomInput.buildInputDecoration(
                              context,
                              hintText: S.of(context).tEnterText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    LayoutBuilder(builder: (context, constraints) {
                      final minWidthBtn = (constraints.maxWidth / 2) - 40;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: minWidthBtn,
                            child: MaterialButton(
                              onPressed: () {
                                context.router.maybePop();
                              },
                              elevation: 0,
                              highlightElevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              color: Colors.transparent,
                              child: FittedBox(
                                child: Text(
                                  S.of(context).tCancel,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: minWidthBtn,
                            child: MaterialButton(
                              onPressed: () {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }
                                final name = nameController.text;
                                final categoryId = ref
                                    .read(categoryProvider.notifier)
                                    .addCategory(
                                      name: name,
                                    );
                                nameController.clear();
                                if (widget.action == "move_to") {
                                  // crear la carpeta y poner las notas seleccionadas dentro
                                  ref.read(activeCategory.notifier).state =
                                      categoryId;
                                  updateCategoryOfSelectedNotes(
                                      ref, categoryId);
                                  context.router
                                      .popUntilRouteWithPath(RouteName.home);
                                } else {
                                  context.router.maybePop();
                                }
                              },
                              elevation: 0,
                              highlightElevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              color: ColorsApp.primary,
                              child: FittedBox(
                                child: Text(
                                  S.of(context).tAccept,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          );
        },
        color: Theme.of(context).cardColor,
        elevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipOval(
              child: Container(
                color: ColorsApp.primary,
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
            FittedBox(
              child: Text(
                S.of(context).tNewFolder,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
