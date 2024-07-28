import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_notes/app/infra/models/category_model.dart';
import 'package:my_notes/app/presenter/providers/category_state_provider.dart';
import 'package:my_notes/app/presenter/providers/note_state_provider.dart';
import 'package:my_notes/app/presenter/providers/selected_category_provider.dart';
import 'package:my_notes/app/ui/pages/category_folder/utils/funtions_category.dart';

import 'package:my_notes/app/ui/pages/category_folder/widgets/btn_add_folder.dart';
import 'package:my_notes/app/ui/pages/category_folder/widgets/card_category.dart';
import 'package:my_notes/app/ui/shared/custom_back_button.dart';
import 'package:my_notes/generated/l10n.dart';

@RoutePage()
class MoveToNotePage extends ConsumerStatefulWidget {
  const MoveToNotePage({super.key});

  @override
  CategoryFolderPageState createState() => CategoryFolderPageState();
}

class CategoryFolderPageState extends ConsumerState<MoveToNotePage> {
  final nameController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);

    final selectedCategory = ref.watch(selectedCategoryProvider);

    final categoryActive = ref.watch(activeCategory);
    final notesByCategory = ref.watch(notesByCategoryProvider);
    final noteCountUncategorized = notesByCategory["uncategorized"] ?? 0;

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(S.of(context).tSelectFolder),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          CardCategory(
            count: noteCountUncategorized.toString(),
            title: S.of(context).tWithoutCategory,
            item: 1,
            active: categoryActive == "uncategorized",
            onTap: () {
              if (categoryActive != "uncategorized") {
                ref.read(activeCategory.notifier).state = "uncategorized";
                updateCategoryOfSelectedNotes(ref, "uncategorized");
                context.router.maybePop();
              }
            },
          ),
          _ListCategory(
            categories: categories,
            selectedCategory: selectedCategory,
          ),
          const BtnAddFolder(
            action: "move_to",
          ),
        ],
      ),
    );
  }
}

class _ListCategory extends ConsumerWidget {
  const _ListCategory({
    required this.categories,
    required this.selectedCategory,
  });

  final List<Category> categories;
  final Set<Category> selectedCategory;

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
            if (categoryActive != category.id) {
              ref.read(activeCategory.notifier).state = category.id;
            }
            updateCategoryOfSelectedNotes(ref, category.id);
            context.router.maybePop();
          },
        );
      },
    );
  }
}
