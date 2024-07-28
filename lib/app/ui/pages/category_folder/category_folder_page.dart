import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_notes/app/config/theme/colors_app.dart';
import 'package:my_notes/app/infra/models/category_model.dart';
import 'package:my_notes/app/presenter/providers/category_state_provider.dart';
import 'package:my_notes/app/presenter/providers/note_state_provider.dart';
import 'package:my_notes/app/presenter/providers/selected_category_provider.dart';

import 'package:my_notes/app/ui/pages/category_folder/widgets/btn_add_folder.dart';
import 'package:my_notes/app/ui/pages/category_folder/widgets/card_category.dart';
import 'package:my_notes/app/ui/shared/custom_back_button.dart';
import 'package:my_notes/app/ui/shared/inputs/custom_input.dart';
import 'package:my_notes/generated/l10n.dart';

@RoutePage()
class CategoryFolderPage extends ConsumerStatefulWidget {
  const CategoryFolderPage({super.key});

  @override
  CategoryFolderPageState createState() => CategoryFolderPageState();
}

class CategoryFolderPageState extends ConsumerState<CategoryFolderPage> {
  final nameController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notesLengthAll = ref.watch(noteLengthProvider);
    final categories = ref.watch(categoryProvider);

    final selectedCategory = ref.watch(selectedCategoryProvider);

    final formKey = GlobalKey<FormState>();
    final minWidthBtn = (MediaQuery.of(context).size.width / 2) - 40;

    final categoryActive = ref.watch(activeCategory);
    final notesByCategory = ref.watch(notesByCategoryProvider);
    final noteCountUncategorized = notesByCategory["uncategorized"] ?? 0;

    // Calcular la cantidad de notas a eliminar
    final notesToDelete = calculateNotesToDelete(
      selectedCategory.map((category) => category.id).toList(),
      notesByCategory,
    );

    final countCategoryNotesToDelete = notesToDelete + selectedCategory.length;
    final countElement = countCategoryNotesToDelete > 1 ? "s" : '';

    final List<Map<String, dynamic>> bottomNav = [
      if (selectedCategory.length == 1)
        {
          "name": S.of(context).tEdit,
          "icon": "assets/svg/edit-2.svg",
          "onTap": () {
            nameController.text = selectedCategory.first.name;
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
                        S.of(context).tRenameFolder,
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
                      Row(
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
                                ref
                                    .read(categoryProvider.notifier)
                                    .updateCategoryById(
                                      id: selectedCategory.first.id,
                                      name: name,
                                    );
                                nameController.clear();
                                ref
                                    .read(selectedCategoryProvider.notifier)
                                    .clear();
                                context.router.maybePop();
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
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            );
          }
        },
      {
        "name": S.of(context).tRemove,
        "icon": "assets/svg/trash.svg",
        "onTap": () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  S.of(context).tRemove,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              content: Text(
                "${S.of(context).tRemove} ${countCategoryNotesToDelete.toString()} ${S.of(context).tSelectedItem(countElement)} ",
                textAlign: TextAlign.center,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: Text(S.of(context).tCancel),
                      onPressed: () {
                        context.router.maybePop();
                      },
                    ),
                    MaterialButton(
                      onPressed: () {
                        // Obtener las IDs de las categorías seleccionadas
                        final selectedCategoryIds =
                            selectedCategory.map((category) {
                          if (categoryActive == category.id) {
                            ref.read(activeCategory.notifier).state = "all";
                          }
                          return category.id;
                        }).toList();
                        // Eliminar las categorías seleccionadas
                        ref
                            .read(categoryProvider.notifier)
                            .deleteCategories(selectedCategory);
                        // Eliminar las notas que pertenecen a las categorías seleccionadas
                        ref
                            .read(noteProvider.notifier)
                            .deleteNotesByCategory(selectedCategoryIds);
                        // Limpiar las categorías seleccionadas
                        ref.read(selectedCategoryProvider.notifier).clear();
                        // Cerrar el diálogo
                        context.router.maybePop();
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
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: selectedCategory.isEmpty
            ? const CustomBackButton()
            : Focus(
                child: Semantics(
                  label: S.of(context).tCancelButton,
                  excludeSemantics: true,
                  focusable: true,
                  child: IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: Theme.of(context).appBarTheme.iconTheme?.color,
                    ),
                    onPressed: () {
                      ref.read(selectedCategoryProvider.notifier).clear();
                    },
                  ),
                ),
              ),
        title: selectedCategory.isEmpty
            ? Text(S.of(context).tFolders)
            : Text(
                '${selectedCategory.length} ${S.of(context).tSelectedItem(countElement)} ',
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          CardCategory(
            count: notesLengthAll.toString(),
            title: S.of(context).tAll,
            item: -1,
            active: categoryActive == "all",
            onTap: () {
              if (selectedCategory.isEmpty) {
                if (categoryActive != "all") {
                  ref.read(activeCategory.notifier).state = "all";
                  context.router.maybePop();
                }
              }
            },
          ),
          CardCategory(
            count: noteCountUncategorized.toString(),
            title: S.of(context).tWithoutCategory,
            item: -1,
            active: categoryActive == "uncategorized",
            onTap: () {
              if (selectedCategory.isEmpty) {
                if (categoryActive != "uncategorized") {
                  ref.read(activeCategory.notifier).state = "uncategorized";
                  context.router.maybePop();
                }
              }
            },
          ),
          _ListCategory(
            categories: categories,
            selectedCategory: selectedCategory,
            onSelectionChanged: (category) {
              ref.read(selectedCategoryProvider.notifier).toggle(category);
            },
          ),
          if (selectedCategory.isEmpty)
            const BtnAddFolder(
              action: null,
            ),
        ],
      ),
      bottomNavigationBar: selectedCategory.isEmpty
          ? null
          : LayoutBuilder(builder: (context, constraints) {
              return Row(
                children: [
                  ...bottomNav.map((item) {
                    return InkWell(
                      onTap: item["onTap"],
                      child: Container(
                        height: 75,
                        width: constraints.maxWidth / bottomNav.length,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor,
                          border: const Border(
                            top: BorderSide(
                              color: Color(0x9C878787),
                            ),
                          ),
                        ),
                        child: Container(
                          // color: Colors.pink,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 1,
                            vertical: 5,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                item["icon"],
                                // ignore: deprecated_member_use
                                color: Theme.of(context)
                                    .appBarTheme
                                    .iconTheme
                                    ?.color,
                                width: 25,
                              ),
                              FittedBox(
                                child: Text(
                                  item["name"],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              );
            }),
    );
  }
}

class _ListCategory extends ConsumerWidget {
  const _ListCategory({
    required this.categories,
    required this.selectedCategory,
    required this.onSelectionChanged,
  });

  final List<Category> categories;
  final Set<Category> selectedCategory;
  final Function(Category) onSelectionChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryActive = ref.watch(activeCategory);
    final notesByCategory = ref.watch(notesByCategoryProvider);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        final category = categories[index];
        final noteCount = notesByCategory[category.id] ?? 0;
        return CardCategory(
          count: noteCount.toString(),
          title: category.name,
          item: index,
          selected: selectedCategory.contains(category),
          active: categoryActive == category.id,
          onTap: () {
            if (selectedCategory.isNotEmpty) {
              onSelectionChanged(category);
            } else {
              if (categoryActive != category.id) {
                ref.read(activeCategory.notifier).state = category.id;
              }
              context.router.maybePop();
            }
          },
          onLongPress: () {
            onSelectionChanged(category);
          },
        );
      },
    );
  }
}

int calculateNotesToDelete(
    List<String> selectedCategoryIds, Map<String, int> notesByCategory) {
  int totalNotesToDelete = 0;

  for (String categoryId in selectedCategoryIds) {
    totalNotesToDelete += notesByCategory[categoryId] ?? 0;
  }

  return totalNotesToDelete;
}
