import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_notes/generated/l10n.dart';

class EmptyNotes extends StatelessWidget {
  const EmptyNotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/note-text.svg",
            height: 80,
            // ignore: deprecated_member_use
            color: Theme.of(context).textTheme.labelLarge?.color,
          ),
          const SizedBox(height: 10),
          Text(
            S.of(context).tNoNote,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
