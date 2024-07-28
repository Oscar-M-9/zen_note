import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:my_notes/app/config/router/router_name.dart';
import 'package:my_notes/app/infra/models/note_model.dart';
import 'package:my_notes/generated/l10n.dart';

import 'package:my_notes/app/config/theme/colors_app.dart';
import 'package:my_notes/app/presenter/providers/note_state_provider.dart';
import 'package:my_notes/app/presenter/providers/selected_note_provider.dart';

import 'package:my_notes/app/ui/pages/home/widgets/actions_header_button.dart';
import 'package:my_notes/app/ui/pages/home/widgets/float_add_note_button.dart';
import 'package:my_notes/app/ui/pages/home/widgets/list_category_header.dart';
import 'package:my_notes/app/ui/pages/home/widgets/search_input.dart';
import 'package:my_notes/app/ui/pages/home/body_home_view.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    final selectedNotes = ref.watch(selectedNotesProvider);
    final countElement = selectedNotes.length > 1 ? "s" : '';
    final List<Map<String, dynamic>> bottomNav = [
      {
        "name": S.of(context).tMoveTo,
        "icon": "assets/svg/folder-move.svg",
        "onTap": () {
          context.router.pushNamed(RouteName.moveToNote);
        }
      },
      {
        "name": S.of(context).tRemove,
        "icon": "assets/svg/trash.svg",
        "onTap": () {
          _showDeleteNotesDialog(context, selectedNotes, countElement);
        }
      },
    ];

    return KeyboardDismissOnTap(
      child: Scaffold(
        // extendBody: true,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: _MySliverHeaderDelegate(),
              pinned: true,
              floating: true,
            ),
            const BodyHomeView(),
          ],
        ),
        bottomNavigationBar: selectedNotes.isEmpty
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
        floatingActionButton: const FloatAddNoteButton(),
      ),
    );
  }

  Future<dynamic> _showDeleteNotesDialog(
      BuildContext context, Set<Note> selectedNotes, String countElement) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            S.of(context).tDeleteNotes,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        content: Text(
          "${S.of(context).tRemove} ${selectedNotes.length} ${S.of(context).tSelectedItem(countElement)} ",
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
                  ref.read(noteProvider.notifier).deleteNotes(selectedNotes);
                  ref.read(selectedNotesProvider.notifier).clear();
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
}

const _maxHeaderExtent = 250.0;
const _minHeaderExtent = 150.0;

const _maxTitleSize = 40.0;
const _minTitleSize = 30.0;

class _MySliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderExtent;
    final titleSize = (_maxTitleSize * (1 - percent)).clamp(
      _minTitleSize,
      _maxTitleSize,
    );

    const maxMarginTopTitle = 60.0;
    const titleMovementTop = 18.0;
    final topTitleMargin = maxMarginTopTitle - (titleMovementTop * percent);

    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Stack(
        children: [
          _TitleHeader(
            topTitleMargin: topTitleMargin,
            titleSize: titleSize,
          ),
          _BackSelectedNotes(
            topTitleMargin: topTitleMargin,
            titleSize: titleSize,
          ),
          const ActionsHeaderButton(),
          Positioned(
            top: 100,
            right: 0,
            left: 0,
            child: SizedBox(
              child: AnimatedOpacity(
                duration: Durations.medium1,
                opacity: 1 - percent,
                child: const SearchInput(),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ListCategoryHeader(),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => _maxHeaderExtent;

  @override
  double get minExtent => _minHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _TitleHeader extends ConsumerWidget {
  const _TitleHeader({
    required this.topTitleMargin,
    required this.titleSize,
  });

  final double topTitleMargin;
  final double titleSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNotes = ref.watch(selectedNotesProvider);
    final countElement = selectedNotes.length > 1 ? "s" : '';

    return Positioned(
      top: selectedNotes.isEmpty ? topTitleMargin : topTitleMargin + 5,
      left: selectedNotes.isEmpty ? 30 : 60,
      right: 55,
      child: selectedNotes.isEmpty
          ? Text(
              S.of(context).tMyNotes,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: titleSize,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : Text(
              '${selectedNotes.length} ${S.of(context).tSelectedItem(countElement)} ',
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
    );
  }
}

class _BackSelectedNotes extends ConsumerWidget {
  const _BackSelectedNotes({
    required this.topTitleMargin,
    required this.titleSize,
  });

  final double topTitleMargin;
  final double titleSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNotes = ref.watch(selectedNotesProvider);

    return Positioned(
      top: topTitleMargin - 5,
      left: selectedNotes.isEmpty ? 0 : 15,
      child: selectedNotes.isEmpty
          ? Container()
          : SizedBox(
              width: 40,
              child: Focus(
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
                      ref.read(selectedNotesProvider.notifier).clear();
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
