import 'package:flutter/material.dart';
import 'package:my_notes/generated/l10n.dart';

class EmptyNotes extends StatelessWidget {
  const EmptyNotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Text(
          S.of(context).tNoNote,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}
