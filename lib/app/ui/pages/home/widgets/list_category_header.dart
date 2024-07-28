import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_notes/app/config/theme/colors_app.dart';
import 'package:my_notes/app/presenter/providers/category_state_provider.dart';
import 'package:my_notes/app/ui/shared/glass_morphism.dart';
import 'package:my_notes/generated/l10n.dart';

class ListCategoryHeader extends ConsumerWidget {
  const ListCategoryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);
    final categoryActive = ref.watch(activeCategory);

    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 12),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(width: 10),
          CardHeaderCategory(
            color: ColorsApp.primary,
            category: S.of(context).tAll,
            isActive: categoryActive == "all",
            isIcon: false,
            onTap: () {
              if (categoryActive != "all") {
                ref.read(activeCategory.notifier).state = "all";
              }
            },
          ),
          CardHeaderCategory(
            color: Colors.grey,
            category: S.of(context).tWithoutCategory,
            isActive: categoryActive == "uncategorized",
            isIcon: false,
            onTap: () {
              if (categoryActive != "uncategorized") {
                ref.read(activeCategory.notifier).state = "uncategorized";
              }
            },
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,

            itemCount: categories.length,
            // padding: const EdgeInsets.symmetric(vertical: 12),
            itemBuilder: (BuildContext context, int index) {
              final color = Colors.primaries[index % Colors.primaries.length];
              final category = categories[index];
              return CardHeaderCategory(
                color: color,
                category: category.name,
                isActive: categoryActive == category.id,
                onTap: () {
                  if (categoryActive != category.id) {
                    ref.read(activeCategory.notifier).state = category.id;
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class CardHeaderCategory extends StatelessWidget {
  const CardHeaderCategory({
    super.key,
    required this.color,
    required this.category,
    this.isActive = false,
    this.onTap,
    this.isIcon = true,
  });

  final Color color;
  final String category;
  final bool isActive;
  final void Function()? onTap;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 5,
        left: 5,
      ),
      child: GlassMorphism(
        blur: 2,
        color: color,
        opacity: isActive ? 0.75 : 0.25,
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  if (isIcon)
                    Container(
                      width: 25,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SvgPicture.asset(
                        "assets/svg/folder-with-files.svg",
                        // ignore: deprecated_member_use
                        color: isActive ? Colors.white : color,
                      ),
                    ),
                  Text(
                    category,
                    style: Theme.of(context).textTheme.bodyMedium?.apply(
                          fontWeightDelta: isActive ? 2 : 0,
                          color: isActive ? Colors.white : null,
                          fontSizeFactor: 0.95,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
