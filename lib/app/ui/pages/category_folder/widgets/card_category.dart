import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:my_notes/app/config/theme/colors_app.dart';
import 'package:my_notes/app/ui/shared/glass_morphism.dart';

import 'package:my_notes/app/presenter/providers/selected_category_provider.dart';

class CardCategory extends ConsumerWidget {
  const CardCategory({
    super.key,
    required this.title,
    required this.count,
    this.onTap,
    this.onLongPress,
    required this.item,
    this.selected = false,
    this.active = false,
  });
  final String title;
  final String count;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final int item;
  final bool selected;
  final bool active;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: ListTile(
              leading: Icon(
                Icons.check_rounded,
                color: active ? ColorsApp.primary : Colors.transparent,
                size: 20.0,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight:
                                active ? FontWeight.bold : FontWeight.normal,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (selectedCategory.isNotEmpty && item >= 0)
                    Align(
                      alignment: Alignment.centerRight,
                      child: selected
                          ? GlassMorphism(
                              blur: 2,
                              color: ColorsApp.primary,
                              opacity: 0.05,
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: SvgPicture.asset(
                                  "assets/svg/check-circle.svg",
                                  // ignore: deprecated_member_use
                                  color: ColorsApp.primary,
                                  width: 20,
                                ),
                              ),
                            )
                          : GlassMorphism(
                              blur: 2,
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color!,
                              opacity: 0.3,
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.all(2.0),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                    )
                ],
              ),
              trailing: Text(
                count,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
