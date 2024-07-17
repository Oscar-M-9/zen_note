import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_notes/app/infra/models/note_model.dart';
import 'package:my_notes/app/ui/shared/glass_morphism.dart';

class CardNote extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final color = Colors.primaries[item % Colors.primaries.length];

    String formattedDate = "";
    if (note.updatedAt != null) {
      formattedDate = DateFormat('dd MMM yyyy').format(note.updatedAt!);
    } else {
      formattedDate = DateFormat('dd MMM yyyy').format(note.createdAt!);
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: 2.0,
        right: 2.0,
        top: 5.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GlassMorphism(
          blur: 10,
          color: color,
          opacity: selected ? 0.4 : 0.1,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              onLongPress: onLongPress,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: color,
                            fontSize: 18,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      note.content,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: color.withOpacity(0.8),
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        formattedDate,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: color.withOpacity(0.8),
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
