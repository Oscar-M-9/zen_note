import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_notes/app/config/theme/colors_app.dart';
import 'package:my_notes/app/config/utils/date_util.dart';
import 'package:my_notes/app/infra/models/note_model.dart';
import 'package:my_notes/app/presenter/providers/selected_note_provider.dart';
import 'package:my_notes/app/ui/shared/glass_morphism.dart';
import 'package:my_notes/generated/l10n.dart';

class CardNote extends ConsumerWidget {
  const CardNote({
    super.key,
    this.onTap,
    this.selected = false,
    required this.item,
    required this.note,
    this.onLongPress,
  }) : assert(item >= 0);

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final int item;
  final bool selected;

  final Note note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final color = Colors.primaries[item % Colors.primaries.length];
    final selectedNotes = ref.watch(selectedNotesProvider);
    final formattedDate = formatNoteDate(note.updatedAt, note.createdAt!);

    return Padding(
      padding: const EdgeInsets.only(
        left: 2.0,
        right: 2.0,
        top: 10.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GlassMorphism(
          blur: 10,
          color: Theme.of(context).cardColor,
          opacity: selected ? 1.0 : 0.8,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              onLongPress: onLongPress,
              child: Stack(
                children: [
                  if (selectedNotes.isNotEmpty)
                    Positioned(
                      top: 1.0,
                      right: 2.0,
                      child: selected
                          ? GlassMorphism(
                              blur: 2,
                              color: ColorsApp.primary,
                              opacity: 0.7,
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SvgPicture.asset(
                                  "assets/svg/check.svg",
                                  // ignore: deprecated_member_use
                                  color: Colors.white,
                                  width: 12,
                                ),
                              ),
                            )
                          : GlassMorphism(
                              blur: 2,
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color!,
                              opacity: 0.25,
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.all(2.0),
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                ),
                              ),
                            ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title ?? S.of(context).tNoTitle,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    // color: color,
                                    fontSize: 18,
                                    fontStyle: note.title == null
                                        ? FontStyle.italic
                                        : FontStyle.normal,
                                  ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          note.content,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  // color: color.withOpacity(0.8),
                                  ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formattedDate,
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
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
